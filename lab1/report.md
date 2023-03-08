# FAF.PTR16.1 -- Project 0
> **Performed by:** Nicolae Gherman, group FAF-202
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

**Task 1** -- Write a script that would print the message “Hello PTR” on the screen. 


```elixir
  def hello() do
    "Hello PTR"
  end
```

Printing hello PTR!

**Task 2** --  Create a unit test for your project. Execute it.

```elixir
defmodule Week0Test do
  use ExUnit.Case
  doctest Week0

  test "greets the world" do
    assert Week0.hello() == "Hello PTR"
  end
end
```

Executes the assetion on the printing the hello PTR string.

## P0W2

**Task 1** -- Write a function that determines whether an input integer is prime.

```elixir
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
``` 
This function takes an integer n as input and returns a boolean value indicating whether n is a prime number or not. It does this by defining multiple function clauses, each with a different guard condition. The first clause handles the case where n is less than 2 and returns a string message. The second clause handles the case where n is equal to 2 and returns true. The third clause handles the general case where n is greater than 1 and uses the Enum.any? function to check if any number between 2 and n-1 divides n evenly. If none of them do, then n is prime and the function returns true. Otherwise, it returns false. 


**Task 2** -- Write a function to calculate the area of a cylinder, given it’s height and
radius.


```elixir
io:format("Your code for task 2 goes here..")
``` 

**Task 2** -- Write a function to calculate the area of a cylinder, given it’s height and
radius.


```elixir
  def cylinderArea(h,r) do
    2 * 3.1415 * r * h + 2 * 3.1415 * r * r
  end
``` 

This function takes two arguments, h and r, representing the height and radius of a cylinder respectively. It then calculates and returns the total surface area of the cylinder using the formula 2πrh + 2πr^2.


**Task 3** --  Write a function to reverse a list.


```elixir
def reverseList(a)when is_number(a),do: a
  def reverseList([]),do: []
  def reverseList([h|t]) do
    reverseList(t) ++ [h]
  end
``` 

This function takes a list as input and returns a new list with the elements in reverse order. It defines three function clauses, each with a different pattern-matching condition. The first clause handles the case where the input is a single number, and simply returns that number as is. The second clause handles the case where the input list is empty, and returns an empty list. The third clause handles the general case where the input list has at least one element, and recursively calls reverseList on the tail of the list (t) and concatenates it with a list containing the head of the list (h). This effectively reverses the order of the list. 

 
**Task 4** -- Write a function to calculate the sum of unique elements in a list.



```elixir
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
  ```  

It uses the Enum.filter function to iterate over the list a and select only the elements that are unique. This is done by calling the checkUnique function on each element and selecting the elements for which checkUnique returns true.

The checkUnique function receives the list a and an element elem as arguments. It creates a new list called firstDuplicateRemovedList by deleting the first occurrence of elem from a. If elem is present in firstDuplicateRemovedList, it means that there are other occurrences of elem in a, so checkUnique returns false. Otherwise, it returns true.

The resulting list of unique elements is passed to the sum function, which returns the sum of all the elements.
 
**Task 5** -- Write a function that extracts a given number of randomly selected elements from a list.


```elixir
 def extractRandomN(a,n) do
    cond do
      length(a) == n -> a
      true -> extractRandomN( List.delete_at(a, :rand.uniform(length(a))-1), n)
    end
  end
``` 

It first checks whether the length of a is equal to n. If it is, the function simply returns the entire list a.

If the length of a is not equal to n, the function calls itself recursively, passing in a new list that is created by deleting a randomly selected element from a. This process repeats until the length of the new list is equal to n.

The List.delete_at function is used to delete a randomly selected element from the list a. The :rand.uniform(length(a))-1 expression generates a random integer between 0 and length(a)-1, which is used as the index of the element to be deleted. 

 
**Task 6** --   Write a function that returns the first n elements of the Fibonacci sequence.



```elixir
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

``` 

It calls the recFib function, passing in an empty list, the integer 1, and the integer n.

The recFib function receives the list a, an integer s, and an integer n as arguments. It first checks whether s is equal to n+1. If it is, it means that a contains the first n elements of the Fibonacci sequence, so it returns a.

If s is not equal to n+1, the function calls itself recursively, passing in a new list that is created by appending the next element of the Fibonacci sequence to a, and incrementing s by 1.

The getN function is used to compute the next element of the Fibonacci sequence. It receives an integer n as an argument and returns the n-th element of the Fibonacci sequence. 


 
**Task 7** --  Write a function that, given a dictionary, would translate a sentence. Words not found in the dictionary need not be translated.

```elixir
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
   ``` 

The String.split(s) function splits the input string into a list of words.

The translate function takes two arguments: a list of words and the translation map. It recursively translates each word in the list and returns a list of translated words.

The translateWord function takes a single word and the translation map as arguments. It tries to fetch the translation from the map using the word as a key. If the key is not found in the map, it returns the original word. Otherwise, it returns the translation.

The space_string function takes a list of words and adds a space after each word. It recursively adds spaces to each word in the list and returns a new list with the spaces added.


**Task 8** --  Write a function that receives as input three digits and arranges them in an order that would create the smallest possible number. Numbers cannot start with a 0.


```elixir
def smallestNumber(a,b,c) do
    [h|t] =  Enum.sort([ a,b,c])
    cond do
      h == 0 -> [h2|t2] = t; [ h2 | [h | t2]]
      true -> [h|t]
    end
   end
   ``` 

This function takes three arguments a, b, and c, and it returns a sorted list of these numbers with the smallest number in the first position of the list.

