defmodule Klendar.Calendar do
  alias Klendar.Calendar.Month

  def generate_month(year, month) do
    Month.generate(year, month)
  end
end
