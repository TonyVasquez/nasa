defmodule NASA.FuelCalculationTest do
  use ExUnit.Case

  alias NASA.FuelCalculation

  # gravity
  @moon 1.62
  @earth 9.807
  @mars 3.711

  test "Earth -> Moon -> Earth" do
    weight_of_equipment = 28801
    required_weight_of_fuel = 51898

    fuel_amount =
      FuelCalculation.calculate(weight_of_equipment, [
        {:launch, @earth},
        {:land, @moon},
        {:launch, @moon},
        {:land, @earth}
      ])

    assert fuel_amount == required_weight_of_fuel
  end

  test "Earth -> Mars -> Earth" do
    weight_of_equipment = 14606
    required_weight_of_fuel = 33388

    fuel_amount =
      FuelCalculation.calculate(weight_of_equipment, [
        {:launch, @earth},
        {:land, @mars},
        {:launch, @mars},
        {:land, @earth}
      ])

    assert fuel_amount == required_weight_of_fuel
  end

  test "Earth -> Moon -> Mars -> Earth" do
    weight_of_equipment = 75432
    required_weight_of_fuel = 212_161

    fuel_amount =
      FuelCalculation.calculate(weight_of_equipment, [
        {:launch, @earth},
        {:land, @moon},
        {:launch, @moon},
        {:land, @mars},
        {:launch, @mars},
        {:land, @earth}
      ])

    assert fuel_amount == required_weight_of_fuel
  end
end
