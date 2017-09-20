defmodule BartScrape.Router do
  use BartScrape.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BartScrape do
    pipe_through :api
  end
end
