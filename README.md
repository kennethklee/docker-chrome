Run chrome.

First Run:

```shell
docker run -d --name chrome -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix kennethkl/chrome
```

Subsequent Run:

```shell
docker start chrome
```