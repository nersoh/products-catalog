# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create([
	{name: "Product 01", description: "Description of Product 01", status: "newer"},
	{name: "Product 02", description: "Description of Product 02", status: "normal"},
	{name: "Product 03", description: "Description of Product 03"},
	{name: "Product 04", description: "Description of Product 04", status: "featured"},
	{name: "Product 05", description: "Description of Product 05"},
	{name: "Product 06", description: "Description of Product 06", status: "featured"},
	{name: "Product 07", description: "Description of Product 07", status: "featured"},
	{name: "Product 08", description: "Description of Product 08"},
	{name: "Product 09", description: "Description of Product 09"},
])

User.create(name: "Administrator", email:"admin@admin.com",
						password: "password", password_confirmation: "password")