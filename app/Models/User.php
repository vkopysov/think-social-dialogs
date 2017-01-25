<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/8/17
 * Time: 4:29 PM
 */

namespace Models;

use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\Storage;
use Symfony\Component\HttpFoundation\Session\Storage\NativeSessionStorage;

class User
{
    public $id;

    public $firstName;

    public $middleName;

    public $lastName;

    public $email;

    public $birthday;

    public $sex;

    public $status;

    public $password;

    //protected $session;

    public function __construct($id, $firstName, $middleName, $lastName, $email, $birthday, $sex, $status, $password)
    {
        $this->id = $id;
        $this->firstName = $firstName;
        $this->middleName = $middleName;
        $this->lastName = $lastName;
        $this->email = $email;
        $this->birthday = $birthday;
        $this->sex = $sex;
        $this->status = $status;
        $this->password = $password;
    }

    public function auth($userId)
    {

        $session = User::initSession();
        $session->start();
        $session->set('uid', $userId);


         // $_SESSION['user'] = $userId;
    }

    public static function checkLogged()
    {
        $session = User::initSession();
        $session->start();

        if ($session->get('uid')) {
            return $session->get('uid');
        }
        /*
                if (isset($_SESSION['user'])) {
                    return $_SESSION['user'];
                }
        */
        return false;
    }

    public static function initSession()
    {
        $memcached = new \Memcached();

        $memcached->addServer('think-social-mvc.local', 11211);

        $storage = new NativeSessionStorage([], new Storage\Handler\MemcachedSessionHandler($memcached));
        return new Session($storage);
    }
}
