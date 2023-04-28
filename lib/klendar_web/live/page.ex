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
    {:ok, assign(socket, :abril_2023, @abril_2023)}
  end
    
  def render(assigns) do
    ~H"""
    <h1 style="margin-bottom: 20px; text-align: center">Calendário Abril 2023</h1>
    <KlendarWeb.CalendarLiveComponent.render month={@abril_2023} />
    """
  end
end
