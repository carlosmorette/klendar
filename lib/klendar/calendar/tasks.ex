defmodule Klendar.Calendar.Task do
  use Ecto.Schema
  import Ecto.Changeset

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
end
