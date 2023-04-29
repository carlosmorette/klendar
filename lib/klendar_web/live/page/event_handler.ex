defmodule KlendarWeb.PageLive.EventHandler do
  defmacro __using__(_) do
    quote do
      def handle_event("DayLiveComponent|phx-click|view-day", params, socket) do
	%{"month" => month, "year" => year} = params
	# TODO: puxar eventos desse dia e etc
	{:noreply, socket}
      end
    end
  end
end
