[![Build Status](https://secure.travis-ci.org/awendt/poet.png)](http://travis-ci.org/awendt/poet)

Lost in a long list of host stanzas in your `$HOME/.ssh/config`?

Fear not -- divide them up into several smaller files under `$HOME/.ssh/config.d/` and run `poet` to concatenate them into a single ssh_config.

`poet` does not overwrite your existing ssh_config. If you want to play with it, move your existing config out of the way.

Stanzas under `$HOME/.ssh/config.d/` with an extension of .disabled are ignored by poet. Every now and then, when you do need it, run `poet --with CONFIG` to explicitly include `CONFIG.disabled` in your generated ssh_config. You can even include several by running several '--with' options or using `--with CONFIG1,CONFIG2`.

If you only want an ssh_config from certain files, use `--only CONFIG` or `--only CONFIG1,CONFIG2`.