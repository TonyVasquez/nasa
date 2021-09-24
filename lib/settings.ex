defmodule NASA.Settings do
  def calculator(), do: Application.fetch_env!(:nasa, :fuel_calculator)
end
