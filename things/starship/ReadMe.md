```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/starship
```

Need to also set `STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml` otherwise `starhsip` will look for `${XDG_CONFIG_HOME}/starship.toml`.
