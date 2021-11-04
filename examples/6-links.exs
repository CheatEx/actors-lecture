defmodule Signals do
  @moduledoc """
  > c "examples/5-links.exs"

  > h = spawn(Signals, :host_fn, [])
  > send(h, :hey)
  > Process.exit(h, :normal)
  > p = Signals.spawn(h, false)
  > Process.exit(p, :reason)
  > Process.exit(h, :reason)
  > send(h, {:hey_from, self()})

  > h = spawn(Signals, :host_fn, [])
  > p = Signals.spawn(h, true)
  > Process.exit(p, :reason)
  > send(h, :hey)

  > h = spawn(Signals, :host_fn_with_trap, [])
  > p = Signals.spawn(h, true)
  > Process.exit(p, :reason)
  > send(h, :hey)
  > Process.exit(h, :serious_reason)
  > Process.exit(h, :kill)
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
      {:spawn_link_bad, _from} ->
        pid = spawn_link(fn -> 1 = 2 end)
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
    action = if link do
      :spawn_link
    else
      :spawn
    end

    send(host, {action, self()})

    receive do
      {:spawned, pid} -> pid
    end
  end

  def spawn_bad(host) do
    send(host, {:spawn_link_bad, self()})
  end
end
