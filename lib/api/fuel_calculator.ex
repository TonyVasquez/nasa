defmodule NASA.API.FuelCalculator do
  alias NASA.Settings

  @type ship_mass() :: number()
  @type fuel_amount() :: number()
  @type planet_gravity() :: number()


  @type launch() :: {:launch, planet_gravity()}
  @type land() :: {:land, planet_gravity()}

  @type route() :: launch() | land()

  @spec calculate(ship_mass(), nonempty_list(route())) :: fuel_amount()
  def calculate(ship_mass, routes) do
    Settings.calculator().calculate(ship_mass, routes)
  end
end
