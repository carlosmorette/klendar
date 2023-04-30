defmodule KlendarWeb.PageLive do
  use KlendarWeb, :live_view

  use KlendarWeb.PageLive.Components

  @abril_2023 [
    [nil, nil, nil, nil, nil, nil, 1],
    [2, 3, 4, 5, 6, 7, 8],
    [9, 10, 11, 12, 13, 14, 15],
    [16, 17, 18, 19, 20, 21, 22],
    [23, 24, 25, 26, 27, 28, 29],
    [30, nil, nil, nil, nil, nil, nil]
  ]

  def mount(_params, _session, socket) do
    # TODO: gerar calendário
    {:ok,
     assign(socket,
       abril_2023: @abril_2023,
       show_tasks_modal?: false,
       tasks: []
     )}
  end

  def render(assigns) do
    ~H"""
    <h1 style="margin-bottom: 20px; text-align: center">Calendário Abril 2023</h1>
    <.calendar
       id={"calendar"} 
       data={@abril_2023} 
       month={04} 
       year={2023} 
     />
     <.tasks
       id="tasks-sidebar"
       show={@show_tasks_modal?}
       tasks={@tasks}
     />
    """
  end

  def handle_event("DayLiveComponent|phx-click|view-day", params, socket) do
    %{"year" => year, "month" => month, "day" => day} = params

    if is_nil(day) do
      {:noreply, socket}
    else
      {:noreply,
       socket
       |> update(:show_tasks_modal?, &(!&1))
       |> update(:tasks, fn _ -> Klendar.Calendar.get_tasks(year, month, day) end)}
    end
  end
end
