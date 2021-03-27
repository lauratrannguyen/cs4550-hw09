defmodule Eventsapp.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    #field :user_id, :id
    #field :event_id, :id

    belongs_to :event, Eventsapp.Events.Event
    belongs_to :user, Eventsapp.Users.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :event_id, :user_id])
    |> validate_required([:body, :event_id, :user_id])
  end
end
