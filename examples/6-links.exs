defmodule Signals do
  @moduledoc """
  Diagram

  > c "examples/6-links.exs"

  // After plain spawn process may exit independently
  > h = spawn(Signals, :host_fn, [])
  > Process.alive?(h)
  > p = Signals.spawn(h, false)
  > Process.exit(p, :reason)
  > Process.alive?(p)
  > Process.alive?(h)
  > Process.exit(h, :reason)
  > Process.alive?(h)

  // After spawn_link process terminated together
  > h = spawn(Signals, :host_fn, [])
  > p = Signals.spawn(h, true)
  > Process.exit(p, :reason)
  > Process.alive?(p)
  > Process.alive?(h)

  // Trap allows process handle termination
  > h = spawn(Signals, :host_fn_with_trap, [])
  > p = Signals.spawn(h, true)
  > Process.exit(p, :reason)
  > Process.alive?(p)
  > Process.alive?(h)
  > Process.exit(h, :serious_reason)
  > Process.alive?(h)
  > Process.exit(h, :kill)
  > Process.alive?(h)
  """

  def host_fn() do
    receive do
      {:EXIT, source, reason} ->
        IO.puts("EXIT from #{inspect(source)} reason #{inspect(reason)}")

      {:spawn, from} ->
        pid = spawn(fn -> Process.sleep(:infinity) end)
        send(from, {:spawned, pid})

      {:spawn_link, from} ->
        pid = spawn_link(fn -> Process.sleep(:infinity) end)
        send(from, {:spawned, pid})

      message ->
        IO.puts("A message #{inspect(message)}")
    end

    host_fn()
  end

  def host_fn_with_trap() do
    Process.flag(:trap_exit, true)
    host_fn()
  end

  def spawn(host, link) do
    action =
      if link do
        :spawn_link
      else
        :spawn
      end

    send(host, {action, self()})

    receive do
      {:spawned, pid} -> pid
    end
  end
end
