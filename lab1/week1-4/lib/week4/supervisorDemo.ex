defmodule SupervisorTask1 do

  def run(main_pid, n) do
    processMap = buildMap(%{},n)
    send(main_pid, :ready)
    supervise(processMap)
  end

  defp buildMap(currentMap, n) do
    cond do
      n == 0 ->currentMap
      true ->
        pid = spawn( fn -> workerLogic(n) end)
        ref = Process.monitor(pid)
        currentMap = Map.put(currentMap, ref, n)
        buildMap(currentMap,n-1)
    end
  end

  defp supervise(processMap) do
    processMap =
      receive do
        # do nothing if the process exited normally
        {:DOWN, ref, :process, _pid, :normal} ->
          {id, processMap} = Map.pop(processMap, ref)
          pidRespawned = spawn( fn ->  workerLogic(id) end )
          IO.inspect("Revived  Worker #{id} and replaced him")
          ref = Process.monitor(pidRespawned)
          Map.put(processMap, ref, id)
        end
    supervise(processMap)
  end

  defp workerLogic(id) do
    randNumberToSleep = :rand.uniform(10000) + 1000
    :timer.sleep(randNumberToSleep)
    IO.inspect(" Worker #{id}  is dead!!")
  end

  def loopMe() do
    :timer.sleep(100000)
    loopMe()
  end

end



main_pid = self()
spawn fn ->
  SupervisorTask1.run(main_pid, 2)
end

receive do
  :ready -> SupervisorTask1.loopMe()
after
  1000 -> raise "supervisor hasn't started yet"
end
