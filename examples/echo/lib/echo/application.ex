defmodule Echo.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Echo.ServerSupervisor, [name: :server_1, port: 1100]}, id: 1)
    ]

    opts = [strategy: :one_for_one, name: Echo.ServerSupervisor]
    Supervisor.start_link(children, opts)
  end
end
