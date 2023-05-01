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
    Task.insert!(params)
  end

  # TODO: spec
  def get_tasks(year, month, day) do
    Day.tasks(year, month, day)
  end
end
