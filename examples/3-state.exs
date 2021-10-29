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

  def test() do
    {_, var1} = {123, "Some"}
    IO.puts(var1)
    {_, var1} = {123, "Other"}
    IO.puts(var1)
    ^var1 = "Wrong"
    IO.puts(var1)
  end
end
