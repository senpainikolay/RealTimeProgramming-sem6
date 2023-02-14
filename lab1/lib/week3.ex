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


  defmodule Task5 do

    def new_queue() do
      spawn(fn -> loop([]) end)
    end

    def push(pid, value), do: push_helper(pid,value);
    def pop(pid), do: pop_helper(pid);


    defp push_helper(pid, value) do
      {_, val} = send(pid, {:push, value})
      if val do
        :ok
      end
    end

    defp pop_helper(pid) do
      send(pid, {:pop,self()})
      receive do
        val -> val
      end
    end

    defp loop( current_queue) do
      new_queue =
        receive do
          {:push, value} ->
            [value | current_queue]

          {:pop,caller} ->
            [h | t ] = current_queue
            send(caller, h)
            t
              _ ->
             IO.puts("Invalid Command")
        end
      loop(new_queue)
    end
  end



  defmodule Task6 do

    def create_semaphore(val) do
      spawn(fn -> sem(val) end)
    end

    def acquire(semaphore), do: acquire_helper(semaphore);
    def release(semaphore), do: release_helper(semaphore);

    defp acquire_helper(s) do
      send(s, {:request, self()})
      receive do
        perm -> perm
      end
    end

    defp release_helper(s) do
      send(s, :release )
    end

    defp sem(n) when n == 0 do
      receive do
           {:request, caller} -> send(caller, :not_granted); sem(0)
           :release -> sem(1)
        end
      end

      defp sem(n) when n > 0  do
          receive do
          {:request, caller} -> send(caller, :granted); sem(n - 1)
           :release ->  sem(n + 1)
           end
      end

  end







end
