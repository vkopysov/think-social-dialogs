# think-social-dialogs
## Обмен сообщениями для учебного проекта ThinkSocial (социальная сеть)
## Необходимая настройка:
###установить php-memcache, php-memcached

## в /etc/php/*version*/apache2/php.ini  добавить строки:
### session.save_handler = memcached
### session.save_path "*hostname*:11211" (session.save_path "think-social-mvc.local:11211")
### session.cookie_domain = *hostname* (session.cookie_domain = think-social-mvc.local)

##в /etc/memcached.conf 
### ; Specify which IP address to listen on.
### -l *hostname* (-l think-social-mvc.local)

## в /app/config/ratchet_host.php изменяется имя хоста, порт сокетов и memcached
## в /app/config/db_params.php изменить подключение к базе данных (think_social_db.sql)

## port in ../templates/libs/dialog.js


#### + создание диалога с одним и несколькими пользователями
#### + обмен сообщениями в реальном времени
#### + сохранение диалогов и сообщений в бд
#### + оповещения о непрочитанных сообщениях

## Скриншоты
