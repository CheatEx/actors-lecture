defmodule StateBehavior do
  @moduledoc """
  > c "examples/7-behaviors.exs"
  > c = StateBehavior.start_link(CounterBehavior, 5)
  > send(c, {:show})
  > send(c, {:command, :inc})
  > send(c, {:command, :dec})
  """

  @type state() :: any()

  @type command() :: Atom.t()

  @callback init(any()) :: state()

  @callback update(command(), state()) :: state()

  @callback show(state()) :: nil

  def start_link(impl, args) do
    spawn_link(StateBehavior, :run, [impl, args])
  end

  def run(impl, args) do
    state = impl.init(args)
    loop(impl, state)
  end

  defp loop(impl, state) do
    new_state =
      receive do
        {:command, command} ->
          impl.update(command, state)

        {:show} ->
          impl.show(state)
          state

        _ ->
          state
      end

    loop(impl, new_state)
  end
end

defmodule CounterBehavior do
  @behaviour StateBehavior

  @impl true
  def init(args) do
    args
  end

  @impl true
  def update(_command = :inc, state) do
    state + 1
  end

  def update(_command = :dec, state) do
    state - 1
  end

  @impl true
  def show(state) do
    IO.puts(inspect(state))
  end
end
