<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/12/17
 * Time: 8:22 PM
 */

namespace Models;

class Friend
{
    public $sender;

    public $receiver;

    public $status;

    public function __construct($sender, $receiver, $status)
    {
        $this->sender = $sender;
        $this->receiver = $receiver;
        $this->status = $status;
    }
}
