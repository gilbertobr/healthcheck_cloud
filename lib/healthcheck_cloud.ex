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

  # defp table_local(full) do
  #   status = full |> Floki.find("table.status-table thead tr th span")

  #   local =
  #     Enum.map(status, fn {_a, _b, c} ->
  #       local = Enum.at(c, 0)

  #       if is_tuple(local) do
  #         %{local: Enum.at(c, 1)}
  #       else
  #         if local != "‡" do
  #           %{local: local}
  #         end
  #       end
  #     end)

  #   Enum.filter(local, &(!is_nil(&1)))
  # end

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

  defp filter_status(_full, filter) do
    # gg =
    #   table_local(full)
    #   |> Enum.filter(fn x -> x.local != "Products and services" end)
    #   |> Enum.with_index()
    #   |> Enum.filter(fn {_a, b} -> b >= 0 and b <= 13 end)
    #   |> Enum.map(fn {a, _b} -> a end)

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
        status1 = e |> Floki.find("td") |> Enum.at(1) |> parse()
        status2 = e |> Floki.find("td") |> Enum.at(2) |> parse()
        status3 = e |> Floki.find("td") |> Enum.at(3) |> parse()
        status4 = e |> Floki.find("td") |> Enum.at(4) |> parse()
        status5 = e |> Floki.find("td") |> Enum.at(5) |> parse()
        status6 = e |> Floki.find("td") |> Enum.at(6) |> parse()
        status7 = e |> Floki.find("td") |> Enum.at(7) |> parse()
        status8 = e |> Floki.find("td") |> Enum.at(8) |> parse()
        status9 = e |> Floki.find("td") |> Enum.at(9) |> parse()
        status10 = e |> Floki.find("td") |> Enum.at(10) |> parse()
        status11 = e |> Floki.find("td") |> Enum.at(11) |> parse()
        status12 = e |> Floki.find("td") |> Enum.at(12) |> parse()
        status13 = e |> Floki.find("td") |> Enum.at(13) |> parse()
        status14 = e |> Floki.find("td") |> Enum.at(14) |> parse()

        %{
          name:
            String.slice(String.replace(name, ~r/ +/, " "), 1..-1) |> String.replace("\r\n", ""),
          status1: status1,
          status2: status2,
          status3: status3,
          status4: status4,
          status5: status5,
          status6: status6,
          status7: status7,
          status8: status8,
          status9: status9,
          status10: status10,
          status11: status11,
          status12: status12,
          status13: status13,
          status14: status14
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
end
