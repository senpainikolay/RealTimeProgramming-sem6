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
