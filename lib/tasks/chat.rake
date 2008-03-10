namespace :messages do
  desc "Clears all message history"
  task :clear => :environment do
    puts Message.delete_all
    puts User.update_all('last_message_id = NULL')
  end
end
