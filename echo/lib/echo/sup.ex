defmodule Echo.ServerSupervisor do
  use Supervisor

  alias Echo.Server

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg)
  end

  @impl true
  def init(config) do
    supervisor_name =
      config
      |> Server.name()
      |> Server.supervisor_name()

    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: supervisor_name},
      {Echo.Server, config}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
