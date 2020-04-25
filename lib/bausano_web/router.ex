defmodule BausanoWeb.Router do
  use BausanoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BausanoWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/api", BausanoWeb do
    pipe_through :api

    post "/posts", PostController, :create
  end
end
