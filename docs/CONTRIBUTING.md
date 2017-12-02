# Contributing

## Getting Started

### Vagrant (and Ubuntu)

[Vagrant][vagrant] is a tool for building and managing virtual machines.

```
vagrant up
vagrant ssh
cd /vagrant
```

Since the Vagrant image is Ubuntu, you can follow the provisioning scripts to get everything running.

### macOS

First, you'll need a couple things installed: [Docker][docker] and [asdf][asdf].
With those, you can install all the other tooling that is necessary.

```
brew install coreutils automake autoconf openssl libyaml readline libxslt libtool tmux unixodbc xz
brew install docker asdf
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs
asdf plugin-add python
asdf plugin-add terraform
/usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" asdf install
pip install tmuxp
```

### Last Steps

If you want to use tmuxp, run `tmuxp load ./tmuxp.yaml`.
Otherwise, you should still read through tmuxp.yaml to see the commands necessary to get all the components running.
Once everything is up, you can visit [`localhost:8000`](http://localhost:8000) from your browser.
You can also directly hit Phoenix at [`localhost:4000`](http://localhost:4000).

## Contributing to Documentation

Contributing to our documentation is a great way to get started, and helps out everyone who works on this project.
Here are some simple guidelines when committing to documentation (SO META!):

- Each sentence should be put on its own line for readability
- Titleize headers: capitalize all words except for articles and prepositions, or where it is stylistically appropriate (e.g. "macOS")
- [Use links where appropriate](https://help.ghost.org/hc/en-us/articles/224410728-Markdown-Guide#text-styling) to help people learn more about esoteric concepts


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

[vagrant]: https://www.vagrantup.com/
[docker]: https://www.docker.com/
[asdf]: https://github.com/asdf-vm/asdf
[tmux]: https://github.com/tmux/tmux/wiki
[tmuxp]: https://tmuxp.git-pull.com/en/latest/
