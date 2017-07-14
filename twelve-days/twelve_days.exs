defmodule TwelveDays do
  @days ~w(
    first
    second
    third
    fourth
    fifth
    sixth
    seventh
    eighth
    ninth
    tenth
    eleventh
    twelfth
  )

  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) when number in 1..12 do
    verse_pattern(Enum.at(@days, number-1))
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) when ending_verse > starting_verse do
    starting_verse..ending_verse
    |> Enum.map(fn(verse_number) ->
      verse(verse_number)
    end)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  for day <- @days do
    defp verse_pattern(unquote(day)) do
      gifts = get_gifts_for_day(unquote(day)) |> sentencify()
      "On the #{unquote(day)} day of Christmas my true love gave to me, #{gifts}."
    end
  end

  def get_gifts_for_day(day) do
    day_index = Enum.find_index(@days, &(&1 == day))
    Enum.slice(@gifts, 0..day_index)
  end

  defp sentencify([first]) do
    first
  end
  defp sentencify([first|rest]) do
    decorated_rest = Enum.reverse(rest) |> Enum.join(", ")
    "#{decorated_rest}, and #{first}"
  end
end
