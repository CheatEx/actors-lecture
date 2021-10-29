defmodule Echo.Server do
  alias SimpleCacheServer.Tcp.Listener

  use GenServer

  def start_link(port) do
    GenServer.start_link(__MODULE__, port)
  end

  def accepted(server, lsock) do
    GenServer.cast(server, {:accepted, lsock})
  end

  @impl true
  def init(port) do
    {:ok, lsock} = :gen_tcp.listen(port, active: true)
    start_listener(lsock)
    {:ok, lsock}
  end

  @impl true
  def handle_cast({:accepted, lsock = state}, state) do
    start_listener(lsock)
    {:noreply, state}
  end

  defp start_listener(lsock) do
    DynamicSupervisor.start_child(SimpleCacheServer.Tcp.LSup, {Listener, {self(), lsock}})
  end
end
