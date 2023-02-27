defmodule Week5SpotifyApi.Router do

use Plug.Router

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
  parsers: [:json],
  pass: ["application/json"],
  json_decoder:  Jason
  )

  plug(:dispatch)


 # Authentication and Code Require
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



  match _, do: send_resp(conn,404,"Not_Found")


end
