defmodule PsyRussia.ProfileController do
  use PsyRussia.Web, :controller


  alias PsyRussia.Profile

  def index(conn, _params) do
    profiles = Repo.all(Profile)
    render(conn, "index.html", profiles: profiles)
  end

  def new(conn, %{"step" => step}) do
    changeset = step
    |> match_step()
    |> defaults()
    
    data = step
    |> match_step()
    |> load_assocs()

    conn
    |> put_layout("new_profile.html")
    |> assign(:step, step)
    |> render("step-#{step}.html", [changeset: changeset] ++ data)
  end

  def create(conn, %{"profile" => profile_params, "step" => step}) do
    action = match_step(step)
    changeset = Profile.changeset(%Profile{}, action, profile_params)

    data = step
    |> match_step()
    |> load_assocs()

    case Repo.insert(changeset) do
      {:ok, profile} ->
        next = next_step(step)
        conn
        |> redirect(to: profile_path(conn, :new, step: next))
      {:error, changeset} ->
        IO.inspect changeset
        conn 
        |> assign(:step, step)
        |> put_layout("new_profile.html")
        |> render("step-#{step}.html", [changeset: changeset] ++ data)
    end
  end

  def create(conn, %{"profile" => profile_params}) do
    changeset = Profile.changeset(%Profile{}, profile_params)

    case Repo.insert(changeset) do
      {:ok, _profile} ->
        conn
        |> redirect(to: profile_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def show(conn, %{"id" => id}) do
    profile = Repo.get!(Profile, id)
    render(conn, "show.html", profile: profile)
  end

  def edit(conn, %{"step" => step}) do
    action = match_step(step)
    profile = current_psychologist_profile()
    changeset = Profile.changeset(profile, %{})

    data = step
    |> match_step()
    |> load_assocs()

    conn
    |> put_layout("new_profile.html")
    |> assign(:step, step)
    |> render("step-#{step}.html", [changeset: changeset] ++ data)
  end

  def update(conn, %{"profile" => profile_params, "step" => step}) do
    action = match_step(step)
    profile = current_psychologist_profile()
    changeset = Profile.changeset(profile, action, profile_params)

    IO.inspect profile_params

    data = step
    |> match_step()
    |> load_assocs()

    case Repo.update(changeset) do
      {:ok, profile} ->
        next = next_step(step)
        conn
        |> redirect(to: profile_path(conn, :edit, step: next))
      {:error, changeset} ->
        IO.inspect changeset
        conn 
        |> assign(:step, step)
        |> put_layout("new_profile.html")
        |> render("step-#{step}.html", [changeset: changeset] ++ data)
    end
  end

  def update(conn, %{"profile" => profile_params}) do
    profile = Repo.get!(Profile, 1)
    changeset = Profile.changeset(profile, profile_params)

    case Repo.update(changeset) do
      {:ok, profile} ->
        conn
        |> redirect(to: profile_path(conn, :show, profile))
      {:error, changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Repo.get!(Profile, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(profile)

    conn
    |> put_flash(:info, "Profile deleted successfully.")
    |> redirect(to: profile_path(conn, :index))
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

  defp load_assocs(:primary_fields) do
    [locations: Repo.all(PsyRussia.Location)]
  end

  defp load_assocs(:secondary_fields) do
    [occupations: Repo.all(PsyRussia.Occupation)]
  end

  defp load_assocs(_), do: []

  defp defaults(:secondary_fields) do
    Profile.changeset(%Profile{documents: [%PsyRussia.Document{}]})
  end

  defp defaults(:contact_list) do
    phone = %PsyRussia.Contact.Phone{}
    email = %PsyRussia.Contact.Email{}
    contact_list = %PsyRussia.ContactList{
      phone_contacts: [phone],
      email_contacts: [email]} 

    PsyRussia.Profile.changeset(%PsyRussia.Profile{contact_list: contact_list})
  end

  defp defaults(_) do
  end

  def current_psychologist_profile do
    Repo.get(Profile, 1)
    |> Repo.preload(:location)
    |> Repo.preload(:psychologist)
    |> Repo.preload(:occupations)
    |> Repo.preload(:contact_list)
    |> Repo.preload(:education_records)
    |> Repo.preload(:employment_records)
    |> Repo.preload(:documents)
    |> Profile.changeset()
  end
end
