defmodule Southside.Conn do
  defstruct [:mint_conn, :responses]

  @doc """
  Helper to keep mint connection up-to-date
  """
  def update_mint_conn(southside_conn, new_mint_conn) do
    Map.put(southside_conn, :mint_conn, new_mint_conn)
  end

  @doc """
  Adds status code to the referenced response
  """
  def handle_frame(southside_conn, {:status, response_reference, status_code}) when is_integer(status_code) do
    # todo: add the status code to the responses key of the southside connection
  end

  @doc """
  Adds headers to the referenced response
  """
  def handle_frame(southside_conn, {:headers, response_reference, headers}) when is_list(headers) do
    # todo: add the headers to the responses key
  end

  @doc """
  Adds response body to the referenced response
  """
  def handle_frame(southside_conn, {:data, response_reference, status_code}) do
    # todo: add data to the response using
  end
end
