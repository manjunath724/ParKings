# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create an Admin User
if User.count.zero?
  puts "Creating Admin User for ParKings"
  
  print "Enter Admin email id : "
  email_id = STDIN.gets.chomp
  user = User.new(email: email_id, user_role: 'Admin')
  
  print 'Enter password : '
  pass1 = STDIN.gets.chomp
  user.password = pass1

  print 'Confirm password : '
  pass2 = STDIN.gets.chomp

  fail 'password mismatch' unless pass1 == pass2
  user.password_confirmation = pass2

  user.save
end
