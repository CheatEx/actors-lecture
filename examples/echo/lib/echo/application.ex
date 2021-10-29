defmodule Echo.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Echo.ServerSupervisor, 1010}
    ]

    opts = [strategy: :one_for_one, name: Echo.ApplicationSupervisor]
    Supervisor.start_link(children, opts)
  end
end
