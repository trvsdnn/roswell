namespace :roswell do

  desc 'Do initial setup to get roswell up and running'
  task :setup => :environment do
    puts "You'll need to make an admin user to get started..."
    print "Username: "
    username = STDIN.gets.chomp
    print "Password: "
    password = STDIN.gets.chomp

    User.create!(:username => username, :password => password, :admin => true)

    puts "Admin user was created, you may now login and add users & groups"
  end

end