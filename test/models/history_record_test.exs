defmodule PsyRussia.HistoryRecordTest do
  use PsyRussia.ModelCase

  alias PsyRussia.HistoryRecord

  @valid_attrs %{from: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, in: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, subject: "some content", to: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HistoryRecord.changeset(%HistoryRecord{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HistoryRecord.changeset(%HistoryRecord{}, @invalid_attrs)
    refute changeset.valid?
  end
end
