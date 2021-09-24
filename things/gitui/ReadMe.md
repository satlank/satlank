```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/gitui
```

On Mac gitui doesn't use `XDG_CONFIG_HOME` but `Library/Application Support` instead, so also set a symlink there:

```sh
ln -s ${XDG_CONFIG_HOME}/gitui "${HOME}/Library/Application Support/gitui"
```
