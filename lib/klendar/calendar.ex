defmodule Klendar.Calendar do
  alias Klendar.Calendar.Month
  alias Klendar.Calendar.Task

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
      hour: _hour,
    } = params
  ) do
    Task.insert!(params)
  end
end
