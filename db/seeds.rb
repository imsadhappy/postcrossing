# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

case Rails.env
when 'development'
  # create 10 pages in DB
  (1..10).each do
    Page.create!(
      slug: Faker::Internet.slug,
      title: Faker::Lorem.sentence(word_count: 3),
      body: '<p>' << Faker::Lorem.paragraphs(number: rand(5..10)).join('</p><p>') << '</p>'
    )
  end
  Page.create!(
    slug: 'privacy-policy',
    title: 'Privacy Policy',
    body: '<p>' << Faker::Lorem.paragraphs.join('</p><p>') << '</p>'
  )
  Page.create!(
    slug: 'stats',
    title: 'Community Stats',
    body: '<p>' << Faker::Lorem.paragraphs.join('</p><p>') << '</p>'
  )
end
