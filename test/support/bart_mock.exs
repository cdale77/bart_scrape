defmodule HTTPoison.Response do
  defstruct body: nil, headers: nil, status_code: nil
end

defmodule BartScrape.BartMock do
  def fetch_data do
    { :ok, successful_response }
  end

  defp successful_response do
    %HTTPoison.Response{
      body: "{\"access_token\":\"a_valid_access_token\",\"token_type\":\"Bearer\",
        \"expires_in\":3600,\"a_valid_refresh_token\":\"refresh_token\"}",
      headers: [],
      status_code: 200
    }
  end
end
