defmodule HealthcheckCloud.Router do
  # Bring Plug.Router module into scope
  use Plug.Router

  # Attach the Logger to log incoming requests 
  plug(Plug.Logger)

  # Tell Plug to match the incoming request with the defined endpoints
  plug(:match)

  # Once there is a match, parse the response body if the content-type
  # is application/json. The order is important here, as we only want to
  # parse the body if there is a matching route.(Using the Jayson parser)
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  # Dispatch the connection to the matched handler
  plug(:dispatch)

  # Handler for GET request with "/" path
  get "/api/v1" do
    send_resp(conn, 200, "OK")
  end

  get "/api/v1/azure/:id" do
    posts = HealthcheckCloud.url(id) |> Jason.encode!()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, posts)
  end

  # Fallback handler when there was no match
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
