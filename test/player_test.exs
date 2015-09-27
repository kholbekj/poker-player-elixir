defmodule PlayerTest do
  use ExUnit.Case

    test "the truth" do
        assert Player.bet_request({}) == 0
    end
end
