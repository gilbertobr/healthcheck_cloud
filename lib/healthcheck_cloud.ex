defmodule HealthcheckCloud do
  use Tesla, only: [:get], docs: false

  adapter(Tesla.Adapter.Hackney, recv_timeout: 30_000, ssl_options: [verify: :verify_none])

  plug(Tesla.Middleware.BaseUrl, "https://status.azure.com/en-us")

  def url(country) do
    dir = System.tmp_dir!()
    tmp_file = Path.join(dir, "azureurl.html")

    rows =
      get_file_azure(tmp_file)
      |> Floki.parse_document!()

    run(rows, country)
      |> Enum.filter(&(!is_nil(&1)))
  end

  defp fetch_data do
    case get("/status") do
      {:ok, tesla} -> tesla.body
      {:error, failed} -> raise failed.status
    end
  end

  def download_page_azure() do
    dir = System.tmp_dir!()
    tmp_file = Path.join(dir, "azureurl.html")
    File.write(tmp_file, fetch_data())
  end

  defp get_file_azure(tmp_file),
    do: File.read!(tmp_file)

  defp table_local(full) do
    status = full |> Floki.find("table.status-table thead tr th span")

    local =
      Enum.map(status, fn {_a, _b, c} ->
        local = Enum.at(c, 0)

        if is_tuple(local) do
          %{local: Enum.at(c, 1)}
        else
          if local != "‡" do
            %{local: local}
          end
        end
      end)

    Enum.filter(local, &(!is_nil(&1)))
  end

  def run(full, country) do
    filter =
      full
      |> Floki.find("table.status-table")
      |> Enum.filter(fn {_a, b, _c} -> Enum.member?(b, {"data-zone-name", country}) end)
      |> Enum.filter(fn {_a, b, _c} ->
        Enum.member?(b, {"class", "status-table region-status-table default"})
      end)
      |> Floki.find("tbody")

    filter_status(full, filter)
  end

  defp filter_status(full, filter) do
    gg =
      table_local(full)
      |> Enum.filter(fn x -> x.local != "Products and services" end)
      |> Enum.with_index()
      |> Enum.filter(fn {_a, b} -> b >= 0 and b <= 13 end)
      |> Enum.map(fn {a, _b} -> a end)

    a = filter |> Floki.find("tr")

    Enum.map(a, fn {_q, _w, e} ->
      convert_string = e |> Floki.text()

      if String.contains?(convert_string, [
           "Compute",
           "Developer tools",
           "Networking",
           "Storage",
           "Web",
           "Mobile",
           "Containers",
           "Databases",
           "Analytics",
           "AI + machine learning",
           "Internet of Things",
           "Integration",
           "Identity",
           "Security",
           "DevOps",
           "Azure Artifacts",
           "Azure Boards",
           "Azure Pipelines",
           "Azure Repos",
           "Azure Test Plans",
           "Management and governance",
           "Media",
           "Migration",
           "Mixed reality",
           "Hybrid + multicloud"
         ]) == false do
        name = e |> Floki.find("td") |> Enum.at(0) |> parse()
        status1 = e |> Floki.find("td") |> Enum.at(1) |> parse() |> isnil()
        status2 = e |> Floki.find("td") |> Enum.at(2) |> parse() |> isnil()
        status3 = e |> Floki.find("td") |> Enum.at(3) |> parse() |> isnil()
        status4 = e |> Floki.find("td") |> Enum.at(4) |> parse() |> isnil()
        status5 = e |> Floki.find("td") |> Enum.at(5) |> parse() |> isnil()
        status6 = e |> Floki.find("td") |> Enum.at(6) |> parse() |> isnil()
        status7 = e |> Floki.find("td") |> Enum.at(7) |> parse() |> isnil()
        status8 = e |> Floki.find("td") |> Enum.at(8) |> parse() |> isnil()
        status9 = e |> Floki.find("td") |> Enum.at(9) |> parse() |> isnil()
        status10 = e |> Floki.find("td") |> Enum.at(10) |> parse() |> isnil()
        status11 = e |> Floki.find("td") |> Enum.at(11) |> parse() |> isnil()
        status12 = e |> Floki.find("td") |> Enum.at(12) |> parse() |> isnil()
        status13 = e |> Floki.find("td") |> Enum.at(13) |> parse() |> isnil()
        status14 = e |> Floki.find("td") |> Enum.at(14) |> parse() |> isnil()

        local1 = gg |> Enum.at(0) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local2 = gg |> Enum.at(1) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local3 = gg |> Enum.at(2) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local4 = gg |> Enum.at(3) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local5 = gg |> Enum.at(4) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local6 = gg |> Enum.at(5) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local7 = gg |> Enum.at(6) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local8 = gg |> Enum.at(7) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local9 = gg |> Enum.at(8) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local10 = gg |> Enum.at(9) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local11 = gg |> Enum.at(10) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local12 = gg |> Enum.at(11) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local13 = gg |> Enum.at(12) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()
        local14 = gg |> Enum.at(13) |> Enum.map(fn {_a, b} -> b end) |> List.to_string()

        %{
          name:
            String.slice(String.replace(name, ~r/ +/, " "), 1..-1) |> String.replace("\r\n", ""),
          "#{local1}": status1,
          "#{local2}": status2,
          "#{local3}": status3,
          "#{local4}": status4,
          "#{local5}": status5,
          "#{local6}": status6,
          "#{local7}": status7,
          "#{local8}": status8,
          "#{local9}": status9,
          "#{local10}": status10,
          "#{local11}": status11,
          "#{local12}": status12,
          "#{local13}": status13,
          "#{local14}": status14
        }
      end
    end)
  end

  def zip_struct(a, b, c) do
    page1 =
      a
      |> Enum.zip(b)
      |> Enum.map(fn {ela, elb} ->
        Map.merge(ela, elb)
      end)

    page1
    |> Enum.zip(c)
    |> Enum.map(fn {ela, elb} ->
      Map.merge(ela, elb)
    end)
  end

  def parse(rows) do
    case rows do
      {_, _, [_, _, name, _, _, _]} ->
        name

      {_, _, [name]} ->
        if is_binary(name) do
          name
        else
          {_, _, [subname]} = name
          subname
        end

      {_, _, [{_, [_, {"data-label", status0}], [{_, [_, _], [{_, _, []}]}]}, {_, [_], _}]} ->
        status0
    end
  end

  defp isnil(params) do
    case params do
      "Blank" -> nil
      _ -> params
    end
  end
end
