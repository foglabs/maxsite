# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Comic.create(img: '/assets/clouds.jpg', desc: 'This is A crazy Comic!', title: 'Check me Out!', position: 1)
Comic.create(img: '/assets/clouds.jpg', desc: 'Comic Number Two!', title: 'Same as the first', position: 2)
Comic.create(img: '/assets/clouds.jpg', desc: 'Patrick Swayze', title: 'Checking it out', position: 3)