The first line of the function sorts the input list using Enum.sort/1 and assigns the result to [h|t]. Here, h will be the first element of the sorted list and t will be the rest of the list.

The cond statement is used to check whether the smallest number in the list is zero. If so, it will swap the first non-zero number with zero, so that zero is still the first element of the list. The [h2|t2] = t line assigns the first element of the t list (which should be the smallest non-zero number) to h2 and the rest of the list to t2. The final line returns a list with h2 as the first element, followed by h (which is zero), followed by the rest of the list t2.

If the smallest number is not zero, the true branch of the cond statement is executed and the sorted list [h|t] is returned as is.


**Task 9** -- Write a function that would rotate a list n places to the left


```elixir
  def rotateLeft(a,n) do
    rotateMe(a,n,0)
   end

   defp rotateMe([h|t],n,c) do
    cond do
      c == n -> [h|t]
      true -> rotateMe(t ++ [h], n, c+1)
    end
   end
   ``` 

The function rotateLeft takes an input list a and an integer n, and returns a new list that is the result of rotating the original list a n positions to the left.

The implementation of rotateLeft is quite simple: it just calls the rotateMe helper function with an initial counter value of 0.

The rotateMe helper function takes three arguments: the list to be rotated ([h|t]), the number of positions to rotate it by (n), and a counter variable (c). It uses a conditional expression to decide what to do: if the counter c is equal to the number of positions to rotate n, it just returns the input list as it is; otherwise, it recursively calls itself with the tail of the input list (t) followed by the head of the input list ([h]), and increments the counter c by 1.

The effect of this is that the list is rotated one position to the left on each recursive call, until the counter c reaches the target number of positions to rotate n. Once that happens, the final list is returned.



**Task 10** -- Write a function that lists all tuples a, b, c such that a2+b2 = c2 and a, b ≤ 20.


```elixir
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
   ``` 

This code defines a function listRightAngleTriangles that generates a list of tuples representing right-angled triangles.

The function starts by defining a list of tuples rangeTuples, where each tuple contains three integers ranging from 1 to 20. This is achieved using a list comprehension.

Next, the recParse function is called on this list. recParse is a recursive function that takes a list of tuples and returns a new list of tuples that meet certain criteria. If the input list is empty, recParse returns an empty list. Otherwise, it calls filterTuples on the first tuple in the list, and then recursively calls itself on the remaining tuples in the list, concatenating the results of the two calls. This effectively filters out the tuples that do not meet the criteria for a right-angled triangle.

filterTuples takes a single tuple as input, and uses pattern matching to extract the three values. It then uses a cond block to check if the tuple represents a right-angled triangle. If it does, it returns a list containing the input tuple. Otherwise, it returns an empty list.

In summary, the listRightAngleTriangles function generates a list of tuples representing right-angled triangles, by first creating a list of all possible tuples of three integers from 1 to 20, and then filtering out the tuples that do not represent right-angled triangles.



**Task 11** --  Write a function that eliminates consecutive duplicates in a list.


```elixir
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
``` 

The function takes a list as its argument, and the first clause of the function handles the case where the list is empty, simply returning an empty list.

In the second clause, the function pattern matches the list into its first element, h, and the rest of the list, t. It then uses a cond expression to determine what to do based on the length of the list.

If the length of the list is greater than one, the function pattern matches the rest of the list, t, into its first element, h2, and the remaining list, t2. It then checks if h is equal to h2. If it is, it recursively calls removeConsecutiveDuplicates on t2 to remove the duplicate elements. If it is not, it returns a list containing h followed by the result of recursively calling removeConsecutiveDuplicates on t.

If the length of the list is not greater than one, the function checks if h is equal to the list, [h]. If it is, it returns an empty list. If it is not, it returns a list containing h.

In summary, this function iterates through the list, checking each element against its neighbor. If two adjacent elements are equal, it removes one of them. It continues this process until there are no more consecutive duplicates in the list.



**Task 12** -- Write a function that, given an array of strings, will return the words that can be typed using only one row of the letters on an English keyboard layout. 


```elixir
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
``` 

The lineWords(a) function takes a list of strings as input and returns a new list containing only the strings that contain characters from only one row of the keyboard. It does this by filtering the input list with the Enum.filter function, which takes a function as its second argument that determines whether to keep or discard each element of the input list. In this case, the function is defined using the anonymous function syntax fn x -> lookUpCharListWord(String.to_charlist(x)) end, which calls the lookUpCharListWord function on the input string after converting it to a list of characters with String.to_charlist.

The lookUpCharListWord(a) function takes a list of characters as input and checks whether all characters are from the same row of the keyboard. It does this by defining a map d that associates each row of the keyboard (as a string) with a key (:a, :b, or :c). It then checks if the input list matches one of the rows of the keyboard using the Enum.filter function and the isItInRow function defined below. If the input list matches one of the rows, the function returns true, and false otherwise.

The isItInRow(a,d) function takes a character and a string as input and checks whether the character is in the string. It does this using the Enum.any? function, which returns true if the given function is true for any element in the input list. In this case, the function is defined using the anonymous function syntax fn x -> x == a end, which checks whether a is equal to the current character in the input string. The Enum.any? function returns true if this function is true for any character in the input string, indicating that the input character is in the string.



**Task 13** --  Create a pair of functions to encode and decode strings using the Caesar cipher



```elixir
 def encode(s,n) do
    s = String.downcase(s)
    Enum.map(String.to_charlist(s), fn x -> rem(x+n-97,26)+97 end)
  end
  def decode(s,n) do
    s = String.downcase(s)
    Enum.map(String.to_charlist(s), fn x -> rem(x-n-97,26)+97 end)
  end
``` 

