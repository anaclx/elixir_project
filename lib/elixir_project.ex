defmodule ElixirProject do
   @url "https://api.deezer.com/user/5934696283"

  def get_profile do
    HTTPoison.get(@url)
    |> processa_resposta
    |> mostra_resultado
  end

  def processa_resposta ({ :ok, %HTTPoison.Response{ status_code: 200, body: b }}) do
    { :ok, b }
  end

  def processa_resposta({ :error, r }), do: { :error, r}
  def processa_resposta({ :ok, %HTTPoison.Response{ status_code: _, body: b }}) do
    { :error, b }
  end

  def  mostra_resultado({ :error, _ }) do
    IO.puts "Ocorreu um erro."
  end

  def mostra_resultado({ :ok, json }) do
    { :ok, profile } = Poison.decode(json)
    mostra_profile(profile)
  end

  def mostra_profile([]), do: nil
  def mostra_profile([ i | resto ]) do
    country = i["country"]
    name = i["name"]
    picture = i["picture"]
    IO.puts "#{country} | #{name} | #{picture}"
    mostra_profile(resto)
  end
end
