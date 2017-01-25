<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/19/17
 * Time: 2:23 PM
 */

namespace Models;

use Core\AbstractDataMapper;

class RecipientMapper extends AbstractDataMapper
{
    protected $entityTable = "recipients";

    public function insert(Recipient $recipient)
    {
        $recipient->id = $this->adapter->insert(
            $this->entityTable,
            [
                "user_id"   => $recipient->userId,
                "dialog_room_id" => $recipient->dialogId
            ]
        );
        return $recipient->id;
    }

    public function addUnreadCounter($userId, $dialogId)
    {
        $this->adapter->select(
            $this->entityTable,
            array('user_id' => $userId,
                'dialog_room_id' => $dialogId
            )
        );

        if (!$row = $this->adapter->fetch()) {
            return null;
        }

        $recipient = $this->createEntity($row);

        $unreadCounter = $recipient->unreadCounter;
        $unreadCounter++;
        $this->adapter->update(
            $this->entityTable,
            [
                "unread_counter" => $unreadCounter
            ],
            "user_id = $userId AND dialog_room_id = $dialogId"
        );

        return $recipient->id;
    }

    public function clearUnreadCounter($userId, $dialogId)
    {
        $unreadCounter = 0;
        $this->adapter->update(
            $this->entityTable,
            [
                "unread_counter" => $unreadCounter
            ],
            "user_id = $userId AND dialog_room_id = $dialogId"
        );
    }


    protected function createEntity(array $row)
    {
        return new Recipient(
            $row["user_id"],
            $row["dialog_room_id"],
            $row["unread_counter"],
            $row["id"]
        );
    }
}