Caesar cipher implemented.



**Task 14** -- White a function that, given a string of digits from 2 to 9, would return all possible letter combinations that the number could represent (think phones with buttons).


```elixir

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
  ``` 

This code defines a function lettersCombinations/1 that takes a string as input and returns a list of all possible combinations of letters that can be created from the numbers on a phone keypad corresponding to the input string.

The function first defines a map d that associates each number on the keypad with the corresponding letters, then passes the input string and the map to the group/2 function.

The group/2 function takes two arguments: the first is a list of characters, and the second is the map d. The function recursively groups the characters in the first list according to the corresponding letters in the map, and returns a list of all possible combinations.

The function works by first taking the first character from the list and looking up its corresponding letters in the map. It then recursively calls group/2 with the resulting list of letters and the remainder of the input list.

The group/2 function returns the final result when the input list is empty, i.e., when all the characters in the input string have been processed. In this case, the function returns the list of possible combinations of letters.



**Task 15** -- White a function that, given an array of strings, would group the anagrams together.


```elixir

  def  groupAnagrams(a) do
     groupAnagrams(%{},a)
  end
  defp groupAnagrams(map,[]), do: map
  defp groupAnagrams(map,[h|t]) do
    newMap = buildMap(map,h)
    groupAnagrams(newMap,t)
  end

  defp buildMap(currentMap,w) do
    sw = Enum.sort(String.to_charlist(w))
    ok  = Map.fetch(currentMap,sw)
    cond do
      ok == :error  -> currentMap = Map.put(currentMap, sw, [w]); currentMap
      true -> currentMap =   Map.update!(currentMap, sw, &(&1 ++ [w])); currentMap
    end
  end
  ``` 

The groupAnagrams function is called with the list of words a.
It initializes an empty map and calls the helper function groupAnagrams/2 with the empty map and the list a.
The groupAnagrams/2 function checks if the list is empty. If it is, it returns the map.
If the list is not empty, it calls the buildMap function with the current map and the first word in the list h.
The buildMap function sorts the letters of the word and fetches the value for the sorted letters from the current map using Map.fetch. If the value is not found, it adds a new key-value pair to the current map where the key is the sorted letters and the value is a list with the current word w. Otherwise, it updates the value for the key by appending the current word w to the existing list using Map.update!.
The groupAnagrams/2 function then recursively calls itself with the updated map and the remaining words in the list t.
When the last word is processed, the final map is returned.





**Task 16** -- Write a function to find the longest common prefix string amongst a list of strings.


```elixir
def commonPrefix(a) do
    kek =   Map.to_list(commonPrefix(a,%{}))
    {_, maxCounter} =  Enum.max_by(kek, fn x -> {_,c} = x; c end)
    maxCounterList =  Enum.filter( kek, fn x -> {_,c} = x; c == maxCounter end )
    Enum.max_by(maxCounterList, fn x -> {a,_} = x; a = List.to_string(a); String.length(a) end)
 end

 # return a map with counter of each prefix/met words actually :)
 defp commonPrefix([], map), do: map
  defp  commonPrefix([h|t],map) do
    descomposedW = descomposeWord([],String.to_charlist(h),[])
    returnedMap = commonPrefixMap(map,descomposedW)
    commonPrefix(t,returnedMap)

 end



 ## Would return a list of splitted word ['f', 'fl', 'flo' .... 'flower']

 defp descomposeWord(_,[],finalRes), do: finalRes
 defp descomposeWord(res,[h|t], finalRes) do
   new =  res ++ [h]
   descomposeWord(new,t, finalRes ++ [new])
end
 ## Same logic as  in ex 15
 defp commonPrefixMap(map,[]), do: map
 defp commonPrefixMap(map,[h|t]) do
   newMap = buildPrefixMap(map,[h])
   commonPrefixMap(newMap,t)
 end

 defp buildPrefixMap(currentMap,w) do
   ok  = Map.fetch(currentMap,w)
   cond do
     ok == :error  -> currentMap = Map.put(currentMap, w, 1); currentMap
     true -> currentMap =   Map.update!(currentMap, w, &(&1 + 1)); currentMap
   end
 end
``` 

This code defines a function commonPrefix(a) that takes a list of strings a and returns the longest common prefix among them. The function first calls a private helper function commonPrefix(a, %{}), passing an empty map as the initial state. The helper function recursively processes each word in the list and constructs a map with the count of each prefix in all words. The logic for constructing the prefix map is similar to that of exercise 15.

Once the helper function completes, the main commonPrefix function extracts the prefix with the highest count from the map and returns it. It first converts the map to a list of tuples (prefix, count), then finds the maximum count. It then filters the list to extract only the tuples with the maximum count, and finds the tuple with the longest prefix among them. Finally, it converts the longest prefix back to a string and returns it.

The private helper function commonPrefixMap(map, []) takes a map and an empty list, and simply returns the map. The private helper function commonPrefixMap(map, [h|t]) takes a map and a list containing the head h and the tail t. It calls another private helper function buildPrefixMap to construct a new map with the count of the current prefix. It then recursively calls commonPrefixMap with the tail of the list and the updated map.

The private helper function buildPrefixMap(currentMap, w) takes a map currentMap and a list w representing a prefix. It fetches the count of the prefix from the map using Map.fetch. If the prefix is not in the map, it adds it with a count of 1 using Map.put. If the prefix is already in the map, it updates the count by 1 using Map.update!.

The private helper function descomposeWord(res, [h|t], finalRes) takes an accumulator list res, a list [h|t] representing a word, and an accumulator list finalRes. It recursively splits the word into prefixes using the accumulator list res. At each recursive call, it adds the current prefix to the accumulator list and recursively calls itself with the tail of the list and the updated accumulator list. It returns the final accumulator list finalRes, which is a list of all prefixes of the word.

 

