defmodule PsyRussia.ProfileTest do
  use PsyRussia.ModelCase

  alias PsyRussia.Profile

  @valid_attrs %{birthdate: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, fullname: "some content", location: "some content", occupation: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Profile.changeset(%Profile{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Profile.changeset(%Profile{}, @invalid_attrs)
    refute changeset.valid?
  end
end
