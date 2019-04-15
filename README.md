# nexsius_infra [![Build Status](https://travis-ci.com/otus-devops-2019-02/nexsius_infra.svg?branch=terraform-2)](https://travis-ci.com/otus-devops-2019-02/nexsius_infra)

#HW 10
## Сделано:

* Установлен ansible
* созданы:
  * конфигурационый файл
  * inventory хостов в 3 форматах
  * в inventory созданы группы хостов
  * создан playbook для клонирования приложения

## Дополнительный вопрос

При удалении на хосте директории склонированного приложения и повторном запуске playbook, директория восстанавливается, в статусе ansible changed=1

