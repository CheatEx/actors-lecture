defmodule Echo.Server do
  alias Echo.Handler

  use GenServer, restart: :permanent

  def start_link(config) do
    GenServer.start_link(__MODULE__, config, name: name(config))
  end

  def accept_next(server) do
    GenServer.cast(server, :accept_next)
  end

  @impl true
  def init(config) do
    port = Keyword.fetch!(config, :port)
    name = name(config)
    {:ok, lsock} = :gen_tcp.listen(port, active: false, reuseaddr: true)
    accept_next(self())
    {:ok, {name, lsock}}
  end

  @impl true
  def handle_cast(:accept_next, {name, lsock} = state) do
    {:ok, sock} = :gen_tcp.accept(lsock)
    start_handler(name, sock)
    accept_next(self())
    {:noreply, state}
  end

  def supervisor_name(name) when is_atom(name) do
    name_str = Atom.to_string(name)
    String.to_atom(name_str <> "_supervisor")
  end

  def name(config) when is_list(config) do
    Keyword.fetch!(config, :name)
  end

  defp start_handler(name, sock) do
    {:ok, handler} =
      DynamicSupervisor.start_child(
        supervisor_name(name),
        {Handler, {}}
      )

    :gen_tcp.controlling_process(sock, handler)
    Handler.handle(handler, sock)
  end
end
