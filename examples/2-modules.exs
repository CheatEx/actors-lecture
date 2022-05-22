defmodule Demo do
  @moduledoc """
  > c "examples/2-modules.exs"
  > Demo.print("Some")
  > Demo.case_function({:print, "Text"})
  > Demo.case_function({:ignore, "Text"})
  > Demo.case_function({:save, "Text"})
  > Demo.safe_print("Text")
  > Demo.safe_print(100)
  > Demo.print_all([1, "String", :atom, <<20>>])
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
      print(s)
    end
  end
end
