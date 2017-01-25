<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/19/17
 * Time: 2:21 PM
 */

namespace Models;

class Recipient
{
    public $id;

    public $userId;

    public $dialogId;

    public $unreadCounter;

    public function __construct($userId, $dialogId, $unreadCounter = null, $id = null)
    {
        if ($id) {
            $this->id = $id;
        }
        if ($unreadCounter) {
            $this->unreadCounter = $unreadCounter;
        }

        $this->userId = $userId;
        $this->dialogId = $dialogId;
    }

}
