# think-social-dialogs
## Обмен сообщениями для учебного проекта ThinkSocial (социальная сеть)
## Необходимая настройка:
###установить memcached
### https://www.globo.tech/learning-center/setup-memcache-ubuntu-16/

## в /etc/php/*version*/apache2/php.ini  добавить строки:
### session.save_handler = memcached
### session.save_path = "*hostname*:11211" (session.save_path = "think-social-mvc.local:11211")
### session.cookie_domain = *hostname* (session.cookie_domain = think-social-mvc.local)

##в /etc/memcached.conf 
### ; Specify which IP address to listen on.
### -l *hostname* (-l think-social-mvc.local)

## в /app/config/ratchet_host.php изменяется имя хоста, порт сокетов и memcached
## в /app/config/db_params.php изменить подключение к базе данных (think_social_db.sql)

## port in ../templates/libs/dialog.js

## Запустить сокет-daemon 
### php startServer.php (bin folder)

##  Что умеет

#### + создание диалога с одним и несколькими пользователями
#### + обмен сообщениями в реальном времени
#### + сохранение диалогов и сообщений в бд
#### + оповещения о непрочитанных сообщениях

## Скриншоты

![1](https://cloud.githubusercontent.com/assets/23549840/22281519/0616ee3a-e2e0-11e6-8215-8936f58d1bd0.JPG)
![2](https://cloud.githubusercontent.com/assets/23549840/22281523/064d37ce-e2e0-11e6-9189-774787264228.JPG)
![3](https://cloud.githubusercontent.com/assets/23549840/22281524/065488f8-e2e0-11e6-9cb3-f870fb75ccad.JPG)
![4](https://cloud.githubusercontent.com/assets/23549840/22281522/064cf002-e2e0-11e6-8acc-fa77659406ce.JPG)
![5](https://cloud.githubusercontent.com/assets/23549840/22281525/0656985a-e2e0-11e6-9ac1-2abfde6f82e3.JPG)
![6](https://cloud.githubusercontent.com/assets/23549840/22281526/0685bc66-e2e0-11e6-8339-53f73dd0cec3.JPG)
![7](https://cloud.githubusercontent.com/assets/23549840/22281521/063b0748-e2e0-11e6-8600-1c07ffb64faf.JPG)
