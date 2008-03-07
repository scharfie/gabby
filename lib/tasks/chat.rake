namespace :messages do
  desc "Clears all message history"
  task :clear => :environment do
    puts Message.delete_all
  end
end
