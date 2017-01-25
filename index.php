<?php
/**
 * Created by PhpStorm.
 * User: phpstudent
 * Date: 14.12.16
 * Time: 14:49
 */

ini_set('display_errors', 1);
error_reporting(E_ALL);

//session_start();

define('ROOT', dirname(__FILE__));
require_once ROOT . '/app/config/loader.php';

$app = new \Core\Application();
