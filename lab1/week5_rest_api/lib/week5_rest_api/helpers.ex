defmodule Week5RestApi.Helpers do

  def getResToMap(res) do
    Enum.map(res, fn x -> toMap(x) end)
  end

  def toMap(a) do
    {id, title, year, director } = List.to_tuple(a)
    %{  id: id,  titile: title, year: year, director:  director }
  end


  def checkPostBody(m) do
    cond do
      m["id"] == nil -> {false, "No id specified"}
      m["title"] == nil -> {false,  "No title specified"}
      m["director"] == nil -> {false, "No director specified"}
      m["release_year"] == nil -> { false, "No release_year specified"}
      true -> {true, ""}
     end
  end


end
