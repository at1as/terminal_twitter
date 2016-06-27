# TerminalTwitter

Terminal Twitter is a twitter application for the Terminal. Written in Elixir.


## Installation

Preconditions

* Requires Elixir and Erlang
* Built and tested with Elixir 1.2.4 and Erlang/OTP 18 on MacOS 10.11


```
# Get Repo
> git clone https://github.com/at1as/terminal-twitter.git
> cd terminal-twitter

# Get Dependencies
> mix deps.get

# Build as a command line app
> mix escript.build

```

## Screenshots

<img src="http://at1as.github.io/github_repo_assets/terminal_twitter.png">

## Authentication

Authenciation will require creating the following file in the location `config/secrets.exs`. Replace the `<twitter...>` terms below with their respective values.

For more information about where to get these credentials, see `https://apps.twitter.com/`. This app requires only Read-Only permission.

```
use Mix.Config

config :extwitter, :oauth, [
  consumer_key:         "<twitter_consumer_key>"
  consumer_secret:      "<twitter_consumer_secret>"
  access_token:         "<twitter_access_token>"
  access_token_secret:  "<twitter_access_token_secret>"
]  
```

## Usage (CLI)

List of tweets on home timeline

* `./terminal_twitter new`


Search [for term "apple"]

* `./terminal_twitter search apple`


List of tweets from personal account

* `./terminal_twitter me`


## Usage (Package)


* TerminalTwitter.latest(10)        
  * Args: Number of tweets [1 - 200]
* TerminalTwitter.find("apple", 10)
  * Args: Search term, Number of tweets [1 - 200]
* TerminalTwitter.me(10)
  * Args: Number of tweets [1 - 200]
