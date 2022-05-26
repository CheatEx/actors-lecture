defmodule Communication do
  @moduledoc """
  > c "examples/5-communication.exs"
  > c = spawn(Communication, :controller_fn, [])
  > Communication.check_counts(c)
  > Communication.spawn_peers(c, 1000)
  > Communication.check_counts(c)
  """

  def controller_fn() do
    controller_loop(0)
  end

  def controller_loop(count) do
    new_count =
      receive do
        {:pong, _} ->
          count + 1

        {:get_count, pid} ->
          send(pid, {:count, count})
          count
      end

    controller_loop(new_count)
  end

  def check_counts(controller_pid) do
    send(controller_pid, {:get_count, self()})

    receive do
      {:count, value} ->
        value
    after
      5000 -> nil
    end
  end

  def spawn_peers(controller_pid, number) do
    Range.new(1, number)
    |> Enum.map(fn _ -> spawn(Communication, :peer_fn, []) end)
    |> Enum.each(fn p -> send(p, {:ping, controller_pid}) end)
  end

  def peer_fn() do
    peer_loop()
  end

  def peer_loop() do
    receive do
      {:ping, from} ->
        send(from, {:pong, :pong})
        peer_loop()
    end
  end
end
