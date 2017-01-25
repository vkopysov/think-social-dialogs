<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/12/17
 * Time: 8:23 PM
 */

namespace Models;

use Core\AbstractDataMapper;

class FriendMapper extends AbstractDataMapper
{
    protected $entityTable = "friends";

    public function getUserFriends($id)
    {
        $friendIds = [];
        $this->adapter->select($this->entityTable, ['user_sender' => $id,
            'status' => 'applied']);
        $rows = $this->adapter->fetchAll();
        if ($rows) {
            foreach ($rows as $row) {
                $friendIds[] = $row['user_receiver'];
            }
        }
        $this->adapter->select($this->entityTable, ['user_receiver' => $id,
            'status' => 'applied']);
        $rows = $this->adapter->fetchAll();
        if ($rows) {
            foreach ($rows as $row) {
                if (!in_array($row['user_sender'], $friendIds)) {
                    $friendIds[] = $row['user_sender'];
                }
            }
        }
        return $friendIds;
    }

    public function getFriends($id)
    {
        $friendIds = $this->getUserFriends($id);
        $userMapper = new UserMapper();
        foreach ($friendIds as $friendId) {
            $friends[] = $userMapper->findById($friendId);
        }
        return $friends;
    }

    protected function createEntity(array $row)
    {
        return new Friend(
            $row["user_sender"],
            $row["user_receiver"],
            $row["status"]
        );
    }

}