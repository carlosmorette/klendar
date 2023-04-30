defmodule Klendar.Calendar.Day do
  alias Klendar.Calendar.Task

  def tasks(year, month, day) do
    [year: year, month: fill(month), day: fill(day)]
    |> Task.find()
    |> Enum.map(&format_each/1)
  end

  def fill(n) when n <= 0 and is_integer(n), do: "0#{n}"
  def fill(<<_f, _s>> = str), do: str
  def fill(n) when is_integer(n), do: n
  def fill(n), do: "0#{n}"


  defp format_each(%Task{} = task) do
    task
    |> Map.from_struct()
    |> Map.update!(:hour, &format_hour/1)
  end

  defp format_hour(%NaiveDateTime{} = naive) do
    %_{hour: hour, minute: minute, second: second} = naive

    "#{fill(hour)}:#{fill(minute)}:#{fill(second)}"
  end
end
