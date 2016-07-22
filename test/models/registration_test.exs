defmodule PsyRussia.RegistrationTest do
  use PsyRussia.ModelCase

  alias PsyRussia.Registration

  @valid_attrs %{email: "some content", password_hash: "some content", status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Registration.changeset(%Registration{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Registration.changeset(%Registration{}, @invalid_attrs)
    refute changeset.valid?
  end
end
