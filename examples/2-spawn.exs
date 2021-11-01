IO.puts("I'm a parent process #{inspect(self())}")
pid = spawn(fn -> IO.puts("I'm a spawned process #{inspect(self())}") end)
Process.alive? pid
pid = spawn(fn ->
  IO.puts("I'm a spawned process #{inspect(self())}")
  Process.sleep(:infinity)
end)
Process.alive?(pid)
Process.exit(pid, :stop_please)
Process.alive?(pid)
