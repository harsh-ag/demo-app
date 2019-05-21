namespace :admin do

  desc 'create an admin'

  task new: :environment do
    admin = User.new
    admin.roles << Role.find_by_name('admin')

    puts 'You will be prompted to enter first name, last name, email address and password for the new admin'

    puts 'Enter first name'
    admin.first_name = get_input

    puts 'Enter last name'
    admin.last_name = get_input

    puts 'Enter an email address:'
    admin.email = get_input

    puts 'Enter a password:'
    admin.password = get_input

    if admin.valid? && admin.save
      puts 'The admin was created successfully.'
    else
      puts 'Sorry, the admin was not created!.'
      puts admin.errors.full_messages.to_sentence
    end
  end

  def get_input
    STDIN.gets.strip
  end

end
