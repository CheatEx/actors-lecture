defmodule State do
  def stateful(state) do
    IO.puts("I'm #{inspect(self())} and my state is #{state}")

    receive do
      {:set, set} ->
        stateful(set)

      {:quit, _} ->
        nil
    after
      5000 ->
        stateful(state)
    end
  end

  def run() do
    spawn(State, :stateful, ["Initial"])
  end
end
