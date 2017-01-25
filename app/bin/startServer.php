<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/12/17
 * Time: 8:55 AM
 */

use Ratchet\Session\SessionProvider;
use Symfony\Component\HttpFoundation\Session\Storage\Handler;
use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;

//use Models\Dialog;

define('ROOT', dirname(dirname(dirname(__FILE__))));
require ROOT.'/vendor/autoload.php';
$config = require(ROOT.'/app/config/ratchet_host.php');

//сервис кэширования
$memcached = new Memcached();
$memcached->addServer($config['host'], $config['memcachedPort']);

$session = new SessionProvider(
    // класс используюший компоненты message и connection
    new \Controllers\DialogController(),
    new Handler\MemcachedSessionHandler($memcached)
);

// IoSever позволяет принимать, читать и записывать подключения
$server = IoServer::factory(
    // позволяет обрабатывать HTTP запросы. Используется каждый раз,
    // когда пользователь подключается к серверу
    // или отправляет сообщение
    new HttpServer(
        // сервер вебсокетов, позволяет читать и отправлять информацию
        // в режиме реального времени
        new WsServer($session)
    ),
    $config['websocketPort'],
    $config['host']
);

$server->run();
