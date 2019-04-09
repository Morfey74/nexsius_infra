# nexsius_infra [![Build Status](https://travis-ci.com/otus-devops-2019-02/nexsius_infra.svg?branch=terraform-1)](https://travis-ci.com/otus-devops-2019-02/nexsius_infra)


## Сделано:
При пересоздании ресурса будут заменены все метаданные с указанным ключом в проекте, поэтому добавление ключa appuser-web через веб интерфейс и последующий запуск terraform apply удалит ключ appuser-web из проекта.

```conf
bastion_IP = 35.195.225.176
someinternalhost_IP = 10.132.0.4
testapp_IP = 35.228.63.139
testapp_port = 9292
```



