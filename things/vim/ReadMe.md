Create symlinks to dotfile locations:

```
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/vim
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/nvim
ln -s ${XDG_CONFIG_HOMW}/vim ~/.vim
```

Create directories for temp/backup/etc files:

```
mkdir -p "$XDG_DATA_HOME"/vim/{undo,swap,backup}
```
