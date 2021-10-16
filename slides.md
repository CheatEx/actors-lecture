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
## Threads-locks problems

* Data races

[comment]: # (!!!)
## Threads-locks problems

* Possible deadlocks

[comment]: # (!!!)
## Threads-locks problems

* CPU under-utilisation

[comment]: # (!!!)
## Threads-locks problems

* Waste on synchronisation and scheduling

[comment]: # (!!!)
## Actor solution

* Make threads isolated
* Restrict communications

...but decrease cost?

[comment]: # (!!!)
## Actor: constraints

Actor is isolated process with own execution flow

[comment]: # (!!!)
## Actor: constraints

Actor has identity

[comment]: # (!!!)
## Actor: constraints

Actors can’t interfere with each other memory

[comment]: # (!!!)
## Actor: constraints

Every actor has a message box


[comment]: # (!!!)
## Actor: constraints

Actor can send messages to another using identity

[comment]: # (!!!)
## Actor: constraints

Actor can receive message with explicit query
