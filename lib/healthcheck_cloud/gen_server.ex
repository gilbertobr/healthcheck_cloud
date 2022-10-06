defmodule HealthcheckCloud.GenServer do
    use GenServer
  
    def start_link(_state \\ 0) do
      IO.inspect("Starting...", label: "HealthcheckCloud.GenServer")
      success = GenServer.start_link(__MODULE__, 0)
      IO.inspect("Initiated!", label: "HealthcheckCloud.GenServer")
      success 
    end
  
    @impl true
    def init(state) do
      work(state)
      # Schedule work to be performed on start
      schedule_work()
      {:ok, state}
    end
  
    @impl true
    def handle_info(:work, state) do
      work(state)
      # Reschedule once more
      schedule_work()
      {:noreply, state + 1}
    end
  
    defp schedule_work() do
      Process.send_after(self(), :work, 1000)
    end
  
    def work(state) do
      case state do
        _ -> HealthcheckCloud.download_page_azure() 
      end
    end
  end