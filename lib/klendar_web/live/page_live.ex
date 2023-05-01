defmodule KlendarWeb.PageLive do
  use KlendarWeb, :live_view

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
       tasks: [],
       current_date: {}
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
     <.tasks_sidebar
       id="tasks-sidebar"
       show={@show_tasks_modal?}
       tasks={@tasks}
       current_date={@current_date}
     />
    """
  end

  def calendar(%{data: _data, month: _month, year: _year} = assigns) do
    ~H"""
    <div class="calendar-week">
      <%= for day <- List.flatten(@data) do %>
      <.live_component
        module={KlendarWeb.PageLive.DayLiveComponent}
    id={day || "nil-#{Ecto.UUID.generate()}"}
    number={day} 
    month={@month} 
    year={@year} 
      />
      <% end %>
    </div>
    """
  end

  def tasks_sidebar(%{show: false} = assigns) do
    ~H"""
    <div></div>
    """
  end

  def tasks_sidebar(%{show: _show, tasks: _tasks} = assigns) do
    %{current_date: {year, month, day}} = assigns

    ~H"""
    <div>
      <%= if @show do %>
        <div class="tasks-sidebar-container">
    <div class="tasks-sidebar-content">
     <h3> Tarefas do dia: <%= day %></h3>
     <.tasks data={@tasks} />
     <button phx-click="PageLive|phx-click|create-task">Criar tarefa</button>
    </div>	  
    </div>
      <% end %>
    </div>
    """
  end

  def tasks(%{data: []} = assigns) do
    ~H"""
    <p>Sem tarefas no momento</p>
    """
  end

  def tasks(%{data: tasks} = assigns) do
    ~H"""
    <%= for t <- tasks do %>
      <p> <%= "#{t.hour} - #{t.description}" %></p>
      <% end %>
    """
  end

  def handle_event("DayLiveComponent|phx-click|" <> event_name, params, socket) do
    KlendarWeb.PageLive.DayLiveComponent.handle(event_name, params, socket)
  end

  def handle_event("PageLive|phx-click|create-task", _params, socket) do
    {:noreply, socket}
  end
end
