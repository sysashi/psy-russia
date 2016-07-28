# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PsyRussia.Repo.insert!(%PsyRussia.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Data do
  def populate do
    add_occupations()
    add_locations()
  end

  def occupations do
    [%{name: "Социальная психология",
        description: "занимается изучением поведения отдельного человека,
  так и группы в целом, с целью выявления психологических закономерностей и
  явлений в процессе общения и взаимодействий друг с другом. В своих исследованиях
  использует научные методы психологии и социологии."},
      %{name: "Возрастная психология",
        description: "этот раздел психологии, который занимается изучением
  этапов психологического развития личности, на протяжении всего онтогенеза. При
  изучении возрастных периодов, во внимание принимаются социальные,
  биологические и психологические факторы."}]
  end

  def locations do
    [%{city: "Иркутск"},
     %{city: "Москва"}]
  end

  def add_occupations do
    Enum.each occupations(), fn o ->
      PsyRussia.Occupation.changeset(%PsyRussia.Occupation{}, o)
      |> PsyRussia.Repo.insert!()
    end
  end

  def add_locations do
    Enum.each locations(), fn l ->
      PsyRussia.Location.changeset(%PsyRussia.Location{}, l)
      |> PsyRussia.Repo.insert!()
    end
  end
end

Data.populate()
