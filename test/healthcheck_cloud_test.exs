defmodule HealthcheckCloudTest do
  use ExUnit.Case
  doctest HealthcheckCloud

  test "greets the world" do
    assert HealthcheckCloud.hello() == :world
  end
end
