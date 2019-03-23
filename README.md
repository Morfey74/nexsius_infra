# nexsius_infra

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

Startup script для GCP - startup.sh:
```
gcloud compute instances create reddit-app\
 --metadata-from-file startup-script=startup.sh \
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure
```

Удаление и создание правил:
```
gcloud compute firewall-rules delete default-puma-server
gcloud compute firewall-rules create default-puma-server1 --target-tags='puma-server' --allow=tcp:9292
```

```conf
bastion_IP = 35.195.225.176
someinternalhost_IP = 10.132.0.4
testapp_IP = 35.228.63.139
testapp_port = 9292
```



