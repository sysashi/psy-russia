defmodule PsyRussia.ContactListTest do
  use PsyRussia.ModelCase

  alias PsyRussia.ContactList

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ContactList.changeset(%ContactList{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ContactList.changeset(%ContactList{}, @invalid_attrs)
    refute changeset.valid?
  end
end
