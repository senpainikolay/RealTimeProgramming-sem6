

defmodule Task1 do

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

end


defmodule Task2 do
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
end


defmodule Task3 do

  def run do
    prettyJson =
    Task2.run
    |> Jason.encode_to_iodata!()
    |> Jason.Formatter.pretty_print()

    File.write!("quotes.json", prettyJson)
  end

end
