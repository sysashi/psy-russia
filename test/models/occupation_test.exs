defmodule PsyRussia.OccupationTest do
  use PsyRussia.ModelCase

  alias PsyRussia.Occupation

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Occupation.changeset(%Occupation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Occupation.changeset(%Occupation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
