IO.puts("I'm a parent process #{inspect(self())}")
spawn(fn -> IO.puts("I'm a spawned process #{inspect(self())}") end)
