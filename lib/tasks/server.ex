defmodule Mix.Tasks.Server do
  use Mix.Task

  def run(_) do
    {port, _} = Integer.parse(System.get_env("PORT"))
    port = port || 8090
    {:ok, _} = Plug.Adapters.Cowboy.http PokerPlayerElixir.AppRouter, [], port: port
    Mix.shell.info "Server started on port #{port} (Ctrl+C to abort)"
    :timer.sleep(:infinity)
  end
end
