# Rocdev

The online presence for RocDev written with Elixir and Phoenix.

## Getting Started

First, you must install [Elixir](https://elixir-lang.org/) and [pg_isready](https://www.postgresql.org/docs/current/static/app-pg-isready.html).
Then, it is recommended you install the Python package [tmuxp](https://tmuxp.git-pull.com/en/latest/).

On macOS with [Homebrew](https://brew.sh/), this can be done with the following.

```
brew install elixir postgresql python3
pip3 install tmuxp
```

### Using tmuxp

Simply run `tmuxp load ./tmuxp.yaml`.

### Manual Start

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

### Show Your Work

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
