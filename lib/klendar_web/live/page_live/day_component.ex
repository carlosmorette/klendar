defmodule KlendarWeb.PageLive.DayLiveComponent do
  use KlendarWeb, :live_component

  def render(%{number: nil} = assigns) do
    ~H"""
    <div class="day"></div>
    """
  end

  def render(%{number: number, month: month, year: year} = assigns) do
    ~H"""
    <div class="day" 
      phx-click="DayLiveComponent|phx-click|view-tasks" 
      phx-value-month={month} 
      phx-value-year={year} 
      phx-value-day={number}
    >
      <p><%= number %></p>
    </div>
    """
  end

  def handle("view-tasks", params, socket) do
    %{"year" => year, "month" => month, "day" => day} = params

    if is_nil(day) do
      {:noreply, socket}
    else
      {:noreply,
       socket
       |> update(:show_tasks_sidebar?, &(!&1))
       |> update(:current_date, fn _ -> {year, month, day} end)
       |> update(:tasks, fn _ -> Klendar.Calendar.get_tasks(year, month, day) end)}
    end
  end
end
