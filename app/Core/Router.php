<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 12/3/16
 * Time: 8:36 AM
 */

namespace Core;

/*
 * Класс маршрутизации
 */
class Router
{

    /**
     * Конфигурация маршрутов
     * @var mixed
     */
    private $routes;

     /**
     * Router constructor.
     * Метод получает конфигурацию из файла.
     */
    public function __construct()
    {
        $routesPath = ROOT.'/app/config/routes.php';
        if (file_exists($routesPath)) {
            $this->routes = include($routesPath);
        } else {
            throw new \Exception("file $routesPath not found");
        }
    }

    /**
     * Метод получает URI
     * @return string
     */
    public function getURI()
    {
        if (!empty($_SERVER['REQUEST_URI'])) {
            return trim($_SERVER['REQUEST_URI'], '/');
        }
    }

     /**
     * Метод ищет и формирует внутренний маршрут по uri
     * @param $uri
     * @return array Элементы  внутреннего маршрута: controller, action, action parameters |bool
     */
    public function matchRoute($uri)
    {
        foreach ($this->routes as $route => $segments) {
            if (!($route == '' && $uri != '')) {
                //Сравнение маршрута и uri
                if (preg_match("~$route~", $uri)) {
                    // Подстановка параметров в маршрут | pattern(), replacement, string
                        $internalRoute =  preg_replace("~$route~", $segments, $uri);
                        return explode('/', $internalRoute);
                }
            }
        }
        return false;
    }

    /**
     *  Метод вызывает контроллер и экшн с параметрами, если те существуют
     * @return bool
     * @throws \Exception
     */
    public function dispatch()
    {
        $uri = $this->getURI();
        if ($routeSegments = $this->matchRoute($uri)) {
            $namespace =  '\Controllers\\';
            $controller = $namespace.ucfirst(array_shift($routeSegments)).'Controller';
            $action = 'action'.ucfirst(array_shift($routeSegments));
            $parameters = $routeSegments;
            if (class_exists($controller)) {
                $controllerObject = new $controller;
                // вызов контроллера
                if (is_callable(array($controllerObject, $action))) {
                    call_user_func_array(array($controllerObject, $action), $parameters);
                    return true;
                } else {
                    throw new \Exception("Method $action (in controller $controller) not found");
                }
            } else {
                throw new \Exception("Controller class $controller not found");
            }
        }
            return false;
    }
}
