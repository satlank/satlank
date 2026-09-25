Create symlinks to dotfile locations:

```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/nv3
# Plain `nvim` uses the same config (with its own plugin and data dirs)
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/nvim
```

Start it with `nv3` (`things/bash/config/bin/nv3`), which sets
`NVIM_APPNAME=nv3`.
