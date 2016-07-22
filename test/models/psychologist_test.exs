defmodule PsyRussia.PsychologistTest do
  use PsyRussia.ModelCase

  alias PsyRussia.Psychologist

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Psychologist.changeset(%Psychologist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Psychologist.changeset(%Psychologist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
