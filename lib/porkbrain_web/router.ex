defmodule PorkbrainWeb.Router do
  use PorkbrainWeb, :router

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

  scope "/", PorkbrainWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/tribute", HomeController, :tribute
  end

  scope "/api", PorkbrainWeb do
    pipe_through :api

    post "/posts", PostController, :create
    post "/posts/unstructured", PostController, :create_unstructured
  end
end
