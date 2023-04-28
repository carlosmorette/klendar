defmodule KlendarWeb.DayLiveComponent do
  use KlendarWeb, :live_view                                   
  
  def mount(_params, _session, socket), do: {:ok, socket}
  
  def render(%{number: number} = assigns) do                                      
    ~H"""                                                     
    <div class="day">
      <p><%= number %></p>
    </div>
    """                                                       
  end                                                         
end                                                           
