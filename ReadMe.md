# Configurations

This is collection of my dotfiles as they have accumulated and evolved over the decades.  A lot of the actual configurations are inspired from reading other people's configurations, partly in settings, partly in structuring.

I am generally trying to put all configurations into the `XDG_*` directories (that mostly means `~/.config/`), which occasionally means an extra layer of symlinks.

Configurations for individual applications are found in `things/`, and the basic idea is to have this repository checked out somewhere and then symlink from the actual locations into the corresponding path in the repository structure.  I am not too happy with that, as it is a step back from my previous setup (which was layering multiple `vcsh` repos), but has the benefit of consolidating everything in one place.

Feel free to take whatever bits appear useful to your configuration (as I have done as well).

## History

### May 2020

First incarnation of this repository, combining several previous locations and taking lots of inspiration (and settings) from [wincent](https://github.com/wincent/wincent).  Also re-implementing the Vim configuration entirely and taking the opportunity to test [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### 2014-2020

Heavy use of [vcsh](https://github.com/RichiH/vcsh) to structure dotfiles and various attempts at improving vim and bash configurations.

### 2003-2014

Some experimentation with tracking configuration in `svn`, but mostly just living dotfiles that survived the odd hardware changes by being copied over in time; also manually copying around changes via `scp`.

### Pre-2003

Let's not go there.
