# sweeper madness

`sweeper madness` is a game about curling.

![screenshot](/sweeper-madness.gif)

## Requirements

Qt5

For Ubuntu or Debian, run:

```bash
$ sudo apt install build-essential qtbase5-dev qt5-default
$ sudo apt install qtdeclarative5-dev
$ sudo apt install qml-module-qtquick2 qml-module-qtquick-window2
$ sudo apt install qml-module-qtgraphicaleffects
$ sudo apt install libcanberra-gtk-module 
```

## Building

To build it, on Ubuntu or Debian, run:

```bash
$ qmake
$ make
```

## Running

```bash
$ ./sweeper-madness
```

## Playing

The game can be played using touch buttons or using the following keyboard keys:

- First, use RIGHT and LEFT arrows to move the launcher on the starting line.
- Validate his postion using SPACE key.
- Then, validate the direction of the throw using SPACE key, once again.
- And validate the power of the throw using SPACE key, one more time.
- Finallly, press RIGHT and LEFT arrows to sweep repectively left and right.
