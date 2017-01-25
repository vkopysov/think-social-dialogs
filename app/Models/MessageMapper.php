<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/21/17
 * Time: 12:52 PM
 */

namespace Models;

use Core\AbstractDataMapper;

class MessageMapper extends AbstractDataMapper
{
    protected $entityTable = "messages";

    public function insert(Message $message)
    {
        $message->id = $this->adapter->insert(
            $this->entityTable,
            [
                "sender_id"   => $message->senderId,
                "dialog_room_id" => $message->dialogId,
                "text" => $message->text
            ]
        );
        return $message->id;
    }

    protected function createEntity(array $row)
    {
        return new Message(
            $row["sender_id"],
            $row["dialog_room_id"],
            $row["text"],
            $row["created_at"],
            $row["id"]
        );
    }
}