## P0W3

**Task 1** -- Create an actor that prints on the screen any message it receives

```elixir

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
  ``` 

 module has two functions: start and loop. The start function starts a new process (using the spawn function) and executes the loop function within it. The loop function listens for a message using the receive construct. When it receives a message, it prints out a string containing the received value, and then loops again.




**Task 2** --  Create an actor that returns any message it receives, while modifying it. 

```elixir
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
  ``` 

The Task2 module also has two functions: start and loop. The start function starts a new process (using the spawn function) and executes the loop function within it. The loop function listens for a message using the receive construct. When it receives a message, it checks the type of the received value using the is_integer and is_bitstring functions. If the value is an integer, it sends back the value incremented by 1 to the process that sent the message. If the value is a string, it sends back the lowercase version of the string to the process that sent the message. If the value is neither an integer nor a string, it sends back the string "IDK whats going on" to the process that sent the message. Then it loops again, waiting for the next message. 



**Task 3** -- Create a two actors, actor one ”monitoring” the other. If the second actor stops, actor one gets notified via a message.



```elixir
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
  ``` 

The start function is used to start a new process (loop) that will monitor the pid process. The loop function starts by calling Process.monitor(pid), which sets up a monitor on the pid process so that the supervisor process will receive a message if the monitored process terminates for any reason.

Next, the loop function waits to receive a message using the receive block. In this case, the block simply prints "PID 1 depisted the pid 2 shutdown" to the console and then calls itself recursively to wait for another message.

The simulate function returns the value of calling start(pid), which starts the loop process and returns a reference to it (kek). This reference can be used later to interact with the loop process.


**Task 4** --  Create an actor which receives numbers and with each request prints out the current average.


```elixir
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
  ``` 

 Keeping counter in the loop parameter and addiging accodingly to the call.


 **Task 5** --  Create an actor which maintains a simple FIFO queue. You should write helper functions to create an API for the user, which hides how the queue is implemented.


```elixir
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
``` 

The new_queue function creates a new process that runs the loop function and initializes it with an empty queue.

The push function sends a message to the specified process (pid) with a value to push onto the queue. It uses the push_helper function to send the message and receive a response, which is a tuple containing an :ok atom and the original value.

The pop function sends a message to the specified process to pop a value from the queue. It uses the pop_helper function to send the message and then waits to receive a response, which is the popped value.

The push_helper and pop_helper functions are helper functions that actually send the messages and handle the responses.

The loop function is the heart of the queue implementation. It waits to receive messages from the process mailbox using the receive block. If the message is a :push message, it adds the value to the current queue and returns the new queue. If the message is a :pop message, it removes the first value from the current queue and sends it back to the caller process. If the message is anything else, it prints "Invalid Command" to the console. The loop function then recursively calls itself with the new queue.




**Task 6** --  Create a module that would implement a semaphore.


```elixir
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
``` 


The acquire function sends a :request message to the specified semaphore process and waits to receive a response. If the response is :granted, it means the semaphore is available and the function returns :ok. If the response is :not_granted, it means the semaphore is currently unavailable and the function waits for another chance to acquire the semaphore.

The release function sends a :release message to the specified semaphore process.

The acquire_helper and release_helper functions are helper functions that actually send the messages and handle the responses.

The sem function is the heart of the semaphore implementation. It waits to receive messages from the process mailbox using the receive block. If the message is a :request message, it checks the value of the semaphore (n). If n is greater than 0, it decrements n and sends a :granted response to the requester process. If n is 0, it sends a :not_granted response to the requester process. If the message is a :release message, it increments n. The sem function then recursively calls itself with the updated value of n.

**Task 7** -- Create a module that would perform some risky business. Start by creating a scheduler actor. When receiving a task to do, it will create a worker node that will perform the
task. Given the nature of the task, the worker node is prone to crashes (task completion rate
50%). If the scheduler detects a crash, it will log it and restart the worker node. If the worker node finishes successfully, it should print the result.


```elixir
def create_scheduler() do
      spawn(fn -> main_loop() end)
    end

    defp main_loop() do
      receive do
        {:fail, s} -> IO.puts("Task fail"); send(self(),s); main_loop()
        {:success,s} ->  IO.puts(s); main_loop()
        val -> send(spawn(fn -> worker(val) end), self()); main_loop()
      end
    end

    defp worker(s) do
      randN = :rand.uniform(4)
      caller =
      receive do
        cal -> cal
      end
      cond do
        randN == 1 -> send(caller, {:success,"Task succesful : Miau"})
        true -> send(caller, {:fail, s})
      end
    end
``` 

The main_loop function waits to receive messages using the receive block. If the received message is {:fail, s}, it prints "Task fail" to the console and sends the message back to the scheduler process. If the received message is {:success, s}, it prints the value of s to the console. If the received message is any other value, it spawns a new worker process by calling the worker function with the received value as its argument, and sends the worker process a message containing its own process ID (self()).

The worker function receives the message sent by the scheduler containing its own process ID. It then generates a random number between 0 and 3 using the :rand.uniform/1 function. If the random number is 1, it sends a {:success, "Task successful : Miau"} message to the caller process ID received earlier. Otherwise, it sends a {:fail, s} message to the caller process ID, where s is the argument received by the create_scheduler function.



## P0W4

**Task 1** --  Create a supervised pool of identical worker actors. The number of actors is static, given at initialization. Workers should be individually addressable. Worker actors
should echo any message they receive. If an actor dies (by receiving a “kill” message), it should be restarted by the supervisor. Logging is welcome.


