# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ticket.destroy_all
Ticket.create(
  description: "Take the dog for no less than a 20 minute walk and don't forget those wonderful blue bags.",
  title: "Walk the Dog",
  priority: 1
)
Ticket.create(
  description: "Get the bucket of luke-warm water and soap out and clean him up.",
  title: "Give the Dog a Bath",
  priority: 2
)
Ticket.create(
  description: "Just stick them in the dishwasher, idiot.",
  title: "Wash the Dog Dishes",
  priority: 2
)
Ticket.create(
  description: "The old leash is getting worn. You're going to lose him one day.",
  title: "Get a New Leash",
  priority: 3
)

Ticket.create(
  description: "Time for his annual shots. He's going to love that. Have plenty of treats ready to make him feel better afterward.",
  title: "Get the Dog His Shots",
  priority: 1
)
