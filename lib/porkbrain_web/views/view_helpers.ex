defmodule PorkbrainWeb.ViewHelpers do
  @moduledoc """
  Convenience functions to be used in templates.
  """


  @doc """
  If possible, parses given text with MD engine. If the input is not valid MD,
  returns the raw string.
  """
  def md_to_html(text) do
    case Earmark.as_html(text) do
      {:ok, parsed_md, _} -> parsed_md
      _ -> text
    end
  end
end
