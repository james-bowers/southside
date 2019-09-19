defmodule Connection do
  def init do
    spawn fn -> 
      {:ok, conn} = Mint.HTTP.connect(:http, "httpbin.org", 80)
      loop_conn(conn)
    end
  end

  def req(pid) do
    send pid, :send
  end

  def loop_conn(conn) do
    receive do
      :send ->
        {:ok, conn, request_ref} = Mint.HTTP.request(conn, "GET", "/", [], "")
        loop_conn(conn)


      message ->
        case Mint.HTTP.stream(conn, message) do
         {:ok, conn_stream, responses} -> 
           loop_conn(conn_stream)

         other -> 
          loop_conn(conn)
        end
    end
  end
end