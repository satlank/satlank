```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/alacritty
```

Also download the terminfo file for `alacritty` and compile it, if it isn't done as part of the installation.

```sh
tic -xe alacritty,alacritty-direct -o $TERMINFO alacritty.info
```
