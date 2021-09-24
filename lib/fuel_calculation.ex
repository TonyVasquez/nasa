defmodule NASA.FuelCalculation do
  @moduledoc """
    Allow to calculate fuel required for the flight
    to launch from one planet of the Solar system
    and to land on another planet of the Solar system,
    depending on the flight route.


    Example:
    (Earth -> Moon -> Earth)
    > NASA.FuelCalculation.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
  """

  @type ship_mass() :: number()
  @type fuel_amount() :: number()
  @type planet_gravity() :: number()
  @type mass() :: ship_mass() | fuel_amount()

  @type launch() :: {:launch, planet_gravity()}
  @type land() :: {:land, planet_gravity()}

  @type route() :: {launch(), land()}

  @spec calculate(ship_mass(), nonempty_list(route())) :: fuel_amount()
  def calculate(ship_mass, routes) do
    routes = Enum.reverse(routes)

    Enum.reduce(routes, 0, fn part_of_flight, acc_fuel_amount ->
      total_mass = ship_mass + acc_fuel_amount

      part_flight_fuel = _calculate(total_mass, part_of_flight)
      part_flight_fuel_additional = _calculate(part_flight_fuel, part_of_flight, part_flight_fuel)

      acc_fuel_amount + part_flight_fuel_additional
    end)
  end

  @spec _calculate(mass(), launch() | land(), fuel_amount()) :: fuel_amount()
  defp _calculate(mass, part_of_flight, acc_fuel_amount) when is_number(acc_fuel_amount) do
    fuel_amount = _calculate(mass, part_of_flight)

    cond do
      fuel_amount <= 0 ->
        acc_fuel_amount

      true ->
        _calculate(fuel_amount, part_of_flight, acc_fuel_amount + fuel_amount)
    end
  end

  @spec _calculate(mass(), launch()) :: fuel_amount()
  defp _calculate(mass, {:launch, planet_gravity}), do: floor(mass * planet_gravity * 0.042 - 33)

  @spec _calculate(mass(), land()) :: fuel_amount()
  defp _calculate(mass, {:land, planet_gravity}), do: floor(mass * planet_gravity * 0.033 - 42)
end
