[comment]: # (Set the theme:)
[comment]: # (THEME = simple)
[comment]: # (CODE_THEME = zenburn)
[comment]: # (The list of themes is at https://revealjs.com/themes/)
[comment]: # (The list of code themes is at https://highlightjs.org/)

[comment]: # "You can also use quotes instead of parenthesis"
[comment]: # "THEME = white"

[comment]: # (Pass optional settings to reveal.js:)
[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (Other settings are documented at https://revealjs.com/config/)


# Actor model
Alexey Zlobin | Dell-EMC

[comment]: # (!!!)
## Многопоточность с разделяемой памятью

Удобно?

[comment]: # (!!!)
## Многопоточность с разделяемой памятью

~~Удобно?~~

* Недерменизм
* Дэдлоки
* Ливлоки
* Голодания
* Недоиспользование CPU
* Плохая масштабируемость
* Накладные расходы на синхронизацию и планирование

[comment]: # (!!!)
## Многопоточность с разделяемой памятью

~~Удобно?~~

* Ограничить взаимодействие потоков
* Абстрагироваться от аппаратной реализации

[comment]: # (!!!)
## Модель акторов

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - процесс с идентичностью, потоком исполнения и состоянием

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - имеет уникальный адрес для отправки ему сообщений

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - может создавать новые акторы, получая их адреса

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - может отправлять сообщения другим акторам адреса которых сам знает

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - может изменить своё состояние реагируя на пришедшее сообщение

[comment]: # (!!!)
## Модель акторов: ограничения

Актор - может изменить своё состояние реагируя на пришедшее сообщение

[comment]: # (!!!)
## Модель акторов: следствия

Актор может менять своё состояние без координации с другими

[comment]: # (!!!)
## Модель акторов: следствия

Актор не обязан останавливать выполнение для коммуникации

[comment]: # (!!!)
## Модель акторов: следствия

Среда выполнения может останавливать и запускать акторы независимо

[comment]: # (!!!)
## Модель акторов: следствия

Среда выполнения может эффективно управлять ресурсами вместо акторов

[comment]: # (!!!)
## Модель акторов: следствия

Среда выполнения может сохранять работоспособность при потере одиночных акторов

[comment]: # (!!!)
## Наивная реализация

[comment]: # (!!!)
## Безопасная реализация с виртуализацией

* Планирования
* Управления памятью
* Коммуникации
* Ввода-вывода

[comment]: # (!!!)
## References

- Gul Agha; Ian Mason; Scott Smith; Carolyn Talcott. A Foundation for Actor Computation. Journal of Functional Programming, 1993
- Robert Virding. Hitchhiker's Tour of the BEAM. Erlang User Conference, 2014
- Joe Armstrong. Making reliable distributed systems in the presence ofsodware errors. Dissertation, 2003