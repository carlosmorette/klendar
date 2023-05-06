defmodule Klendar.Calendar do
  alias Klendar.Calendar.{Month, Task, Day}

  # TODO: spec
  def generate_month(year, month) do
    Month.generate(year, month)
  end

  # TODO: spec
  def create_task(
        %{
          title: _title,
          description: _description,
          email: _email,
          hex_color: _hex_color,
          hour: _hour
        } = params
      ) do
    params
    |> Map.update!(:hour, &make_task_hour/1)
    |> Task.insert!()
  end

  # TODO: spec
  def get_tasks(year, month, day) do
    Day.tasks(year, month, day)
  end

  defp make_task_hour({year, month, day, hour, minute}) do
    NaiveDateTime.new!(
      String.to_integer(year),
      String.to_integer(month),
      String.to_integer(day),
      String.to_integer(hour),
      String.to_integer(minute),
      0
    )
  end

  def parse_month(month) do
    Month.parse(month)
  end
end
