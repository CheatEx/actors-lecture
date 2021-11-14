defmodule Echo.Handler do
  use GenServer, restart: :temporary

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def handle(handler, sock) do
    GenServer.cast(handler, {:handle, sock})
  end

  @impl true
  def init(_arg) do
    {:ok, {}}
  end

  @impl true
  def handle_cast({:handle, sock}, _state = {}) do
    :inet.setopts(sock, active: true, mode: :binary)
    new_state = {sock}
    {:noreply, new_state}
  end

  @impl true
  def handle_info({:tcp, sock, data}, {sock} = state) do
    new_state = handle_data(sock, data, state)
    {:noreply, new_state}
  end

  @impl true
  def handle_info({:tcp_closed, _sock}, state) do
    {:stop, :normal, state}
  end

  defp handle_data(socket, "crash" <> _, state) do
    raise "Crash"
  end

  defp handle_data(socket, data, state) do
    IO.puts(inspect(data))
    :gen_tcp.send(socket, data)
    state
  end
end
