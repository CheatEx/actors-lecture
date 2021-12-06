defmodule Demo do
  @moduledoc """
  > c "examples/2-modules.exs"
  """

  def print(arg) do
    IO.puts(arg)
  end

  def case_function({:print, arg}) do
    IO.puts(arg)
  end

  def case_function({:ignore, _arg}) do
    :ignored
  end

  def safe_print(arg) when is_bitstring(arg) do
    IO.puts(arg)
  end

  def print_all(list) when is_list(list) do
    strs =
      for v <- list do
        inspect(v)
      end

    for s <- strs do
      IO.puts(s)
    end
  end
end
