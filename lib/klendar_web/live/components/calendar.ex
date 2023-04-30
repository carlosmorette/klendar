defmodule KlendarWeb.CalendarComponent do
  use Phoenix.Component

  def calendar(%{data: _data, month: _month, year: _year} = assigns) do
    ~H"""
    <div class="calendar-week">
      <%= for day <- List.flatten(@data) do %>
      <KlendarWeb.DayComponent.render
      id={day || "nil-#{Ecto.UUID.generate()}"}
      number={day} 
      month={@month} 
      year={@year} 
    />
      <% end %>
    </div>
    """
  end
end
