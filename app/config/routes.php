<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 12/3/16
 * Time: 9:09 AM
 */

return [
    //jquery routes
    'dialog/create' => 'dialog/createDialog',
    'dialog/clearunread' => 'dialog/clearUnreadCounter',
    'dialog/addunread' => 'dialog/addUnreadCounter',
    'dialog/user' => 'dialog/user',
    //ordinary routes
    'dialogs' => 'dialog/show',
    'id-([0-9]+)' => 'user/show/$1',
    'login' => 'user/login',
    'logout' => 'user/logout',
    '404' => 'index/404',
    '' => 'index/show',
];
