defmodule Week5SpotifyApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Week5SpotifyApi.Router, options: [port: 8888]}

      # Starts a worker by calling: Week5SpotifyApi.Worker.start_link(arg)
      # {Week5SpotifyApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Week5SpotifyApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
