<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 12/25/16
 * Time: 10:58 AM
 */

namespace Models;

use \Core\AbstractDataMapper;
use \Models\User;

class UserMapper extends AbstractDataMapper
{
    protected $entityTable = "users";

    public function insert(User $user)
    {
        $user->id = $this->adapter->insert(
            $this->entityTable,
            array("first_name"  => $user->firstName,
                "middle_name" => $user->middleName,
                "last_name" => $user->lastName,
                "email" => $user->email,
                "birthday" => $user->birthday,
                "sex" => $user->sex,
                "status" => $user->status,
                "password" => $user->password,
            )
        );
        return $user->id;
    }

    public function checkUserData($email, $password)
    {
        $this->adapter->select(
            $this->entityTable,
            array('email' => $email,
                'password' => $password
            )
        );

        if (!$row = $this->adapter->fetch()) {
            return null;
        }

        return $this->createEntity($row);
    }

    public function delete($id)
    {
        if ($id instanceof User) {
            $id = $id->id;
        }

        return $this->adapter->delete($this->entityTable, array("id = $id"));
    }

    protected function createEntity(array $row)
    {
        return new User(
            $row["id"],
            $row["first_name"],
            $row["middle_name"],
            $row["last_name"],
            $row["email"],
            $row["birthday"],
            $row["sex"],
            $row["status"],
            $row["password"]
        );
    }

}