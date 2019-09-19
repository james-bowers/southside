defmodule Southside do
  def create_connection(protocol, host, port) do
    pid = Southside.ConnManager.init(protocol, host, port)
  end

  def request(pid) do
    send pid, :send
  end
end
