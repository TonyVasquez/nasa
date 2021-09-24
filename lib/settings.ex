defmodule NASA.Settings do
  @moduledoc """
    Provides settings for some entites,
    for e.g module implementation
  """
  def calculator(), do: Application.fetch_env!(:nasa, :fuel_calculator)
end
