defmodule PsyRussia.Contact.OnlineServiceTest do
  use PsyRussia.ModelCase

  alias PsyRussia.Contact.OnlineService

  @valid_attrs %{type: "some content", value: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OnlineService.changeset(%OnlineService{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OnlineService.changeset(%OnlineService{}, @invalid_attrs)
    refute changeset.valid?
  end
end
