defmodule Klendar.Calendar.Month do
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
    last_day = List.last(week)

    if last_day == last_day_of_the_month do
      Enum.reverse(acc)
    else
      week =
        do_generate_week(
          List.last(week),
          last_day_of_the_month,
          0,
          []
        )

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
end
