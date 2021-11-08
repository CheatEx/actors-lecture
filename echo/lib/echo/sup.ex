defmodule Echo.ServerSupervisor do
  use Supervisor

  alias Echo.Server

  def start_link(config) do
    Supervisor.start_link(__MODULE__, config)
  end

  @impl true
  def init(config) do
    handler_supervisor_name = Server.handler_supervisor_name(config)

    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: handler_supervisor_name},
      {Server, config}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
