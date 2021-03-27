defmodule Eventsapp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    has_many :events, Eventsapp.Events.Event, on_delete: :delete_all
    has_many :comments, Eventsapp.Comments.Comment, on_delete: :delete_all
    has_many :invites, Eventsapp.Invites.Invite, on_delete: :delete_all

    timestamps()
  end

  @password_opts [
    length: [min: 5, max: 20, messages: [too_short: "Password must be at least 5 chars"]],
    character_set: [
      upper_case: [1, :infinity], 
      numbers: [1, :infinity], 
    ]
  ]

# FOR CREATING PASSCODE FUNCTIONALITY
  @doc false
  def changeset(user, attrs) do
    password = attrs["password"]
    user
    |> cast(attrs, [:name, :email])
    |> validate_password(password, @password_opts)
    |> add_password_hash(password)
    |> validate_required([:name, :email, :password_hash])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def changeset_force(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def validate_password(cset, password, opts) do
    PasswordValidator.validate_password(password, @password_opts)
    cset
  end

  def add_password_hash(cset, nil) do
    cset
  end

  def add_password_hash(cset, password) do
    change(cset, Argon2.add_hash(password))
  end
end
