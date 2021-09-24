defmodule NASA.API.FuelCalculator do
  @moduledoc """
    Allow to calculate fuel required for the flight
    to launch from one planet of the Solar system
    and to land on another planet of the Solar system,
    depending on the flight route.

    Example:
    > NASA.API.FuelCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    > 51898
  """

  alias NASA.Settings

  @type ship_mass() :: number()
  @type fuel_amount() :: number()
  @type planet_gravity() :: number()

  @type launch() :: {:launch, planet_gravity()}
  @type land() :: {:land, planet_gravity()}

  @type part_of_flight() :: launch() | land()

  @spec calculate(ship_mass(), nonempty_list(part_of_flight())) :: fuel_amount()
  def calculate(ship_mass, routes) do
    Settings.calculator().calculate(ship_mass, routes)
  end
end
