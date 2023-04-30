defmodule KlendarWeb.PageLive.Components do
  defmacro __using__(_opts) do
    quote do
      import KlendarWeb.CalendarComponent, only: [calendar: 1]
      import KlendarWeb.TasksSidebar, only: [tasks: 1]
    end
  end
end
