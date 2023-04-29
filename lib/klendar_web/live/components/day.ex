defmodule KlendarWeb.DayLiveComponent do
  use Phoenix.Component                       
  
  def render(%{number: number, month: month, year: year} = assigns) do                                      
    ~H"""                                                     
    <div class="day" phx-click="DayLiveComponent|phx-click|view-day" phx-value-month={month} phx-value-year={year}>
      <p><%= number %></p>
    </div>
    """                                                       
  end
end                                                           
