# linux faq base

## попытка изолировать приложение в линукс от сети

изучил все возможные пути, через пространство имен и control groups можно блокировать сеть для уже запущенных процессов
самый оптимальный через приложение firejail
firejail --net=none 'app_name' &

чтобы это каждый раз не писать можно создать алиас или функцию в bashrc
Открыть bashrc
nano ~/.bashrc

пытался создать алиас терминал выдавал что для алиаса слишком сложная команда
тогда создал функцию в этом же файле

code_none_net()
    {
     	firejail --net=none code &
    }

Далее в терминале пишу code_none_net и запускается vs_code через приложение firefail (в изоляции) с параметром --net=none (без сети)

## подеержка heic в линукс

на компе стандартный просмотрщик изображений eye-of-mate начал открывать hiec после установки heif-pixbuf-loader

reddit:
Yes, 'eye-of-mate' is quite good.
Will need to add 'heic' support for the goofy Apple format - the 'heif-pixbuf-loader' package.

также на компе установлен стандартно был пакет libheif

libheif-devel не пригодился

## установка сертификата эп в линукс

