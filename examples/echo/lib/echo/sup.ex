defmodule Echo.ServerSupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg)
  end

  @impl true
  def init(arg) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Echo.ListenerSupervisor},
      {Echo.Server, arg}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
