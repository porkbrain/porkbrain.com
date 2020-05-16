defmodule PorkbrainWeb.LecturesController do
  use PorkbrainWeb, :controller

  def reinforcement_learning(conn, _) do
    render(conn, "rf.html")
  end

  def information_theory(conn, _) do
    render(conn, "info_theory.html")
  end
end
