<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/8/17
 * Time: 2:39 PM
 */

namespace Controllers;

use Core\BaseController;
use Models\User;
use Models\UserMapper;
///
use Models\DialogMapper;
use Models\Dialogs;
use Models\FriendMapper;
use Models\Message;
use Models\MessageMapper;
use Models\Recipient;
use Models\RecipientMapper;

class UserController extends BaseController
{

    public function actionShow($id)
    {
        $userMapper = new UserMapper();
        $user = $userMapper->findById($id);
        if ($user) {
            if ($id = User::checkLogged()) {
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
            }

            $this->loadView('user');

            $this->loadBlock('profile', [
                'fullname' => $user->firstName . ' ' .
                    $user->middleName . ' ' .
                    $user->lastName,
                'email' => $user->email,
                'birthday' => $user->birthday
            ]);
            $this->loadBlock(
                'userHeader',
                [
                    'unreadCounter' => $unreadCounter,
                    'loggedUser' => $loggedUser
                ]
            );
            $this->loadBlock('footer');
            $this->display();
        } else {
            header("Location: /404");
        }
    }

    public function actionLogin()
    {
        $userMapper = new UserMapper();
        $errors = array();

        if (isset($_POST['submit'])) {
            $email = $_POST['email'];
            $password = $_POST['password'];

            $user = $userMapper->checkUserData($email, $password);
            if ($user) {
                $user->auth($user->id);
                header("Location: /id-$user->id");
            } else {
                $errors[] = "Data isn't correct or user doesn't exist";
            }
        }
            $this->loadView('login', ['errors' => $errors ]);
            $this->loadBlock('indexHeader');
            $this->display();
    }

    public function actionLogout()
    {
       // unset($_SESSION["user"]);
        $session = User::initSession();
        $session->start();
        $session->remove('uid');
        header("Location: /");
    }
}
