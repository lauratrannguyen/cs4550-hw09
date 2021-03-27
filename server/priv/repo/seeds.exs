# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eventsapp.Repo.insert!(%Eventsapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#ATTRIBUTION TO NAT TUCK'S GITHUB, #16
alias Eventsapp.Repo
alias Eventsapp.Users.User
alias Eventsapp.Events.Event
alias Eventsapp.Comments.Comment
alias Eventsapp.Invites.Invite

defmodule Insert do
  def user(name, pass, email) do
    hash = Argon2.hash_pwd_salt(pass)
    Repo.insert!(%User{name: name, email: email, password_hash: hash})
  end
end

alice = Insert.user("Alice", "12345510", "aliceiscool@gmail.com")
bob = Insert.user("Bob", "12345623", "bobsucks@gmail.com")

e1 = %Event{
  user_id: alice.id,
  name: "Alice's Birthday Party",
  desc: "Alice is turning 30!",
  date: ~N[2020-06-30 10:00:00]
}
event = Repo.insert!(e1)

c1 = %Comment{
  event_id: event.id,
  user_id: bob.id,
  body: "Lol you're old"
}

Repo.insert!(c1)

e2 = %Event{
  user_id: bob.id,
  name: "Bob's race car opening",
  desc: "Bob got a new car",
  date: ~N[2020-11-29 11:00:00]
}
Repo.insert!(e2)

i1 = %Invite{
  event_id: event.id,
  user_id: bob.id,
  response: :No
}
Repo.insert!(i1)