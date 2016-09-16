[![Build Status](https://travis-ci.org/awendt/poet.svg?branch=master)](https://travis-ci.org/awendt/poet)
[![Gem Version](https://badge.fury.io/rb/poet.svg)](http://badge.fury.io/rb/poet)
[![Dependency Status](https://gemnasium.com/awendt/poet.svg)](https://gemnasium.com/awendt/poet)

# Native support in OpenSSH 7.3

[OpenSSH 7.3](http://www.openssh.com/txt/release-7.3) was released on August 1, 2016.
That version features an `Include` directive for ssh_config(5) files which is
[documented as follows](http://man.openbsd.org/ssh_config):

> Include the specified configuration file(s). Multiple pathnames may be specified
> and each pathname may contain glob(3) wildcards and, for user configurations,
> shell-like “~” references to user home directories. Files without absolute paths are
> assumed to be in ~/.ssh if included in a user configuration file or /etc/ssh if
> included from the system configuration file. Include directive may appear inside a
> Match or Host block to perform conditional inclusion.

This covers most use cases `poet` was designed for.

## What does this all mean?

I might stop maintaining poet in the future.
Feel free to reach out to convince me otherwise.

---

# Split your `ssh_config` into separate files!

## Getting started

    $ gem install poet
    $ poet bootstrap

This will move your `~/.ssh/config` into `~/.ssh/config.d/` and create an identical `~/.ssh/config`.
Organize files in `~/.ssh/config.d/` any way you want (just remember to re-run `poet` afterwards).

To edit `~/.ssh/config.d/some_file`, run `poet edit some_file`.
Poet will open your favorite $EDITOR and automatically create a new `~/.ssh/config`
when you quit the editor.

## Advanced usage

Poet won't touch your existing ssh_config.
If you want to play with it, pass a different filename to the "-o" option.
Or move your existing config out of the way.

### Bash completion

A Bash-compatible completion script is available for all commands and some of their arguments, most
notably for `poet edit`.

Run `poet completeme` to copy the script to `$HOME/.bash_completion.d/`.
The command outputs instructions how to properly source the file.

### Un-ignoring files

Stanzas under `~/.ssh/config.d/` with an extension of .disabled are ignored by default.
Every now and then, when you do need it, run `poet --with CONFIG` to explicitly include
`CONFIG.disabled` in your generated ssh_config. You can even include several by running several
`--with` options or using `--with CONFIG1,CONFIG2`.

Use `poet ls` (or `poet ls --tree`) to see a list (or tree) of all your config files.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Send me a pull request. Bonus points for topic branches.