```elixir
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

``` 

he SupervisorTask1.run/2 function takes in a main_pid and an integer n, which is the number of worker processes to be created. It then creates the worker processes by spawning new processes with the workerLogic/1 function and storing them in a map with their respective reference values. Once all the worker processes have been created, it sends a :ready message to the main_pid process to indicate that it's ready to supervise the worker processes.

The SupervisorTask1.supervise/1 function is responsible for monitoring the worker processes and restarting them if they fail. It receives messages from the monitored worker processes and checks if they've exited normally or abnormally. If a worker process has exited abnormally, it removes it from the map and spawns a new process with the same id as the failed worker. The new process is then monitored and added back to the map.

The SupervisorTask1.workerLogic/1 function represents the work that each worker process does. It sleeps for a random amount of time and then outputs a message indicating that it has died.

Finally, there is a SupervisorTask1.loopMe/0 function that continuously sleeps for a fixed amount of time and then calls itself recursively. This function is used to keep the main process alive while the supervisor and worker processes are running.

The code spawns a new process that runs the SupervisorTask1.run/2 function and sends a :ready message to the main process. The main process then enters a receive block that waits for the :ready message. Once the message is received, it calls the SupervisorTask1.loopMe/0 function to keep the main process alive while the supervisor and worker processes are running. If the :ready message is not received within 1000 milliseconds, an error is raised.



**Task 2** -- Create a supervised processing line to clean messy strings. The first worker in the line would split the string by any white spaces (similar to Python’s str.split method). The second actor will lowercase all words and swap all m’s and n’s (you nomster!). The third actor will join back the sentence with one space between words (similar to Python’s str.join method). Each worker will receive as input the previous actor’s output, the last actor printing the result on screen. If any of the workers die because it encounters an error, the whole processing line needs to be restarted. Logging is welcome.

```elixir
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
    pid1 = spawn_link( fn -> StringProcess.DowncaseSwapper.start() end)
    run(pid1)
  end
  defp run(pid1) do
    receive do
      {:split, s } ->
        arr = String.to_charlist(s)
        splitS(arr,[],pid1)
      :exit -> raise "Exited Abnormaly!!! (actually called normally)"
    end
    run(pid1)
  end

  defp splitS([],w,pid1) do

    if w != [] do
      send(pid1,{:downcase, List.to_string(w) })
    end
    :ok
  end
  defp splitS([h|t],w,pid1) do
    cond do
      h == 32 ->
        if w != [] do
          send(pid1,{:downcase, List.to_string(w) } )
        end
        splitS(t,[],pid1)

      true -> splitS(t,w ++ [h],pid1)
    end
  end
end


defmodule StringProcess.DowncaseSwapper do

  def start() do
    #Process.register(self(), :downcaseSwapper)
    pidString = spawn_link( fn -> StringProcess.StringAssembly.start() end)
    run(pidString)
  end

  defp run(pidString) do
    receive do
      {:downcase, s  } ->
        downCaseString = String.downcase(s)
        {indexMap,len} = mapBuilder(String.to_charlist(downCaseString),0,%{})
        range = indexTuples(len)
        allPossibleCombinations = Enum.filter(range, fn x -> {idx1,idx2} = x;  filterIndexesByChars(idx1,idx2,indexMap) end )
        indexSwapMap = filterAllPossibleCombitaions(allPossibleCombinations,%{},%{})
        finalString = swapLetters(Map.to_list(indexSwapMap),String.to_charlist(downCaseString))
        send(pidString,{:addString, finalString})
      :exit -> raise "Exited Abnormaly!!! (actually called normally)"
    end
    run(pidString)
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
    #Process.register(self(), :transformerAssembly)
    run("")
  end

  defp run(finalString) do
    receive do
      {:addString, s } ->
        finalString = finalString <> " " <> s
        IO.inspect(finalString)
        run(finalString)
      :exit -> raise "Exited Abnormaly!!! (actually called normally)"
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

send(:spaceSpliter, :exit)
:timer.sleep(2000)
send(:spaceSpliter, {:split, "   ok   LOl  HSJADKNJ "})

``` 


We do actually spawn the main supervisor which watches the next pid.  In the Space Spliter we link spawn the downcase and swapper pids and so in that we spawn the string assembly. 
The most complicated and msessy is the second pid. So, The run function receives a pidString parameter, which is the process identifier of the process that will receive the message with the final result.
The run function begins with a receive block that waits for messages to arrive. If the message received is a tuple of the form {:downcase, s}, the function calls the downcase function to convert the string to lowercase and then proceeds to build a map that associates each character of the string with an index. This map is built with the mapBuilder function. After that, the function generates all possible combinations of index pairs (using the indexTuples function) and filters those that satisfy a specific condition (using the filterIndexesByChars function). The resulting index pairs are used to build a map that represents a swapping strategy for characters, which is then used to produce the final string by swapping the characters using the swapLetters function. Finally, the function sends a message with the result to the given process identifier.
If the message received is :exit, the function raises an exception with an error message.
The swapLetters function receives a list of index pairs and a list of characters as input and returns a new list with the characters swapped according to the given index pairs.
The swap function receives a list, two indexes, and returns a new list with the elements at the given indexes swapped.
The filterAllPossibleCombitaions function receives a list of index pairs, a map, and a final map as input. It iterates through the list of index pairs, and for each pair, it checks if it satisfies a specific condition (i.e., if the indexes are not already in the map or their values are not already keys in the map). If the condition is met, the function updates the map with the new index pair and adds it to the final map. Finally, it returns the final map.
The filterIndexesByChars function receives two indexes and a map that associates each character with an index. It retrieves the characters at the given indexes from the map and checks if they are 'm' and 'n' in any order. If this is the case, the function returns true; otherwise, it returns false.
The indexTuples function receives an integer and generates all possible pairs of integers between 0 and the given integer (inclusive).
The mapBuilder function receives a list of characters and two integer counters and returns a map that associates each character with an index. The function iterates through the list of characters, adds each character to the map with the current counter as the index, and increments the counter for the next iteration. When the iteration is completed, the function returns the final map and the current counter.


