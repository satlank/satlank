# Configurations

This is the collection of my dotfiles as they have accumulated and evolved over the decades.  A lot of the actual configurations are inspired from reading other people's configurations, partly in settings, partly in structuring.

I am generally trying to put all configurations into the `XDG_*` directories (that mostly means `~/.config/`), which occasionally means an extra layer of symlinks.

Configurations for individual applications are found in `things/`, and the basic idea is to have this repository checked out somewhere and then symlink from the actual locations into the corresponding path in the repository structure.  I am not too happy with that, as it is a step back from my previous setup (which was layering multiple `vcsh` repos), but has the benefit of consolidating everything in one place.

Feel free to take whatever bits appear useful to your configuration (as I have done as well).

## History

### October 2024

I have been using this setup for a while now and it survived a few machine changes.  Having everything in one repository certainly has made things a bit easier.  The manual symlinking required to get a new machine going is an annoyance, but it has not crossed the threshold of actually wanting to do something about it.

As a new addition, I have started to maintain a [changelog](CHANGELOG.md).  This is automatically generated by [`git-cliff`](https://git-cliff.org/), useful commands to run there are (because I keep forgetting):

```sh
# Show all changes since the last tag
git cliff --unreleased

# Update the changelog for a new release:
git cliff --unreleased --tag $(git cliff --bumped-version) --prepend CHANGELOG.md
```

### May 2020

First incarnation of this repository, combining several previous locations and taking lots of inspiration (and settings) from [wincent](https://github.com/wincent/wincent).  Also re-implementing the Vim configuration entirely and taking the opportunity to test [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

### 2014-2020

Heavy use of [vcsh](https://github.com/RichiH/vcsh) to structure dotfiles and various attempts at improving vim and bash configurations.

### 2003-2014

Some experimentation with tracking configuration in `svn`, but mostly just living dotfiles that survived the odd hardware changes by being copied over in time; also manually copying and syncing around changes via `scp`/`rsync`.

### Pre-2003

Let's not go there.
