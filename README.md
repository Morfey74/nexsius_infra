# nexsius_infra [![Build Status](https://travis-ci.com/otus-devops-2019-02/nexsius_infra.svg?branch=master)](https://travis-ci.com/otus-devops-2019-02/nexsius_infra)
nexsius Infra repository

Подключение к bastion:
```console
ssh -i ~/.ssh/id_rsa nexs@35.205.160.30
```

Подключение к someinternalhost одной командой (сквозное подключение):
```console
ssh -t -i ~/.ssh/id_rsa -A  nexs@35.205.160.30 ssh 10.132.0.3
```
либо внести в ~/.ssh/config следующие настройки:

<pre>
Host bastion
    Hostname 35.195.225.176
    User nexs
    IdentityFile ~/.ssh/id_rsa
    ForwardAgent yes
Host someinternalhost
    Hostname 10.132.0.4
    User nexs
    ProxyCommand ssh -W %h:%p bastion
</pre>

```conf
bastion_IP = 35.195.225.176
someinternalhost_IP = 10.132.0.4
```


