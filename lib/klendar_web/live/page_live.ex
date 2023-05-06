defmodule KlendarWeb.PageLive do
  use KlendarWeb, :live_view

  def mount(_params, _session, socket) do
    %Date{year: year, month: month} = Date.utc_today()

    current_month =
      Klendar.Calendar.generate_month(
        year,
        month
      )

    {:ok,
     assign(socket,
       current_month: current_month,
       month: month,
       year: year,
       show_tasks_sidebar?: false,
       tasks: [],
       current_date: {},
       show_new_task_modal?: false,
       new_task: %{},
       days_of_week: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Feira"]
     )}
  end

  def render(assigns) do
    ~H"""

    <.header
      month={@month}
      year={@year}
    />

    <.calendar
       id={"calendar"} 
       data={@current_month} 
       month={@month} 
       year={@year} 
       days_of_week={@days_of_week}
     />
     <.tasks_sidebar
       id="tasks-sidebar"
       show={@show_tasks_sidebar?}
       tasks={@tasks}
       current_date={@current_date}
     />
     <.new_task_modal
       id="new-task-modal"
       show={@show_new_task_modal?}
       current_date={@current_date}
     />
    """
  end

  def header(%{month: month, year: _year} = assigns) do
    month = Klendar.Calendar.parse_month(month)

    ~H"""
    <div 
    style="
      margin-bottom: 20px; 
      display: flex; 
      justify-content: center; 
      flex-direction: column; 
      align-items: center"
    >
      <h1 style="text-align: center">Calendário <%= month <> " " <> to_string(@year) %></h1>
      <.arrows />
    </div>
    """
  end

  def calendar(%{data: _data, month: _month, year: _year} = assigns) do
    ~H"""
    <div class="calendar-week">
    <%= for h <- @days_of_week do %>
      <p class="day-of-week"><%= h %></p>
    <% end %>
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

  def tasks_sidebar(%{tasks: _tasks, current_date: current_date} = assigns) do
    {_year, _month, day} = current_date

    ~H"""
    <div>
      <div class="tasks-sidebar-container">
        <div class="tasks-sidebar-content">
    <h3> Tarefas do dia: <%= day %></h3>
    <.tasks data={@tasks} />
    <button phx-click="PageLive|phx-click|show-new-task-modal">Criar tarefa</button>
    </div>	  
      </div>
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

  def new_task_modal(%{show: false} = assigns) do
    ~H"""
    <div></div>
    """
  end

  def new_task_modal(assigns) do
    ~H"""
    <div class="new-task-modal-container">
      <div class="new-task-modal-content">
        <h2>Nova tarefa</h2>
    <form phx-submit="PageLive|phx-click|save-new-task">
    <div>
     <label for="title">Título:</label>
     <input type="text" id="title" name="title" />
    </div>
    <div>
     <label for="description">Descrição:</label>
     <input type="text" id="description" name="description" />
    </div>
    <div>
     <label for="hour">Horário:</label>
     <input type="time" id="hour" name="hour" />
    </div>
    <button>Criar</button>
    </form>
      </div>
    </div>
    """
  end

  def arrows(assigns) do
    ~H"""
    <div class="arrows-content">
      <p phx-click="PageLive|phx-click:previous-month">&#60;</p> 
      <p phx-click="PageLive|phx-click:next-month">&#62;</p> 
    </div>
    """
  end

  def handle_event("DayLiveComponent|phx-click|" <> event_name, params, socket) do
    KlendarWeb.PageLive.DayLiveComponent.handle(event_name, params, socket)
  end

  def handle_event("PageLive|phx-click|show-new-task-modal", _params, socket) do
    {:noreply, update(socket, :show_new_task_modal?, &(!&1))}
  end

  def handle_event("PageLive|phx-click|save-new-task", params, socket) do
    %{current_date: {year, month, day}} = socket.assigns
    %{"description" => description, "title" => title, "hour" => hour} = params
    [hour, minute] = String.split(hour, ":")

    Klendar.Calendar.create_task(%{
      title: title,
      description: description,
      email: nil,
      hex_color: nil,
      hour: {year, month, day, hour, minute}
    })

    {:noreply,
     socket
     |> update(:show_new_task_modal?, &(!&1))
     |> update(
       :tasks,
       fn _ ->
         Klendar.Calendar.get_tasks(year, month, day)
       end
     )}
  end

  def handle_event("PageLive|phx-click:previous-month", _params, socket) do
    %{month: month, year: year} = socket.assigns

    new_month = if month == 1, do: 12, else: month - 1
    new_year = if month == 1, do: year - 1, else: year

    socket =
      socket
      |> update(:month, fn _ -> new_month end)
      |> update(:year, fn _ -> year end)
      |> update(
        :current_month,
        fn _ ->
          Klendar.Calendar.generate_month(new_year, new_month)
        end
      )

    {:noreply, socket}
  end

  def handle_event("PageLive|phx-click:next-month", _params, socket) do
    %{month: month, year: year} = socket.assigns

    new_month = if month == 12, do: 1, else: month + 1
    new_year = if month == 12, do: year + 1, else: year

    socket =
      socket
      |> update(:month, fn _ -> new_month end)
      |> update(:year, fn _ -> year end)
      |> update(
        :current_month,
        fn _ ->
          Klendar.Calendar.generate_month(new_year, new_month)
        end
      )

    {:noreply, socket}
  end
end
