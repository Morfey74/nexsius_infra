# nexsius_infra [![Build Status](https://travis-ci.com/otus-devops-2019-02/nexsius_infra.svg?branch=terraform-1)](https://travis-ci.com/otus-devops-2019-02/nexsius_infra)


## HW 8 (terraform-1)
В данной работе мы настроили деплой нашего приложения посредством terraform.
Структура конфигурации:
- main.tf - виртуальная машина, правило firewall, provisioners, ssh-ключи;
- variables.tf - переменные, используемые в main.tf;
- terraform.tfvars - значения, подставляемые в переменные;
- outputs.tf - переменные, значение у которых появляется уже после запуска машин (e.g. IP-адрес)

### Самостоятельные задания
Определите input переменную для приватного ключа, использующегося в определении подключения для провижинеров (connection);
```
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
```

Определите input переменную для задания зоны в ресурсе "google_compute_instance" "app". У нее * должно быть значение по умолчанию*
```
variable "zone" {
  description = "Zone"
  default = "europe-west1-b"
}
```

### Задание со * (стр. 51)
Задание:
Опишите в коде терраформа добавление ssh ключа пользователя appuser1 в метаданные проекта.

Решение:
main.tf:
```
resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "${file(var.public_key_path)}"
}
```

variables.tf:
```
variable "public_key_path" {
  description = "Path to the public key used for ssh access"

}
```

terraform.tfvars:
```
public_key_path = "~/.ssh/appuser.pub"
```

Задание:
Опишите в коде терраформа добавление ssh ключей нескольких пользователей в метаданные проекта (можно просто один и тот же публичный ключ, но с разными именами пользователей, например appuser1, appuser2 и т.д.).

Решение:
main.tf
```
resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }

```

terraform.tfvars:
```
public_key_path = "~/.ssh/appuser.pub"
```

### Задание со * 
Задание:
Добавьте в веб интерфейсе ssh ключ пользователю appuser_web в метаданные проекта. Выполните terraform apply и проверьте результат. Какие проблемы вы обнаружили?

Решение:
Поскольку все ssh-ключи хранятся в одном элементе метаданных проекта, то при попытке внести изменения через Terraform, предыдущие данные удаляются. Соответственно, мы должны использовать только один способ добавления ключей - либо через terraform, либо вручную.

### Задание с ** 
Задание:
Создайте файл lb.tf и опишите в нем в коде terraform создание HTTP балансировщика, направляющего трафик на наше развернутое приложение на инстансе reddit-app.

Решение:
lb.tf

Это решение было основано на примере: https://cloud.google.com/load-balancing/docs/https/content-based-example (вариант с target-pools не рассматривался, т.к. он менее сложен и интересен. Сравнение: https://stackoverflow.com/questions/48895008/target-pools-vs-backend-services-vs-regional-backend-service-difference)
В последовательности для gcloud, оно будет выглядеть следующим образом:
1. Создаем Instance-group.
2. Добавляем Instance в Instance-group
3. Создаём named-порт, по которому балансировщик будет дальше обращаться к instance. При обращении по HTTP, лучше порт назвать http.
4. Создаём HTTP health-check.
5. Создаём backend service. Его функция состоит в том, чтобы измерять производительность и доступность (как самой машины, так и ресурсов) у всех instance в instance group. При необходимости, трафик перенаправляется на другую машину.
Важно:
Если мы выберем протокол HTTP и при этом забудем указать port-name, то backend всё равно автоматически привяжется к порту с именем http, даже если он не существует.
$ gcloud compute backend-services create video-service --protocol HTTP --health-checks reddit-http-basic-check --global --port-name http
6. Добавляем instance group как backend в backend-сервис, при этом указываем режим балансировки и триггер по нагрузке, который в потенциале может использоваться для autoscale.
7. Задаем URL-map для перенаправления входящих запросов к соответствующему backend-сервису. Есть возможность задавать path-rules. В нашем случае, весь трафик, не попавший под остальные url-maps будет уходить к video-service.
8. Создаем target HTTP proxy для перенаправления запросов, соответствующих URL map
9. Создаем правило для перенаправления входящего трафика к нашему прокси. При необходимости, можно в будущем добавить отдельное правило под IPv6 внутри GСP трафик уже в виде IPv4 будет маршрутизироваться).


Задание:
Добавьте в output переменные адрес балансировщика.

Решение:
outputs.tf

### Задание с ** 
Задание:
Добавьте в код еще один terraform ресурс для нового инстанса приложения, например reddit-app2, добавьте его в балансировщик и проверьте, что при остановке на одном из инстансов приложения (например systemctl stop puma), приложение продолжает быть доступным по адресу балансировщика; Добавьте в output переменные адрес второго инстанса; Какие проблемы вы видите в такой конфигурации приложения?

Решение:
Основное неудобство состоит в том, что каждый раз приходится копировать большой объем кода (instance, output-переменные)

### Задание с ** 
Решение:
main.tf
```
resource "google_compute_instance" "app" {
  count        = "${var.number_of_instances}"
  name         = "reddit-app-${count.index}"
  [...]
}
```
=> Здесь основное отличие будет состоять в том, что мы будет к имени автоматически добавлять номер instance через ${count.index}

variables.tf
```
variable "number_of_instances" {
  description = "Number of reddit-app instances (count)"
}
```

terraform.tfvars
```
number_of_instances = 1
```

outputs.tf
```
output "app_external_ip2" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
}
```
=> Чтобы output-переменные генерировались для каждого созданного instance, после указания имени ресурса terraform, необходимо добавить .*. (google_compute_instance.app.*.).


