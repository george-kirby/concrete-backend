# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.destroy_all
User.destroy_all

geo = User.create(email: "g@g.com", password: "p")

get_wine = Task.create(user: geo, title: "Get wine", cue: "on commute home", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 1, 
tags: ["bob's party", "commute"],
steps: ["go to offy", "1 rose, 1 red, 3 white", "some rum too"]
)
choose_clothes = Task.create(user: geo, title: "Choose clothes", cue: "after dinner", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 2,
tags: ["bob's party"],
steps: ["open wardrobe, choose from shirts to wear", "set up ironing board and iron"]
)
write_card = Task.create(user: geo, title: "Write card", cue: "after choosing clothes", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 3,
tags: ["bob's party"],
steps: ["sit at desk with pen and card"]
)
plan_travel = Task.create(user: geo, title: "Plan travel", cue: "after breakfast", display_time: "morning", actual_time: Time.new(2019, 11, 26, 10, 00), position_at_time: 1,
tags: ["bob's party"],
steps: ["phone, search maps for Bob's address"]
)
