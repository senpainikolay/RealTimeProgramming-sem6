

defmodule CarSupervisor do
  def run(main_pid,functions) do
    state = Enum.into(functions, %{}, fn function ->
      pid = spawn function
      ref = Process.monitor(pid)
      {ref ,function}
    end)

    send(main_pid, :ready)
    supervise(state)
  end


  defp supervise(state) do
      receive do
        {:DOWN, _ref, :process, _pid, :normal} -> supervise(state)
        {:DOWN, ref, :process, _pid, _not_normal} ->
            {function, state} = Map.pop(state, ref)
            pid = spawn function
            ref = Process.monitor(pid)
            state = Map.put(state, ref,function)
            supervise(state)

        :exit -> :ok
       end
  end

end


defmodule CarSupervisor.CabinSensor do
  def start() do
    Process.register(self(), :cabinSensor)
    run()
  end

  defp run() do
    receive do
      :exit -> :ok
    end
    run()
  end
end


defmodule CarSupervisor.ChassisSensor do
  def start() do
    Process.register(self(), :chassisSensor)
    run()
  end

  defp run() do
    receive do
      :exit -> :ok
    end
    run()
  end
end


defmodule CarSupervisor.MotorSensor do
  def start() do
    Process.register(self(), :motorSensor)
    run()
  end

  defp run() do
    receive do
      :exit -> :ok
    end
    run()
  end
end



defmodule WheelSupervisor do
    def run() do
      functions = [&WheelSupervisor.WheelSensor.run/0,&WheelSupervisor.WheelSensor.run/0,&WheelSupervisor.WheelSensor.run/0,&WheelSupervisor.WheelSensor.run/0]
      state = Enum.into(functions, %{}, fn function ->
        pid = spawn function
        ref = Process.monitor(pid)
        {ref ,function}
      end)
      supervise(state)
    end


    defp supervise(state) do
        receive do
          {:DOWN, _ref, :process, _pid, :normal} -> supervise(state)
          {:DOWN, ref, :process, _pid, _not_normal} ->
              {function, state} = Map.pop(state, ref)
              pid = spawn function
              ref = Process.monitor(pid)
              state = Map.put(state, ref,function)
              supervise(state)

          :exit -> :ok
         end
    end

  end

defmodule WheelSupervisor.WheelSensor do
  def run() do
    receive do
      :exit -> :ok
    end
    run()
  end

end


defmodule CarSupervisor.CounterCrash do
  def start() do
    Process.register(self(), :counterCrash)
    run(0)
  end

  defp run(val) do
    receive do
      :incr ->
        cond do
          val > 3 ->  raise  "DEPLOYING AIRBAG!!!!" end
          true -> run(val+1)
          end
      :exit -> :ok
    after
      5000 -> run(0)
    end
  end
end



main_pid = self()

  spawn fn ->
    CarSupervisor.run(main_pid, [
    &CarSupervisor.CabinSensor.start/0,
    &CarSupervisor.ChassisSensor.start/0,
    &CarSupervisor.MotorSensor.start/0,
    &WheelSupervisor.run/0,
    &CarSupervisor.CounterCrash.start/0
    ])
  end


  receive do
    :ready -> :ok
  after
    4000 -> raise "supervisor hasn't started yet"
  end
