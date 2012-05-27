[![Build Status](https://secure.travis-ci.org/awendt/poet.png)](http://travis-ci.org/awendt/poet)

# Split your `ssh_config` into separate files!

1. `gem install poet`
2. `poet --bootstrap`
3. Organize files in `~/.ssh/config.d/` any way you want (just remember to re-run `poet` afterwards)

Poet won't touch your existing ssh_config.
If you want to play with it, pass a different filename to the "-o" option.
Or move your existing config out of the way.

Stanzas under `~/.ssh/config.d/` with an extension of .disabled are ignored by default.
Every now and then, when you do need it, run `poet --with CONFIG` to explicitly include
`CONFIG.disabled` in your generated ssh_config. You can even include several by running several
`--with` options or using `--with CONFIG1,CONFIG2`.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Send me a pull request. Bonus points for topic branches.
