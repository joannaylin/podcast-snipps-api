# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


supreme_court_rights = Episode.create!(episode_name: "Supreme Court Protects Rights For DACA and LGBTQ Workers", duration: 2323096, description: "What does it all mean when so much change happens at the same time? This week, the Supreme Court protected the rights of two marginalized groups — DACA recipients and LGBTQ workers — and protests against police brutality continued around the world.", spotify_episode_id: "0L4zdsT899Krg8d7WryY3d", img_url: "https://i.scdn.co/image/74a86ed23c87e8db8f30cc936748e509027d56a9", show_name: "It's Been a Minute with Sam Sanders", spotify_show_id: "6gcw7EF2i70vXXXJnhBNgA")

comment_1 = Comment.create!(note: "Hi this is a test commentt!!! helllooooooooooo, this is awesome", user_id: 1, episode_id: 1, start_timestamp: "1234 seconds")
