Create symlinks:

```sh
ln -s ${PWD}/config ${HOME}/.ssh
```

Also create a `$HOME/.ssh/config.local` which should be used to add machine specific configuration:

```sh
touch ${HOME}/.ssh/config.local
chmod 600 ${HOME} config.local
```
