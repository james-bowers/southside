defmodule SouthsideTest do
  use ExUnit.Case
  doctest Southside

  test "greets the world" do
    assert Southside.hello() == :world
  end
end
