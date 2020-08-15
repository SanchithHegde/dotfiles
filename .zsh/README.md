# `Zsh`

My zsh setup uses the [zinit](https://github.com/zdharma/zinit) plugin manager
and the [powerlevel10k](https://github.com/romkatv/powerlevel10k) zsh theme.
Apart from these, the `.zshrc` file sources a few snippets from
[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and some plugins.

> **NOTE:** Before copying commands from the `.zshrc` file, ensure that the
> environment variables `$XDG_CACHE_HOME` and `$ZDOTDIR` are set. My `.zshrc`
> file does **NOT** use defaults in case they are not set. Refer to the
> `.zshenv` file in this directory and the repo root directory if needed.

If you've not already noticed, there are two `.zshenv` files, one in the repo
root and the other in this directory. The one in the repo root is `~/.zshenv`,
which is only used to set the `$ZDOTDIR` environment variable, while the one in
this directory is `$ZDOTDIR/.zshenv` (`~/.zsh/.zshenv` in my case) and sets all
the necessary environment variables.

If you'd want to try it out, you'll have to set `$ZDOTDIR` in `~/.zshenv` and
`$XDG_CACHE_HOME` in `$ZDOTDIR/.zshenv`. Then, clone this repo, copy `.zshrc`
and `.p10k.zsh` files from this directory to `$ZDOTDIR/` and start a new `zsh`
session. It should download `zinit` as well as all plugins. You can then run
`p10k configure` to configure `powerlevel10k` to your liking. Note that it is
recommended to use a patched monospace font from the
[Nerd Fonts collection](https://www.nerdfonts.com/font-downloads).