**Task 3** -- Write a supervised application that would simulate a sensor system in a car. There should be sensors for each wheel, the motor, the cabin and the chassis. If any sensor dies because of a random invalid measurement, it should be restarted. If, however, the main sensor supervisor system detects multiple crashes, it should deploy the airbags. 

```elixir

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
            send(:counteCrash, :incr )
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
              send(:counteCrash, :incr )
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
      :exit ->  :ok
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

``` 

The CarSupervisor module defines a function run/2 that takes two arguments: a main process ID and a list of functions representing the car's sensors and wheels. The run/2 function creates a map of monitored processes, sends a :ready message to the main process, and then starts the supervision loop by calling the supervise/1 function.

The supervise/1 function is a recursive loop that waits for messages from monitored processes. If a process terminates normally, the loop continues. If a process terminates abnormally, the supervise/1 function restarts the process and updates the map of monitored processes. If the number of crashes for any process exceeds 3, an error message is raised.

The CarSupervisor module also defines three nested modules, CabinSensor, ChassisSensor, and MotorSensor, each of which defines a start/0 function that registers the module process with a unique name, and a run/0 function that waits for an :exit message and then restarts the process.

The WheelSupervisor module defines a run/0 function that creates a map of monitored processes for the car's wheels and starts the supervision loop by calling the supervise/1 function.

The WheelSupervisor module also defines a nested WheelSensor module that defines a run/0 function that waits for an :exit message and then restarts the process.

Finally, the CarSupervisor module defines a CounterCrash module that defines a start/0 function that registers the module process with a unique name and a run/1 function that waits for messages. If the message is :incr, the function checks the current crash count and either increments the count or raises an error if the count exceeds 3. If the message is :exit, the function terminates. The function also sets a timer to reset the crash count every 5 seconds.

At the end of the code, a main process is spawned that calls the CarSupervisor.run/2 function to start the supervision system. If the system does not start within 4 seconds, an error message is raised.


## P0W4


**Task 1** -- Write an application that would visit this link. Print out the HTTP response status code, response headers and response body.



```elixir
    def pr do
    # Make an HTTP GET request to a URL
    {:ok, res} = HTTPoison.get("https://quotes.toscrape.com/")
    IO.puts "--------------------------------------------------------------"
    IO.puts  "Status Code: "; IO.puts res.status_code
    IO.puts "--------------------------------------------------------------"
    IO.puts "Headers: "
    Enum.each(res.headers, fn x -> IO.puts printHeaders(x)  end )
    IO.puts "--------------------------------------------------------------"
    IO.puts  "Body:\n" <> res.body
    IO.puts "--------------------------------------------------------------"
    end

    defp printHeaders(t) do
      Enum.reduce(Tuple.to_list(t), "", fn x,y -> y <> ": " <> x end)
    end

    def getBody do
      {:ok, res} = HTTPoison.get("https://quotes.toscrape.com/")
      res.body
    end
``` 

The pr function sends an HTTP GET request to the URL "https://quotes.toscrape.com/" using the HTTPoison library and retrieves a response.
It prints the status code, headers, and body of the response to the console.
The printHeaders function takes a tuple of header values and converts it to a string that concatenates each header name and value pair with a colon.


**Task 2** -- Continue your previous application. Extract all quotes from the HTTP response body. Collect the author of the quote, the quote text and tags. Save the data into a list of maps, each map representing a single quote.



```elixir
  def run do
  Task1.getBody()
  |> Floki.parse_document!
  |> Floki.find( ".quote")
  |> Enum.map( &parse_quote/1)

end
defp parse_quote(q) do
  author = Floki.find(q, ".author")
  |> Floki.text()

  text = Floki.find(q, ".text")
  |> Floki.text()

  tags = Floki.find(q, ".tags .tag")
  |> Enum.reduce("", fn x,y -> y <> " " <> Floki.text(x) end)
  %{author: author, quoteText: text, tags: tags}
end
``` 

The run function first calls Task1.getBody() to retrieve the body of the web page. It then uses the Floki library to parse the HTML document and find all elements with a class of "quote". For each quote element, it calls the parse_quote function to extract the author name, quote text, and tags. parse_quote takes a quote element and uses Floki to find the author name, quote text, and tags elements. It then extracts the text of each element and returns a map with the extracted values.



**Task 3** --  Continue your previous application. Persist the list of quotes into a file. Encode the data into JSON format. Name the file quotes.json


```elixir
def run do
    prettyJson =
    Task2.run
    |> Jason.encode_to_iodata!()
    |> Jason.Formatter.pretty_print()

    File.write!("quotes.json", prettyJson)
  end
  ``` 

The run function of Task3 calls Task2.run to retrieve a list of quote maps.
It then converts the list to a pretty-printed JSON string using the Jason library and writes the string to a file named "quotes.json" using the File module. 




**Task 4** -- Write an application that would implement a Star Wars-themed RESTful API.
The API should implement the following HTTP methods:
• GET /movies
• GET /movies/:id
• POST /movies
• PUT /movies/:id
• PATCH /movies/:id
• DELETE /movies/:id
Use a database to persist your data. Populate the database with the following information:


