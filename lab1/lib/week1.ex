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



end

IO.puts(Week1.isPrime(7))
IO.puts(Week1.cylinderArea(3,4))
IO.inspect(Week1.reverseList([1,2,3]))
