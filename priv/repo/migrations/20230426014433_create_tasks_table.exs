defmodule Klendar.Repo.Migrations.CreateTasksTable do
  use Ecto.Migration

  def up do
    create table(:calendar_tasks) do
      add :title, :string
      add :description, :string
      add :email, :string
      add :hex_color, :string

      add :hour, :naive_datetime

      timestamps()
    end
  end
end