THE ROUTER: 


```elixir
defmodule Week5RestApi.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
  parsers: [:json],
  pass: ["application/json"],
  json_decoder:  Jason
  )

  plug(:dispatch)


  get "/", do: send_resp(conn,200,"OK")

  get "/movies" do
    {:ok,pid} = Week5RestApi.Database.start_link
    kek = Tds.query!(pid, "SELECT * FROM movies",[])
     pretty =
     Week5RestApi.Helpers.getResToMap(kek.rows)
     |> Jason.encode_to_iodata!()
     |> Jason.Formatter.pretty_print()
    send_resp(conn, 200, pretty )
  end

  get "/movies/:id" do
    {:ok,pid} = Week5RestApi.Database.start_link
    kek = Tds.query!(pid, "SELECT * FROM movies WHERE id = #{id}",[])
    if kek.num_rows == 0 do
      send_resp(conn, 404, "Movie id not found!" )
    else
     pretty =
     Week5RestApi.Helpers.toMap(List.first(kek.rows))
     |> Jason.encode_to_iodata!()
     |> Jason.Formatter.pretty_print()
    send_resp(conn, 200, pretty )
     end
  end

  post "/movies" do
    body =  conn.body_params
    {b,msg} =  Week5RestApi.Helpers.checkPostBody(body)
    if b == true do
      {:ok,pid} = Week5RestApi.Database.start_link
      kek = Tds.query!(pid, "SELECT * FROM movies WHERE id = #{body["id"]}",[])
      if kek.num_rows == 0 do
        Week5RestApi.Database.updatePost(body,pid)
        send_resp(conn, 200, "Succesful!" )
      else
        send_resp(conn, 400, "Id already exist!")
      end
   else
    send_resp(conn, 400, msg )
  end
  end

  put "/movies/:id" do
    body =  conn.body_params
    body = Map.put(body,"id","#{id}")
    {b,msg} =  Week5RestApi.Helpers.checkPostBody(body)
    if b == true do
      {:ok,pid} = Week5RestApi.Database.start_link
      kek = Tds.query!(pid, "SELECT * FROM movies WHERE id = #{body["id"]}",[])
      if kek.num_rows == 0 do
        send_resp(conn, 400, "No id FOund!!!" )
      else
        Week5RestApi.Database.updatePut(body,pid)
        send_resp(conn, 200, "Succesful!" )
      end
    else
      send_resp(conn, 400, msg )
    end
  end

  patch "/movies/:id" do
    body =  conn.body_params
    {:ok,pid} = Week5RestApi.Database.start_link
    kek = Tds.query!(pid, "SELECT * FROM movies WHERE id = #{id}",[])
    if kek.num_rows == 0 do
      send_resp(conn, 400, "No id FOund!!!" )
    else
      Week5RestApi.Database.updatePatch(body,id,pid)
       send_resp(conn,200, "Succesful!")
    end
  end


  delete "/movies/:id" do
    {:ok,pid} = Week5RestApi.Database.start_link
    Tds.query!(pid, "DELETE  FROM movies WHERE id = #{id}",[])
    send_resp(conn,200, "Succesful!")
  end

  match _, do: send_resp(conn,404,"Not_Found")

end
``` 

Basically logical validations passing to the database queries using TDS library.  It uses some additional validation functions and transfomrations ( I have 3 so I would not include them here). Also it has some calls to the database: 


```elixir 

defmodule Week5RestApi.Database do
  require Tds

  def start_link do
    Tds.start_link(Application.get_env(:week5_rest_api, :tds_conn))
  end


  def updatePost(body,pid) do
    Tds.query!(pid, "INSERT INTO movies (id, title, release_year, director ) VALUES (@id, @title, @year, @director)",
        [
        %Tds.Parameter{name: "@id", value: body["id"]}, %Tds.Parameter{name: "@title", value: body["title"]},
        %Tds.Parameter{name: "@year", value: body["release_year"]}, %Tds.Parameter{name: "@director", value: body["director"]}
        ])
  end

  def updatePut(body,pid) do
    Tds.query!(pid, "UPDATE movies SET title = @title, release_year = @year, director = @director  WHERE id = @id",
    [
    %Tds.Parameter{name: "@id", value: body["id"]}, %Tds.Parameter{name: "@title", value: body["title"]},
    %Tds.Parameter{name: "@year", value: body["release_year"]}, %Tds.Parameter{name: "@director", value: body["director"]}
    ])
  end

  def updatePatch(body,id,pid) do
    Enum.each(body, fn x -> {k,v} = x; updateEachPatch(k,v,id,pid)  end )

  end

  defp updateEachPatch(k,v,id,pid) do
    Tds.query!(pid, "UPDATE movies SET #{k} = @val  WHERE id = @id",
        [
          %Tds.Parameter{name: "@id", value: id},
          %Tds.Parameter{name: "@val", value: v}
        ])
  end


end
```  
Above are just REST functions applied to the database.



**Task 5** --   Write an application that would use the Spotify API to manage user playlists. It should be able to create a new playlist, add songs to it and add custom playlist cover images. You will probably get to play with OAuth 2.0 and Base64 encoding.


The router would look like this: 

