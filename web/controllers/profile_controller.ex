defmodule PsyRussia.ProfileController do
  use PsyRussia.Web, :controller
  import PsyRussia.Auth, only: [authorize: 2]

  plug :authorize, [who: :psychologist]

  alias PsyRussia.Profile

  def show(conn, _params) do
    profile = current_psychologist_profile(conn)
    render(conn, "show.html", profile: profile)
  end

  def edit(conn, %{"step" => step}) do
    action = match_step(step)
    profile = current_psychologist_profile(conn)

    IO.inspect profile

    changeset = Profile.changeset(profile, %{})
    |> defaults(action)

    data = action
    |> tmpl_data()

    conn
    |> put_layout("new_profile.html")
    |> assign(:step, step)
    |> render("step-#{step}.html", [changeset: changeset] ++ data)
  end

  def update(conn, %{"profile" => profile_params, "step" => step}) do
    action = match_step(step)

    changeset = current_psychologist_profile(conn)
    |> Profile.changeset(action, profile_params)

    data = action
    |> tmpl_data()

    IO.inspect changeset

    case Repo.update(changeset) do
      {:ok, profile} ->
        next = next_step(step)
        conn
        |> redirect(to: profile_path(conn, :edit, step: next))
      {:error, changeset} ->
        conn 
        |> assign(:step, step)
        |> put_layout("new_profile.html")
        |> render("step-#{step}.html", [changeset: changeset] ++ data)
    end
  end

  def update(conn, %{"profile" => profile_params}) do
    profile = current_psychologist_profile(conn)

    changeset = profile 
    |> Profile.update_changeset(:all, profile_params)

    case Repo.update(changeset) do
      {:ok, profile} ->
        conn
        |> redirect(to: profile_path(conn, :show, profile))
      {:error, changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  # TODO should i move that logic to changest?
  defp match_step(step) when is_binary(step) do
    String.to_integer(step) |> match_step
  end

  defp match_step(step) do
    case step do
      1 -> :primary_fields
      2 -> :secondary_fields
      3 -> :contact_list
      4 -> :history
      _ -> nil
    end
  end

  defp next_step(step) when is_binary(step) do
    next = String.to_integer(step) + 1
    if match_step(next) do
      next
    else
      :not_found
    end
  end


  defp defaults(changeset, :secondary_fields) do
    case changeset.data.documents do
      [] -> 
        changeset
        |> Ecto.Changeset.put_assoc(:documents, [%PsyRussia.Document{}])
      _ ->
        changeset
    end
  end

  defp defaults(changeset, :contact_list) do
    case changeset.data.contact_list do
      nil ->
        phone = %PsyRussia.Contact.Phone{}
        email = %PsyRussia.Contact.Email{}
        contact_list = %PsyRussia.ContactList{
          phone_contacts: [phone],
          email_contacts: [email]} 

        changeset
        |> Ecto.Changeset.put_assoc(:contact_list, contact_list)
      _ -> 
        changeset
    end
  end

  defp defaults(changeset, _) do
    changeset 
  end

  defp tmpl_data(:primary_fields) do
    [locations: Repo.all(PsyRussia.Location)]
  end

  defp tmpl_data(:secondary_fields) do
    [occupations: Repo.all(PsyRussia.Occupation)]
  end

  defp tmpl_data(_), do: []

  def current_psychologist_profile(conn) do
    psycho = conn.assigns.psychologist |> Repo.preload(:profile)
    psycho.profile 
    |> Repo.preload([:location, 
                     :psychologist, 
                     :occupations, 
                     :education_records, 
                     :employment_records, 
                     :documents,
                     [contact_list: [:phone_contacts, :email_contacts, :online_service_contacts]]])
  end
end
