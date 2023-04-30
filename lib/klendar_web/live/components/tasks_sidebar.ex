defmodule KlendarWeb.TasksSidebar do
  use Phoenix.Component

  def tasks(%{tasks: _tasks} = assigns) do
    ~H"""
    <div>
      <%= if @show do %>
        <div class="tasks-sidebar-container">
	  <div class="tasks-sidebar-content">
	    <%= for t <- @tasks do %>
	      <p> <%= "#{t.hour} - #{t.description}" %></p>
	      <% end %>
	  </div>
	</div>
      <% end %>
    </div>
    """
  end
end
