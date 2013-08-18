[![Build Status](https://secure.travis-ci.org/awendt/poet.png)](http://travis-ci.org/awendt/poet)
[![Gem Version](https://badge.fury.io/rb/poet.png)](http://badge.fury.io/rb/poet)

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
