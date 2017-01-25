<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/21/17
 * Time: 12:52 PM
 */

namespace Models;

class Message
{
    public $id;

    public $senderId;

    public $dialogId;

    public $text;

    public $time;

    public function __construct($senderId, $dialogId, $text, $time = null, $id = null)
    {
        if ($id) {
            $this->id = $id;
        }
        if ($time) {
            $this->time = $time;
        }

        $this->senderId = $senderId;
        $this->dialogId = $dialogId;
        $this->text = $text;
    }
}
