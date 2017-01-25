<?php
/**
 * Created by PhpStorm.
 * User: phpstudent
 * Date: 18.01.17
 * Time: 19:37
 */

namespace Models;

class Dialogs
{
    public $id;

    public $name;

    public $creatorId;

    public function __construct($name, $creatorId, $id = null)
    {
        if ($id) {
            $this->id = $id;
        }
        $this->name = $name;
        $this->creatorId = $creatorId;
    }


}
