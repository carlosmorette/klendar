defmodule KlendarWeb.CalendarLiveComponent  do
  use KlendarWeb, :live_component

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <div class="calendar-week">
      <%= for week <- List.flatten(@month) do %>
        <KlendarWeb.DayLiveComponent.render number={week} />
      <% end %>
    </div>
    """
  end
end
