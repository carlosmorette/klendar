defmodule KlendarWeb.DayComponent do
  use Phoenix.Component                       
  
  def render(%{number: nil} = assigns) do
    ~H"""
    <div class="day"></div>
    """
  end

  def render(%{number: number, month: month, year: year} = assigns) do                                      
    ~H"""                                                     
    <div class="day" 
      phx-click="DayLiveComponent|phx-click|view-day" 
      phx-value-month={month} 
      phx-value-year={year} 
      phx-value-day={number}
    >
      <p><%= number %></p>
    </div>
    """                                                       
  end
end                                                           
