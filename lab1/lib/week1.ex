defmodule Week1 do

  # EX1
  def isPrime(n) when n <2 do
    "Cant use a number smalled than 2"
  end
  def isPrime(n) when n == 2 do
    true
  end
  def isPrime(n) when n > 1  do
    !Enum.any?(2..n-1, fn x -> checkRemainder(n, x) end)
  end

  def checkRemainder(x,y) do
    rem(x,y) == 0
  end

  #EX2
  def cylinderArea(h,r) do
    2 * 3.1415 * r * h + 2 * 3.1415 * r * r
  end

  #EX3
  def reverseList(a)when is_number(a),do: a
  def reverseList([]),do: []
  def reverseList([h|t]) do
    reverseList(t) ++ [h]
  end


  #EX4
  def uniqueSum(a) do
    sum(Enum.filter(a, fn x -> checkUnique(a,x) == true  end ))
  end

  defp checkUnique(a,elem)  do
    firstDuplicateRemovedList = List.delete(a,elem)
    cond do
      elem in firstDuplicateRemovedList -> false
      true -> true
    end
  end
  defp sum([]), do: 0
  defp sum([h|t] ) do
    h + sum(t)
  end

  #EX 5

  def extractRandomN(a,n) do
    cond do
      length(a) == n -> a
      true -> extractRandomN( List.delete_at(a, :rand.uniform(length(a))-1), n)
    end
  end


  # EX 6
  def firstFibonacciElements(n) do
    recFib([],1,n)
  end

  defp recFib(a,s,n) do
    cond do
      s == n+1 -> a
      true -> recFib( a++[getN(s)],s+1,n)
    end

  end
  defp getN(0), do: 0
  defp getN(1), do: 1
  defp getN(n), do: getN(n-1) + getN(n-2)

  #EX 7

  def translator(s) do
    d = %{ "mama" => "mother", "papa" => "father"}
    space_string(translate(String.split(s), d))
  end

  defp space_string([]),do: []
  defp space_string([h|t]) do
    ["#{h} "]  ++ space_string(t)
  end

  defp translate([],_),do: []
  defp translate([h|t],d) do
    [translateWord(h,d)] ++ translate(t,d)
  end

  defp translateWord(s,d) do
    ok  = Map.fetch(d,s)
    cond do
      ok == :error  -> s
      true -> {_,val} = Map.fetch(d,s);val
    end
   end


   #EX 8

   def smallestNumber(a,b,c) do
    [h|t] =  Enum.sort([ a,b,c])
    cond do
      h == 0 -> [h2|t2] = t; [ h2 | [h | t2]]
      true -> [h|t]
    end
   end


   # EX9
   def rotateLeft(a,n) do
    rotateMe(a,n,0)
   end

   defp rotateMe([h|t],n,c) do
    cond do
      c == n -> [h|t]
      true -> rotateMe(t ++ [h], n, c+1)
    end
   end


   #EX10

   def listRightAngleTriangles do
    rangeTuples = for x <-1..20, y <- 1..20, z <-1..20, do: {x,y,z}
    recParse(rangeTuples)
  end

   defp recParse([]),do: []
   defp recParse([h|t]) do
    filterTuples(h) ++ recParse(t)
   end

   defp filterTuples(x)  do
    {a,b,c} = x
    cond do
      a**2 +  b**2 ==  c**2 -> [x]
      true -> []
    end
   end

  ######################################### MAIN #####################################################################################################
   #EX11
   def removeConsecutiveDuplicates([]), do: []
   def removeConsecutiveDuplicates([h|t]) do
   cond do
     length(t) >1 -> [h2|t2] = t;
     if h==h2 do
       removeConsecutiveDuplicates(t2)
     else
      [h]++removeConsecutiveDuplicates(t)
     end
     true ->
      if [h] == t do
        []
      else
        [h]++t
      end
   end
  end

  #EX12

  def lineWords(a) do
    Enum.filter(a, fn x -> lookUpCharListWord(String.to_charlist(x))  end)
  end
  defp lookUpCharListWord(a) do
    d = %{ :a => "qwertyuiopQWERTYUIOP", :b => "asdfghjklASDFGHJKL",:c => "zxcvbnmZXCVBNM"}
    cond do
      a == Enum.filter(a, fn x -> isItInRow(x,d[:a]) end) -> true
      a == Enum.filter(a, fn x -> isItInRow(x,d[:b]) end) -> true
      a == Enum.filter(a, fn x -> isItInRow(x,d[:c]) end) -> true
      true -> false
    end
  end
  defp isItInRow(a,d) do
    Enum.any?(String.to_charlist(d), fn x -> x == a end)
  end

  #EX13

  def encode(s,n) do
    s = String.downcase(s)
    Enum.map(String.to_charlist(s), fn x -> rem(x+n-97,26)+97 end)
  end
  def decode(s,n) do
    s = String.downcase(s)
    Enum.map(String.to_charlist(s), fn x -> rem(x-n-97,26)+97 end)
  end

  #EX14


  def lettersCombinations(s) do
    d = %{ 50 => "abc", 51 => "def", 52 => "ghi", 53 => "jkl", 54 => "mno", 55 => "pqrs", 56 => "tuv",  57 => "wxyz"}
    group(String.to_charlist(s),d)
  end
  defp group([h|t],d), do: group(String.to_charlist(d[h]),t,d)
  defp group(res,[] ,_), do: res
  defp group(res,[h|t] ,d) do
    new  = for x <- res, y <- String.to_charlist(d[h]), do: List.flatten([x,y])
     group(new,t,d)
  end


  #EX15

  def  groupAnagrams(a) do
     groupAnagrams(%{},a)
  end
  defp groupAnagrams(map,[]), do: map
  defp groupAnagrams(map,[h|t]) do
    newMap = buildMap(map,h)
    groupAnagrams(newMap,t)
  end

  def buildMap(currentMap,w) do
    sw = Enum.sort(String.to_charlist(w))
    ok  = Map.fetch(currentMap,sw)
    cond do
      ok == :error  -> currentMap = Map.put(currentMap, sw, [w]); currentMap
      true -> currentMap =   Map.update!(currentMap, sw, &(&1 ++ [w])); currentMap
    end


  end






end



# IO.puts(Week1.isPrime(7))
# IO.puts(Week1.cylinderArea(3,4))
# IO.inspect(Week1.reverseList([1,2,3]))
# IO.inspect(Week1.uniqueSum([1,2,4,8,4,2]))
# IO.inspect(Week1.extractRandomN([1,2,4,8,4],3))
# IO.inspect(Week1.firstFibonacciElements(7) )
# IO.puts(Week1.translator("mama is with papa"))
#IO.inspect(Week1.smallestNumber(2,1,0))
#IO.inspect(Week1.rotateLeft([1,2,4,8,4],3))
# IO.inspect(Week1.listRightAngleTriangles())
#IO.inspect(Week1.removeConsecutiveDuplicates([1,2,2,2,4,8,4]))
#IO.inspect(Week1.lineWords(["Hello", "Alaska", "Dad", "Peace"]))
#IO.puts(Week1.encode("kekFaf",4))
# IO.inspect(Week1.decode("oiojej",4))
#IO.inspect(Week1.lettersCombinations("23"))
IO.inspect(Week1.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
