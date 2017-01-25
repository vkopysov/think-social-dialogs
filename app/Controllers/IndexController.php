<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 12/3/16
 * Time: 7:07 AM
 */
namespace Controllers;

use Core\BaseController;
use Models\User;

class IndexController extends BaseController
{
    /**
     * @return View
     */
    public function actionShow()
    {
        if ($id = User::checkLogged()) {
            header("Location: /id-$id");
        } else {
            header("Location: /login ");
        }

        $this->loadView('index');
        $this->loadBlock('indexHeader');
        $this->display();
    }


    public function action404()
    {
        header("HTTP/1.0 404 Not Found");
        echo '404 not found';
      //  die();
    }
}
