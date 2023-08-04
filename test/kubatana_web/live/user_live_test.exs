defmodule KubatanaWeb.UserLiveTest do
  use KubatanaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Kubatana.AdminFixtures

  @create_attrs %{age: 42, house: "some house", name: "some name"}
  @update_attrs %{age: 43, house: "some updated house", name: "some updated name"}
  @invalid_attrs %{age: nil, house: nil, name: nil}

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_user]

    test "lists all members", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, ~p"/members")

      assert html =~ "Listing Members"
      assert html =~ user.house
    end

    test "saves new user", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/members")

      assert index_live |> element("a", "New User") |> render_click() =~
               "New User"

      assert_patch(index_live, ~p"/members/new")

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user-form", user: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/members")

      html = render(index_live)
      assert html =~ "User created successfully"
      assert html =~ "some house"
    end

    test "updates user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/members")

      assert index_live |> element("#members-#{user.id} a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(index_live, ~p"/members/#{user}/edit")

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user-form", user: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/members")

      html = render(index_live)
      assert html =~ "User updated successfully"
      assert html =~ "some updated house"
    end

    test "deletes user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, ~p"/members")

      assert index_live |> element("#members-#{user.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#members-#{user.id}")
    end
  end

  describe "Show" do
    setup [:create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, ~p"/members/#{user}")

      assert html =~ "Show User"
      assert html =~ user.house
    end

    test "updates user within modal", %{conn: conn, user: user} do
      {:ok, show_live, _html} = live(conn, ~p"/members/#{user}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(show_live, ~p"/members/#{user}/show/edit")

      assert show_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user-form", user: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/members/#{user}")

      html = render(show_live)
      assert html =~ "User updated successfully"
      assert html =~ "some updated house"
    end
  end
end
