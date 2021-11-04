{a, b} = {"A", "B"}

response = {:ok, "OK"}
response = {:error, "not OK"}
{:ok, result} = response

case response do
  {:ok, result} -> IO.puts(inspect(result))
  {:error, kind} -> IO.warn(inspect(kind))
end

str = "Hello!"
if String.length(str) > 10 do
  IO.puts(str)
else
  IO.puts("Too short")
end
