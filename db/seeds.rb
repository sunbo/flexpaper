# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

names = %w(办公室 机关 纪委 总经理)
names.each do |name|
  department = Department.new
  department.name = name
  department.save
end


user = User.new
user.login = "admin"
user.name = "admin"
user.sex = "男"
user.department_id = 0
user.email = "admin@gmail.com"
user.password = APP_CONFIG[:default_password]
user.password_confirmation = APP_CONFIG[:default_password]
user.save(false)

user = User.new
user.login = "sunbo"
user.name = "sunbo"
user.sex = "男"
user.department_id = 1
user.email = "yueyuegigi21@gmail.com"
user.password = APP_CONFIG[:default_password]
user.password_confirmation = APP_CONFIG[:default_password]
user.save(false)
