namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Create role admin"
    admin_role = Role.create name: "Admin"

    admin = User.create email: "hellovietnam93@gmail.com", password: "123456",
      password_confirmation: "123456"
    admin.roles << admin_role
  end
end
