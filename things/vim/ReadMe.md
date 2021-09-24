Create symlinks to dotfile locations:

```sh
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/vim
ln -s ${PWD}/config ${XDG_CONFIG_HOME}/nvim
ln -s ${XDG_CONFIG_HOMW}/vim ~/.vim
```

Create directories for temp/backup/etc files:

```sh
mkdir -p "$XDG_DATA_HOME"/vim/{undo,swap,backup}
```


## Deoplete/Language Server Completions

To use `deoplete` the neovim python package needs to be available, e.g. `pip3
install neovim` or `conda install pynvim`.

For the language servers we need

### Python
* `pyls` (`conda install python-language-server[all]` - drop the `[all]` for a basic installation)

### Rust
* [Rust Analyzer](link:https://rust-analyzer.github.io/) - simply get it from [the download page](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
