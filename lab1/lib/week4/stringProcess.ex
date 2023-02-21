defmodule StringProcess do
  def run(main_pid, functions) do
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

    end
  end
end


defmodule StringProcess.SpaceSpliter do
  def start() do
    Process.register(self(), :spaceSpliter)
    spawn_link( fn -> StringProcess.DowncaseSwapper.start() end)
    spawn_link( fn -> StringProcess.StringAssembly.start() end)


    run()
  end
  defp run() do
    receive do
      {:split, s } ->
        arr = String.to_charlist(s)
        splitS(arr,[])
      :exit -> :ok
    end
    run()
  end

  defp splitS([],w) do
    if w != [] do
      send(:downcaseSwapper,{:downcase, List.to_string(w) })
    end
    :ok
  end
  defp splitS([h|t],w) do
    cond do
      h == 32 ->
        if w != [] do
          send(:downcaseSwapper,{:downcase, List.to_string(w) } )
        end
        splitS(t,[])

      true -> splitS(t,w ++ [h])
    end
  end
end


defmodule StringProcess.DowncaseSwapper do

  def start() do
    Process.register(self(), :downcaseSwapper)
    run()
  end

  defp run() do
    receive do
      {:downcase, s  } ->
        downCaseString = String.downcase(s)
        {indexMap,len} = mapBuilder(String.to_charlist(downCaseString),0,%{})
        range = indexTuples(len)
        allPossibleCombinations = Enum.filter(range, fn x -> {idx1,idx2} = x;  filterIndexesByChars(idx1,idx2,indexMap) end )
        indexSwapMap = filterAllPossibleCombitaions(allPossibleCombinations,%{},%{})
        finalString = swapLetters(Map.to_list(indexSwapMap),String.to_charlist(downCaseString))
        send(:transformerAssembly,{:addString, finalString})
      :exit -> raise "Exited Abnormaly!!! (actually called normally)"
    end
    run()
  end
  defp swapLetters([],finalArr), do: List.to_string(finalArr)
  defp swapLetters([h|t],finalArr) do
    {idx1,idx2} = h
    finalArr = swap(finalArr,idx1,idx2)
    swapLetters(t,finalArr)
  end

  defp swap(a, i1, i2) do
    e1 = Enum.at(a, i1)
    e2 = Enum.at(a, i2)
    a
    |> List.replace_at(i1, e2)
    |> List.replace_at(i2, e1)
  end

  defp filterAllPossibleCombitaions([],_,finalMap), do: finalMap
  defp filterAllPossibleCombitaions([h|t], newMap,finalMap) do
    {idx1, idx2} = h
    keyList = Enum.map( Map.to_list(newMap), fn x-> {a,_} = x;a end)
    valueList = Enum.map( Map.to_list(newMap), fn x-> {_,a} = x;a end)
    if Map.has_key?(newMap, idx1) == false and idx2 not in keyList   and idx1 not in valueList  do
    newMap = Map.put(newMap,idx1,idx2)
    newMap = Map.put(newMap,idx2,idx1)
    finalMap =  Map.put(finalMap,idx1,idx2)
    filterAllPossibleCombitaions(t, newMap,finalMap)
    else
    filterAllPossibleCombitaions(t, newMap,finalMap)
    end

  end

  defp filterIndexesByChars( idx1, idx2, indexMap ) do
    ch1 = indexMap[idx1]
    ch2  = indexMap[idx2]
    cond do
      ch1 == 109 && ch2 == 110 -> true
      ch2 == 109 && ch1 == 110 -> true
      true -> false
    end
  end

  defp indexTuples(len) do
     for x <- 0..len-1, y <- 0..len-1, do: {x,y}
  end

  defp mapBuilder([],c,current_map), do:  {current_map,c}
  defp mapBuilder([h|t],c, current_map) do
    current_map = Map.put(current_map,c, h)
    mapBuilder(t,c+1,current_map)
  end


end



defmodule StringProcess.StringAssembly do
  def start() do
    Process.register(self(), :transformerAssembly)
    run("")
  end

  defp run(finalString) do
    receive do
      {:addString, s } ->
        finalString = finalString <> " " <> s
        IO.inspect(finalString)
        run(finalString)
      :exit -> :ok
    end
    run(finalString)
  end
end





main_pid = self()
spawn fn ->
  StringProcess.run(main_pid, [&StringProcess.SpaceSpliter.start/0])
end


receive do
  :ready -> :ok
after
  1000 -> raise "supervisor hasn't started yet"
end

send(:spaceSpliter, {:split, "   ok   LOl   MoNster"})
:timer.sleep(100)

send(:downcaseSwapper, :exit)
:timer.sleep(2000)
send(:spaceSpliter, {:split, "   ok   LOl   MoNster"})
