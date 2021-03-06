defmodule Geef.Blob do
  use Geef

  def lookup(repo, id) do
    Object.lookup(repo, id, :blob)
  end


  def size(%Object{type: :blob, handle: handle}) do
    :geef_nif.blob_size(handle)
  end

  def content(%Object{type: :blob, handle: handle}) do
    :geef_nif.blob_content(handle)
  end

end
