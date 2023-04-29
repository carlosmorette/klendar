defmodule KlendarWeb.TasksSidebar do
  use Phoenix.LiveComponent

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <div>
      <%= if @show do %>
        <div class="tasks-sidebar-container">
          <p>Hello</p>
	</div>
      <% end %>
    </div>
    """
  end
end
