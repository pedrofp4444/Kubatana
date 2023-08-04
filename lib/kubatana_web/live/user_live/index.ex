defmodule KubatanaWeb.UserLive.Index do
  use KubatanaWeb, :live_view

  alias Kubatana.Admin
  alias Kubatana.Admin.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :members, Admin.list_members())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Admin.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Members")
    |> assign(:user, nil)
  end

  @impl true
  def handle_info({KubatanaWeb.UserLive.FormComponent, {:saved, user}}, socket) do
    {:noreply, stream_insert(socket, :members, user)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Admin.get_user!(id)
    {:ok, _} = Admin.delete_user(user)

    {:noreply, stream_delete(socket, :members, user)}
  end
end
