defmodule PokerPlayerElixir do
  defmodule AppRouter do
    use Plug.Router
    import Plug.Conn

    plug :match
    plug :dispatch
    plug Plug.Parsers, parsers: [:multipart]

    post "/" do
      conn
      |> parse
      |> case do
        %{params: %{"action" => action, "game_state" => game_state}} ->
          send_resp(conn, 200, inspect get_reponse_for_action(action, game_state))
        _ ->
          send_resp(conn, 404, "Not found")
      end
    end

    def get_reponse_for_action(action, game_state) do
      game_state =  try do
                      Poison.Parser.parse! game_state
                    rescue
                      e in Poison.SyntaxError -> game_state
                    end

      case action do
        "bet_request" ->
          Player.bet_request(game_state)
        "showdown" ->
          Player.showdown(game_state)
        _ ->
          "Illegal action!"
      end
    end

    def parse(conn, opts \\ []) do
      opts = Keyword.put_new(opts, :parsers, [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
      Plug.Parsers.call(conn, Plug.Parsers.init(opts))
    end
  end
end
