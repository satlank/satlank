Create symlinks to dotfile locations:

```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/gnupg
```

## Notes
* Permissions on `config` need to be restrictive, ie. `0700`, otherwise `gnupg` complains.
* When setting up a new machine, you will need to `gpg --import pubkeyfile.asc` the public key first and then edit the trust db to mark it as ultimately trusted.
* Make sure the correct program for `pinentry` is selected in `gpg-agent.conf` if necessary - it should pick something sensible for each system it is installed on, but it can be set explicitly on the configuration if the automagical detection goes wrong.
