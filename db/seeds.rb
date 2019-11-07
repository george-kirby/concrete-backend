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

get_wine = Task.create(user: geo, title: "Get wine", cue: "on commute home", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 1)
choose_clothes = Task.create(user: geo, title: "Choose clothes", cue: "after dinner", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 2)
write_card = Task.create(user: geo, title: "Write card", cue: "after choosing clothes", display_time: "evening", actual_time: Time.new(2019, 11, 25, 18, 30), position_at_time: 3)
plan_travel = Task.create(user: geo, title: "Plan travel", cue: "after breakfast", display_time: "morning", actual_time: Time.new(2019, 11, 26, 10, 00), position_at_time: 1)

wine_s1 = Step.create(task: get_wine, act: "go to off-licence", position: 1)
clothes_s1 = Step.create(task: choose_clothes, act: "open wardrobe, choose from shirts to wear", position: 1)
clothes_s2 = Step.create(task: choose_clothes, act: "set up ironing board and iron", position: 2)
card_s1 = Step.create(task: write_card, act: "sit at desk with pen and card", position: 1)
travel_s1 = Step.create(task: plan_travel, act: "phone, search maps for Bob's address", position: 1)