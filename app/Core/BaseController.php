<?php
/**
 * Created by PhpStorm.
 * User: sparrow
 * Date: 1/8/17
 * Time: 1:48 AM
 */

namespace Core;

abstract class BaseController
{
    /**
     * Объект представления
     * @var
     */
    protected $view;

     /**
     * Метод формирует представление для контроллера
     * @param string $template
     * @param array|null $data
     */
    protected function loadView($template = 'main', array $data = null)
    {
        try {
            $this->view = new View($template, $data);
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    /**
     * Метод формирует подшлаблон представления
     * @param $subtemplate
     * @param array|null $data
     */
    protected function loadBlock($subtemplate, array $data = null)
    {
        try {
            $this->view->block($subtemplate, $data);
        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    /*
     * Подключение представления
     */
    protected function display()
    {
        $this->view->render();
    }
}
