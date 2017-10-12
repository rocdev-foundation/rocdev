# Contributing

## Getting Started

First, you'll need a couple things installed: [Docker][docker] and [asdf][asdf].
With those, you can install all the other tooling that is necessary.
Assuming you're on macOS, run the following.

```
brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc xz
brew install docker asdf
asdf plugin-add elixir
asdf plugin-add nodejs
asdf install
```

Optionally, you may wish to install [tmuxp][tmuxp], a Python package, to get everything started via [tmux][tmux].
```
brew install tmux
/usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
asdf plugin-add python
CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" asdf install
pip install tmuxp
```

If you have installed tmuxp, run `tmuxp load ./tmuxp.yaml`.
Otherwise, you should still read through tmuxp.yaml to see the commands necessary to get all the components running.
Once everything is up, you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Branching

Before making any changes, please make a branch.
Each branch should be for a single change and should have no more than one or two commits.
When in doubt, err on the side of fewer commits.
Multiple commits can be squashed together, and HEAD can be easily amended to include more changes.
As you work continue to rebase against master so your changes are applied on top of it.
*Do not merge master into your branch.*

## Take Credit

The first commit you make—before you make your intended change—should be to `humans.txt`.
Add your name to `infrastructure/nginx/humans.txt`.
Make that change in its own commit; we won't count this one.
Even if your change has to be reverted for whatever reason, you should still be credited as a contributor.

## Committing Changes

Once your changes are ready, test everything with `./ci`.
When that succeeds, you'll be ready to commit.
Ensure your commit message follows the following format.

```
Header
<BLANK>
Body
<BLANK>
Footer
```

The header must be a summary of the change no more than 50 characters.

The body is free form text allowing you to describe the change more completely.
Each line in the body must not exceed 72 characters.

The footer references the GitHub issues relevant to this change.
There can be no more than one issue per line.
If the commit closes an issue, use the text "Closes #<issue-number>."

### Example Commit Message

```
Import 585-software/rocdev into Terraform.

Place the GitHub repo under Terraform's control.

Depends on #2.
Closes #3.
```

## Pull Request

If your PR has one change in it, the header of the commit suffices for the PR header, and
the rest is sufficient for the text.
If this is your first contribution and you added your name to `humans.txt`, use the other commit to fill in the header and body.

[docker]: https://www.docker.com/
[asdf]: https://github.com/asdf-vm/asdf
[tmux]: https://github.com/tmux/tmux/wiki
[tmuxp]: https://tmuxp.git-pull.com/en/latest/
