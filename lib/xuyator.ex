defmodule Xuyator do
  @stopwords ["через", "что", "вокруг", "перед", "возле", "ввиду"]
  @replaces %{"о" => "е", "а" => "я", "у" => "ю", "ы" => "и"}

  def vxuyarim(sentence) do
    String.split(sentence)
    |> Enum.reduce(fn(x, acc) -> acc <> " " <> xuyator(x) end)
  end

  def xuyator(word) do
    if (String.length(word) <= 3) or (Enum.member?(@stopwords, String.downcase(word))) do
      word
    else
      word <> postfix(String.slice(word, -5..-1))
    end
  end

  defp postfix(xuy) do
    list = xuy
      |> String.downcase
      |> strip
      |> String.graphemes
    if list == [] do
      ""
    else
      "-ху" <> ([Map.get(@replaces, hd(list), hd(list))] ++ tl(list) |> List.to_string)
    end
  end

  defp strip(word) do
    Regex.replace(~r/^[бвгджзйклмнпрстфхцчшщьъ]+/u, word, "")
  end
end
