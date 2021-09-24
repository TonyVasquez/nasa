defmodule NASA.Core.FuelCalculator do
  @moduledoc """
    Provides possibility to calculate fuel required for the flight
    to launch from one planet of the Solar system
    and to land on another planet of the Solar system,
    depending on the flight route
  """

  @type ship_mass() :: number()
  @type fuel_amount() :: number()
  @type planet_gravity() :: number()
  @type mass() :: ship_mass() | fuel_amount()

  @type launch() :: {:launch, planet_gravity()}
  @type land() :: {:land, planet_gravity()}

  @type part_of_flight() :: launch() | land()

  @spec calculate(ship_mass(), nonempty_list(part_of_flight())) :: fuel_amount()
  def calculate(ship_mass, routes) do
    routes = reverese_breakpoints(routes)

    Enum.reduce(routes, 0, fn part_of_flight, total_fuel_amount ->
      total_mass = ship_mass + total_fuel_amount

      part_flight_fuel = _calculate(total_mass, part_of_flight)
      part_flight_fuel_additional = _calculate(part_flight_fuel, part_of_flight, part_flight_fuel)

      total_fuel_amount + part_flight_fuel_additional
    end)
  end

  @spec _calculate(mass(), part_of_flight(), fuel_amount()) :: fuel_amount()
  defp _calculate(mass, part_of_flight, acc_fuel_amount) do
    fuel_amount = _calculate(mass, part_of_flight)

    cond do
      fuel_amount <= 0 ->
        acc_fuel_amount

      true ->
        _calculate(fuel_amount, part_of_flight, acc_fuel_amount + fuel_amount)
    end
  end

  @spec _calculate(mass(), launch()) :: fuel_amount()
  defp _calculate(mass, {:launch, planet_gravity}),
    do: floor(launch_formula(mass, planet_gravity))

  @spec _calculate(mass(), land()) :: fuel_amount()
  defp _calculate(mass, {:land, planet_gravity}), do: floor(land_formula(mass, planet_gravity))

  @spec reverese_breakpoints(nonempty_list(part_of_flight())) :: nonempty_list(part_of_flight())
  defp reverese_breakpoints(routes) do
    # Reverse route to start counting required fuel
    # for all steps before launch

    Enum.reverse(routes)
  end

  defp launch_formula(mass, planet_gravity), do: mass * planet_gravity * 0.042 - 33
  defp land_formula(mass, planet_gravity), do: mass * planet_gravity * 0.033 - 42
end
