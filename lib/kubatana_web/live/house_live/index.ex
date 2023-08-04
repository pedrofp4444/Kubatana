defmodule KubatanaWeb.HouseLive.Index do
  use KubatanaWeb, :live_view

  alias Kubatana.Resources
  alias Kubatana.Resources.House

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :houses, Resources.list_houses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit House")
    |> assign(:house, Resources.get_house!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New House")
    |> assign(:house, %House{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Houses")
    |> assign(:house, nil)
  end

  @impl true
  def handle_info({KubatanaWeb.HouseLive.FormComponent, {:saved, house}}, socket) do
    {:noreply, stream_insert(socket, :houses, house)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    house = Resources.get_house!(id)
    {:ok, _} = Resources.delete_house(house)

    {:noreply, stream_delete(socket, :houses, house)}
  end
end
