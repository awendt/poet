[![Build Status](https://secure.travis-ci.org/awendt/poet.png)](http://travis-ci.org/awendt/poet)

# Wanna to split up your longish `~/.ssh/config` into several files?

1. `gem install poet`
2. `mkdir ~/.ssh/config.d/`
3. Divide your `ssh_config` into several smaller files in the directory you just created
4. Run `poet` to concatenate them into a single ssh_config

Add host stanzas to new files or existing ones and re-run `poet`.

Poet won't touch your existing ssh_config.
If you want to play with it, pass a different filename to the "-o" option.
Or move your existing config out of the way.

Stanzas under `~/.ssh/config.d/` with an extension of .disabled are ignored by Poet.
Every now and then, when you do need it, run `poet --with CONFIG` to explicitly include
`CONFIG.disabled` in your generated ssh_config. You can even include several by running several
`--with` options or using `--with CONFIG1,CONFIG2`.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Send me a pull request. Bonus points for topic branches.
