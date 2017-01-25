<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 12/17/16
 * Time: 2:32 PM
 */

namespace Core;

class Application
{
    /**
     * @var Router
     */
    protected $router;

    /**
     * Cоздаем объект маршрутизатора и вызываем диспетчер
     * Application constructor.
     */
    public function __construct()
    {
        try {
            $this->router = new \Core\Router();
            if (!$this->router->dispatch()) {
                $this->redirect('404');
            }
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    public function redirect($path)
    {
        header("Location: /$path");
    }

}
