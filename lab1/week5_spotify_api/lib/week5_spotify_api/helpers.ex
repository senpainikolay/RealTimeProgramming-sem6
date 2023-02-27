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
