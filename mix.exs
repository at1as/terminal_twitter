defmodule TerminalTwitter.Mixfile do
  use Mix.Project

  def project do
    [app: :terminal_twitter,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: TerminalTwitter],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :extwitter]]
  end

  def deps do
    [
      {:oauth, git: "https://github.com/tim/erlang-oauth.git"},
      {:extwitter, "~> 0.7"}
    ]
  end
end