```elixir
 get "/"  do
    l = Week5SpotifyApi.Helpers.auth()
    send_resp(conn,200,l)
  end

  post "/createPlaylist" do
    body =  conn.body_params
    send(:kek,  {:createPlaylist, body["name"], body["description"]} )
    send_resp(conn, 200, "OK LOL")
  end

  post "/addSong" do
    body =  conn.body_params
    send(:kek,  {:addSong, body["songId"]} )
    send_resp(conn, 200, "song added")
  end

  post "/addImage" do
    body =  conn.body_params
    {_, img} = File.read("media/#{ body["img_path"]}")
    imgp = Base.encode64(img)
    send(:kek,  {:addImg, imgp} )
    send_resp(conn, 200, "img added")
  end



  get "/callback" do
    conn = Plug.Conn.fetch_query_params(conn) # populates conn.params
    code =  conn.params["code"]
    res = Week5SpotifyApi.Helpers.requestAccessToken(code)
    kek = Jason.decode!(res.body)
    Week5SpotifyApi.Helpers.spawnTheBoss(kek["access_token"])
    send_resp(conn, 200, res.body )
  end
```  

AND the main logic is here: 

```elixir 

defmodule   Week5SpotifyApi.Helpers do
  #use Plug.Conn.Query

  def auth do
    {_, cfg} = File.read("config/cfg.json")
    kek = Jason.decode!(cfg)

    client_id = kek["client_id"]
     client_secret = kek["client_secret"]
     redirect_uri = kek["redirect_uri"]
     scope = kek["scope"]

    link =
     "https://accounts.spotify.com/authorize?" <>
     Plug.Conn.Query.encode([
      response_type: "code",
      client_id: client_id,
      client_secret: client_secret,
      scope: scope,
      redirect_uri: redirect_uri
      ])

      link

  end

  def requestAccessToken(code) do
      {_, cfg} = File.read("config/cfg.json")
      kek = Jason.decode!(cfg)

      client_id = kek["client_id"]
       client_secret = kek["client_secret"]
       redirect_uri = kek["redirect_uri"]



    ok = client_id <> ":" <> client_secret
    url = "https://accounts.spotify.com/api/token"
    body = "grant_type=authorization_code&code=#{code}&redirect_uri=#{redirect_uri}"
      {:ok, res } =  HTTPoison.post(
        url,
        body,
        [
          {"Authorization","Basic #{Base.encode64(ok)}"},
          {"Content-Type", "application/x-www-form-urlencoded"}
        ]
      )

      res
  end

  def spawnTheBoss(accessToken) do
      {:ok, res } =  HTTPoison.get(
        "https://api.spotify.com/v1/me",
        [
          {"Authorization","Bearer #{accessToken}"},
        ]
      )
      kek = Jason.decode!(res.body)
      userId =  kek["id"]
      spawn( fn -> Process.exit(:kek, :kill) end)
      :timer.sleep(1000)
      pid = spawn(  fn ->  loop(accessToken, userId,"") end)
      Process.register(pid, :kek)
  end

  defp loop(token, userid, playlistId ) do
    receive do
      {:createPlaylist, name, description} ->
                url = "https://api.spotify.com/v1/users/#{userid}/playlists"
                body = %{ name: name, public: true, collaborative: false, description: description}
                body = Jason.encode!(body)
                  {:ok, res} =  HTTPoison.post(
                    url,
                    body,
                    [
                      {"Authorization","Bearer #{token}"},
                      {"Content-Type", "application/json"}
                    ]
                  )
                kek = Jason.decode!(res.body)
                 loop(token,userid, kek["id"])


      {:addSong, song } ->
              url =  "https://api.spotify.com/v1/playlists/#{playlistId}/tracks"
              body = %{ uris: [song], position: 0}
              body = Jason.encode!(body)
              {:ok, _} =  HTTPoison.post(
                url,
                body,
                [
                  {"Authorization","Bearer #{token}"},
                  {"Content-Type", "application/json"}
                ]
              )
              loop(token,userid, playlistId)


      {:addImg, img } ->
        url =  "https://api.spotify.com/v1/playlists/#{playlistId}/images"

        {:ok, _} =  HTTPoison.put(
          url,
          img,
          [ {"Authorization","Bearer #{token}"}]
        )
        loop(token,userid, playlistId)
    end
    loop(token,userid,playlistId)

  end
end 
``` 

So there are several steps to make authorization to the api. I stuck to these 2: 

1. The first call is the service ‘/authorize’ endpoint, passing to it the client ID, scopes, and redirect URI. This is the call that starts the process of authenticating to user and gets the user’s authorization to access data.

2. The second call is to the Spotify Accounts Service ‘/api/token’ endpoint, passing to it the authorization code returned by the first call and the client secret key. This call returns an access token and also a refresh token. 


Once the Week5SpotifyApi.Helpers.auth()  and we get credentionals from  Week5SpotifyApi.Helpers.requestAccessToken(code) is done completing the steps aboce, I start a PID which is receptioning message whenver a request is made.  That pid just uses the the API endpoints to create the playlist, add songs and to add an image.


## Conclusion 
1. Introducing myself to the  paradigm of funational programming, surprised me how recursion can easily solve some task.
2. Elixir is a powerful and versatile language that offers many benefits for developing concurent actor models. With its built-in support for concurrency, fault tolerance, and distributed systems, it is well-suited for development.

3. Supervisors in Elixir provide an effective way to manage and monitor the lifecycle of processes, ensuring that applications remain stable and responsive even in the face of unexpected errors or crashes. Supervisors can automatically restart failed processes, ensuring that an API remains available to clients. 


## Bibliography

https://www.youtube.com/watch?v=GQVXyjYX1zA&list=PLJbE2Yu2zumA-p21bEQB6nsYABAO-HtF2&index=1&ab_channel=TensorProgramming 
 
 https://www.openmymind.net/Elixir-A-Little-Beyond-The-Basics-Part-6-processes/ 

 https://www.openmymind.net/Elixir-A-Little-Beyond-The-Basics-Part-7-supervisors/ 

