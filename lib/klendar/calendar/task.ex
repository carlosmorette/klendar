defmodule Klendar.Calendar.Task do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Klendar.Repo

  schema "calendar_tasks" do
    field :title, :string
    field :description, :string
    field :email, :string
    field :hex_color, :string
    field :hour, :naive_datetime

    timestamps()
  end

  def changeset(cl_tsk, attrs) do
    cl_tsk
    |> cast(attrs, [
      :title,
      :description,
      :email,
      :hex_color,
      :hour
    ])
  end

  def insert!(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert!()
  end

  def find(year: year, month: month, day: day) do
    query =
      from t in __MODULE__,
        where: fragment("strftime('%Y', ?)", t.hour) == ^year,
        where: fragment("strftime('%m', ?)", t.hour) == ^month,
      where: fragment("strftime('%d', ?)", t.hour) == ^day

    Repo.all(query)
  end
end
