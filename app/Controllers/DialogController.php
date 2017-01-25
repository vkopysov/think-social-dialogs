<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/12/17
 * Time: 8:06 AM
 */

namespace Controllers;

use Core\BaseController;
use Models\DialogMapper;
use Models\Dialogs;
use Models\FriendMapper;
use Models\Message;
use Models\MessageMapper;
use Models\Recipient;
use Models\RecipientMapper;
use Models\User;
use Models\UserMapper;

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

class DialogController extends BaseController implements MessageComponentInterface
{
    protected $clients;

    protected $updatedRecipient;

    public function __construct()
    {
        $this->clients = [];
    }

    /* Ratchet actions */

    /**
     * Метод вызывается при выполнении подключения
     * @param ConnectionInterface $conn
     */
    public function onOpen(ConnectionInterface $conn)
    {
        //сохраняем новое подключение
        $conn->Session->start();
        $this->clients[$conn->Session->get('uid')] = $conn;


        echo "User: " . $conn->Session->get('uid') . " connected\n";
        //print_r($conn->Session);
    }

    /**
     * Метод вызывается при отправке сообщения
     * @param ConnectionInterface $from
     * @param string $msg
     */
    public function onMessage(ConnectionInterface $from, $msg)
    {
        echo $msg;
        $this->updatedRecipient = [];
        $message = json_decode($msg, true);
        $messageEntity = new Message($message['userId'], $message['roomId'], $message['text']);
        $messageMapper = new MessageMapper();
        $messageMapper->insert($messageEntity);
        $recipientMapper = new RecipientMapper();
        $recipients = $recipientMapper->findAll(['dialog_room_id' => $message['roomId']]);
        foreach ($this->clients as $userId => $client) {
            foreach ($recipients as $recipient) {
                if ($from !== $client) {
                    if (($message['userId'] != $recipient->userId)
                        && (!in_array($recipient->userId, $this->updatedRecipient))) {
                        $updatedRecipient =  $recipientMapper->addUnreadCounter($recipient->userId, $recipient->dialogId);
                        $this->updatedRecipient[] =  $updatedRecipient;
                    }

                    if ($userId == $recipient->userId) {
                        $client->send($msg);
                    }
                }
            }
        }
    }

    /**
     * Метод вызывается при закрытии подключения
     * @param ConnectionInterface $conn
     */
    public function onClose(ConnectionInterface $conn)
    {
        unset($this->clients[$conn->Session->get('uid')]);
        echo "User " . $conn->Session->get('uid') . " has disconnected\n";
    }

    /**
     * Метод вызывается при ошибке подключения
     * @param ConnectionInterface $conn
     * @param \Exception $e
     */
    public function onError(ConnectionInterface $conn, \Exception $e)
    {
        echo "An error has occurred: {$e->getMessage()}\n";
        $conn->close();
    }

    /*Origin actions*/

    public function actionShow()
    {
        if ($id = User::checkLogged()) {
            $friendMapper = new FriendMapper();
            $friends = $friendMapper->getFriends($id);

            $dialogMapper = new DialogMapper();
            $dialogs = $dialogMapper->getDialogs($id);

            $messages = [];
            $users = [];
            $dialogRecipients = [];
            $unreadCounter = 0;
            $recipientMapper = new RecipientMapper();
            $userMapper = new UserMapper();
            $messageMapper = new MessageMapper();

            foreach ($dialogs as $dialog) {
                $messages[$dialog->id] = $messageMapper->findAll(['dialog_room_id' => $dialog->id]);
                $dialogRecipients[$dialog->id] = $recipientMapper->findAll(['dialog_room_id' => $dialog->id]);

                foreach ($dialogRecipients[$dialog->id] as $dialogRecipient) {
                    $users[$dialog->id][$dialogRecipient->userId] = $userMapper->findById($dialogRecipient->userId);
                    if ($id == $dialogRecipient->userId) {
                        $unreadCounter += $dialogRecipient->unreadCounter;
                    }
                }
            }

            $loggedUser = $userMapper->findById($id);

        } else {
            header("Location: /login ");
        }

        $this->loadView(
            'dialog',
            ['loggedUser' => $loggedUser,
            'friends' => $friends,
            'dialogs' => array_reverse($dialogs),
            'messages' => $messages,
            'dialogRecipients' => $dialogRecipients,
            'users' => $users,
            ]
        );
        $this->loadBlock(
            'userHeader',
            [
                'unreadCounter' => $unreadCounter,
                'loggedUser' => $loggedUser
            ]
        );
        $this->loadBlock('footer');
        $this->display();
    }

    /* jquery ajax actions */

    public function actionClearUnreadCounter()
    {
        $recipientMapper = new RecipientMapper();
        if ($id = User::checkLogged()) {
            if (isset($_POST['clearUnread'])) {
                $recipientMapper->clearUnreadCounter($id, $_POST['roomId']);
            }
        } else {
            header("Location: /login ");
        }
    }

    public function actionAddUnreadCounter()
    {
        $recipientMapper = new RecipientMapper();
        if ($id = User::checkLogged()) {
            $recipient = $recipientMapper->findAll([
                'user_id' => $_POST['userId'],
                'dialog_room_id' => $_POST['dialogId']
            ]);
            echo json_encode(
                ["unreadCounter" => $recipient[0]->unreadCounter]
            );
        } else {
            header("Location: /login ");
        }
    }

    public function actionCreateDialog()
    {
        $dialogMapper = new DialogMapper();
        $recipientMapper = new RecipientMapper();
        if ($id = User::checkLogged()) {
            if (isset($_POST)) {
                $dialog = new Dialogs($_POST['dialogName'], $id);
                $dialog->id  = $dialogMapper->insert($dialog);
                echo $dialog->id;
                $recipient = new Recipient($id, $dialog->id);
                $recipientMapper->insert($recipient);
                foreach ($_POST['friendIds'] as $userId) {
                    $recipient = new Recipient($userId, $dialog->id);
                    $recipientMapper->insert($recipient);
                }
            }
        } else {
            header("Location: /login ");
        }
    }

    public function actionUser()
    {
        if ($id = User::checkLogged()) {
            $userMapper = new UserMapper();
            $user = $userMapper->findById($id);
            echo json_encode(
                array("id" => $user->id,
                    "firstName"  => $user->firstName,
                    "middleName" => $user->middleName,
                    "lastName" => $user->lastName
                )
            );
        } else {
            header("Location: /login ");
        }
    }
}
