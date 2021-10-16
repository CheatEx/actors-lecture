defmodule Communication do
  @moduledoc """
  > c "examples/3-communication.exs"
  > import Communication
  > c = spawn_controller()
  > check_counts(c)
  > spawn_peers(c, 1000)
  > check_counts()
  """

  def spawn_controller() do
    spawn(Communication, :controller_fn, [])
  end

  def check_counts(controller_pid) when is_pid(controller_pid) do
    send(controller_pid, {:get_count, self()})

    receive do
      {:count, value} ->
        value
    after
      5000 -> nil
    end
  end

  def spawn_peers(controller_pid, number)
      when is_pid(controller_pid) and is_number(number) and number >= 0 do
    Range.new(1, number)
    |> Enum.each(fn _ -> spawn(Communication, :peer_fn, [controller_pid]) end)
  end

  def controller_fn() do
    controller_loop(0)
  end

  def controller_loop(count) do
    new_count =
      receive do
        {:peer, peer_pid} ->
          send(peer_pid, {:ping, self()})
          count

        {:pong, _} ->
          count + 1

        {:get_count, pid} ->
          send(pid, {:count, count})
          count
      end

    controller_loop(new_count)
  end

  def peer_fn(controller_pid) when is_pid(controller_pid) do
    send(controller_pid, {:peer, self()})
    peer_loop(nil)
  end

  defp peer_loop(state) do
    receive do
      {:ping, from} ->
        send(from, {:pong, :pong})
        peer_loop(state)
    end
  end
end
