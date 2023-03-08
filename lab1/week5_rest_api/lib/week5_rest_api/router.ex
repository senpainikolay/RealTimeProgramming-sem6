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
