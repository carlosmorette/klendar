defmodule Klendar.Calendar.Month do
  @doc """
  The expected output of generate/2 is:
  iex(1)> Klendar.Calendar.generate_month(2023, 04) 
  [
    [nil, nil, nil, nil, nil, nil, 1],
    [2, 3, 4, 5, 6, 7, 8],
    [9, 10, 11, 12, 13, 14, 15],
    [16, 17, 18, 19, 20, 21, 22],
    [23, 24, 25, 26, 27, 28, 29],
    [30, nil, nil, nil, nil, nil, nil]
  ]
  """

  @spec generate(integer(), integer()) :: list(list(nil | integer()))
  def generate(year, month) do
    n_day_of_week =
      year
      |> Date.new!(month, 1)
      |> Date.beginning_of_month()
      |> Date.day_of_week()

    fw = generate_first_week(n_day_of_week)

    [
      fw
      | generate_rest_of_month(
          fw,
          :calendar.last_day_of_the_month(year, month)
        )
    ]
  end

  def generate_first_week(n_day_of_week) when n_day_of_week >= 0 and n_day_of_week <= 6 do
    0..6
    |> Enum.reduce({[], 1}, fn column, {acc_week, day_counter} ->
      if column < n_day_of_week do
        {[nil | acc_week], day_counter}
      else
        {[day_counter | acc_week], day_counter + 1}
      end
    end)
    |> then(fn {acc, _} -> Enum.reverse(acc) end)
  end

  def generate_rest_of_month(week, last_day_of_the_month) do
    do_generate_rest_of_month(week, last_day_of_the_month, [])
  end

  def do_generate_rest_of_month(week, last_day_of_the_month, acc) do
    week =
      do_generate_week(
        List.last(week),
        last_day_of_the_month,
        0,
        []
      )
    last_day = List.last(week)
    if last_day == last_day_of_the_month do
      Enum.reverse([fill_week(week) | acc])
    else
      do_generate_rest_of_month(
        week,
        last_day_of_the_month,
        [week | acc]
      )
  end
end

  def do_generate_week(last_day_of_the_month, last_day_of_the_month, _pointer, acc),
    do: Enum.reverse(acc)

  def do_generate_week(_day, _last_day_of_the_month, 7, acc), do: Enum.reverse(acc)

  def do_generate_week(day, last_day_of_the_month, pointer, acc) do
    do_generate_week(
      day + 1,
      last_day_of_the_month,
      pointer + 1,
      [day + 1 | acc]
    )
  end

  def fill_week(week) do
    if length(week) < 7 do
      fill_week(week ++ [nil])
    else
      week
    end
  end
end
