<?php
/**
 * Created by PhpStorm.
 * User: phpstudent
 * Date: 18.01.17
 * Time: 19:43
 */

namespace Models;

use Core\AbstractDataMapper;

class DialogMapper extends AbstractDataMapper
{
    protected $entityTable = "dialog_rooms";

    public function insert(Dialogs $dialog)
    {
        $dialog->id = $this->adapter->insert(
            $this->entityTable,
            [
                "name"   => $dialog->name,
                "creator_id" => $dialog->creatorId
            ]
        );
        return $dialog->id;
    }

    public function getDialogs($id)
    {
        $dialogs = [];
        $recipientMapper = new RecipientMapper();
        $recipients = $recipientMapper->findAll(['user_id' => $id]);
        foreach ($recipients as $recipient) {
            $dialogs[] = $this->findById($recipient->dialogId);
        }
        return $dialogs;
    }

    protected function createEntity(array $row)
    {
        return new Dialogs(
            $row["name"],
            $row["creator_id"],
            $row["id"]
        );
    }
}
