defmodule PorkbrainWeb.LecturesController do
  use PorkbrainWeb, :controller

  def reinforcement_learning(conn, _) do
    render(conn, "rf.html")
  end
end
