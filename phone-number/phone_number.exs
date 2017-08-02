defmodule PhoneRecord do
  defstruct area_code: nil, exchange_code: nil, subscriber_number: nil
end

defmodule Phone do
  @invalid_phone_number %PhoneRecord{
    area_code: "000",
    exchange_code: "000",
    subscriber_number: "0000"
  }

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> parse_number()
    |> convert_to_string()
  end

  defp convert_to_string(%PhoneRecord{} = phone) do
    "#{phone.area_code}#{phone.exchange_code}#{phone.subscriber_number}"
  end

  def parse_number(raw) do
    case Regex.scan(~r/\d+/, raw) do
      [[number]] ->
        validate_number(number)
      [[area_code], [exchange_code], [subscriber_number]] -> 
        validate_number(area_code, exchange_code, subscriber_number)
      [["1"], [area_code], [exchange_code], [subscriber_number]] -> 
        validate_number(area_code, exchange_code, subscriber_number)
      _ ->
        @invalid_phone_number
    end
  end

  def validate_number("1" <> number), do: validate_number(number)
  def validate_number(<<area_code::bytes-size(3), exchange_code::bytes-size(3), subscriber_number::bytes-size(4)>>) do
    validate_number(area_code, exchange_code, subscriber_number)
  end
  def validate_number(_), do: @invalid_phone_number
  def validate_number(area_code, exchange_code, subscriber_number) do
    with true <- Regex.match?(~r/[2-9]\d{2}/, area_code),
         true <- Regex.match?(~r/[2-9]\d{2}/, exchange_code),
         true <- Regex.match?(~r/\d{4}/,      subscriber_number)
    do
      %PhoneRecord{area_code: area_code,
       exchange_code: exchange_code,
       subscriber_number: subscriber_number}
    else
      _error -> @invalid_phone_number
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    %PhoneRecord{area_code: area_code} = parse_number(raw)
    area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    %PhoneRecord{
      area_code: area_code,
      exchange_code: exchange_code,
      subscriber_number: subscriber_number
    } = parse_number(raw)

    "(#{area_code}) #{exchange_code}-#{subscriber_number}"
  end
end
