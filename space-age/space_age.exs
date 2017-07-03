defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @days_in_earth_year 365.26

  @planets_days_in_year [
    {:mercury, 87.97},
    {:venus, 224.7},
    {:earth, @days_in_earth_year},
    {:mars, 687},
    {:jupiter, 11.86 * @days_in_earth_year},
    {:saturn, 29.46 * @days_in_earth_year},
    {:uranus, 84.01 * @days_in_earth_year},
    {:neptune, 164.79 * @days_in_earth_year}
  ]

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  for {planet, days_in_year} <- @planets_days_in_year do
    def age_on(unquote(planet), seconds) do
      seconds / (60 * 60 * 24 * unquote(days_in_year))
    end
  end
end
