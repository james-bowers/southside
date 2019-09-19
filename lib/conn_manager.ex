defmodule Southside.ConnManager do
  alias Southside.Conn
  @doc """
  Start the listener process for a connection.
  """
  def init(protocol, host, port) do
    spawn fn -> 
      {:ok, mint_conn} = Mint.HTTP.connect(:http, host, 80)
      listener(%Conn{
        mint_conn: mint_conn
      })
    end
  end

  @doc """
  Listen to messages received over that connection.
  """
  def listener(southside_conn = %Conn{mint_conn: mint_conn}) do
    receive do
      :send ->
        {:ok, mint_conn, request_ref} = Mint.HTTP.request(mint_conn, "GET", "/", [], "")

        Conn.update_mint_conn(southside_conn, mint_conn)
        |> listener()

      message ->
        case Mint.HTTP.stream(mint_conn, message) do
         {:ok, mint_conn, responses} -> 
          IO.inspect(responses, label: "responses")

          Conn.update_mint_conn(southside_conn, mint_conn)
           |> listener()

         other -> 
          listener(southside_conn)
        end
    end
  end
end
