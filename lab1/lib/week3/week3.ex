defmodule Week3 do

  # EX 1

  defmodule Task1 do

    def start() do
      spawn &loop/0
    end
    defp loop() do
      receive do
        val -> IO.puts("I received the #{val}")
      end
      loop()
    end

  end

  defmodule Task2 do

    def start() do
      spawn(fn -> loop() end)
    end

    defp loop() do
      receive do
        {value, caller} ->
          cond do
            is_integer(value) -> send(caller, value+1 )
            is_bitstring(value) -> send(caller, String.downcase(value))
            true ->  send(caller, "IDK whats going on ")
          end
      end
      loop()
    end
  end

  defmodule Task3 do

    def start(pid) do
      spawn(fn -> loop(pid) end)
    end

    defp loop(), do: loop()
    defp loop(pid) do
      Process.monitor(pid)
      receive do
        _ -> IO.puts("PID 1 depisted the pid 2 shutdown"); loop();
      end
      loop(pid)
    end

    def simulate() do
      pid = spawn fn -> :timer.sleep(2000);IO.puts("PID 2 going nani") end
      kek = start(pid)
      kek
    end
  end

  defmodule Task4 do

    def start() do
      spawn(fn -> loop(0,0) end)
    end

    defp loop(average, counter) do
      receive do
        value ->  IO.inspect("Current average: #{(average+value) / (counter+1)}"); loop(average+value, counter+1);
        end
      loop(average,counter)
    end

  end







end
