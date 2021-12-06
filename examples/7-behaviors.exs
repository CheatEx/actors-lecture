defmodule StateBehavior do
  @moduledoc """
  > c = StateBehavior.start_link(CounterBehavior, [initial: 5])
  """

  @type state() :: any()

  @callback init(Keyword.t()) :: state()

  @callback update(any(), state()) :: state()

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
    Keyword.fetch!(args, :initial)
  end

  @impl true
  def update(_command = :inc, state) do
    state + 1
  end

  def update(_command = :dec, state) do
    state - 1
  end

  @impl
  def show(state) do
    IO.puts(inspect(state))
  end
end
