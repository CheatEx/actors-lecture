defmodule Echo.Server do
  alias Echo.Handler

  use GenServer, restart: :temporary

  def start_link(config) do
    GenServer.start_link(__MODULE__, config, name: name(config))
  end

  @impl true
  def init(config) do
    port = Keyword.fetch!(config, :port)
    handler_supervisor = handler_supervisor_name(config)
    {:ok, lsock} = :gen_tcp.listen(port, active: false, reuseaddr: true)
    accept_next()
    {:ok, {handler_supervisor, lsock}}
  end

  @impl true
  def handle_info(:accept_next, {handler_supervisor, lsock} = state) do
    {:ok, sock} = :gen_tcp.accept(lsock)
    start_handler(handler_supervisor, sock)
    accept_next()
    {:noreply, state}
  end

  def handler_supervisor_name(config) when is_list(config) do
    name_str =
      config
      |> name()
      |> Atom.to_string()

    String.to_atom(name_str <> "_supervisor")
  end

  defp name(config) when is_list(config) do
    Keyword.fetch!(config, :name)
  end

  defp accept_next() do
    send(self(), :accept_next)
  end

  defp start_handler(handler_supervisor, sock) do
    {:ok, handler} =
      DynamicSupervisor.start_child(
        handler_supervisor,
        {Handler, {}}
      )

    :gen_tcp.controlling_process(sock, handler)
    Handler.handle(handler, sock)
  end
end
