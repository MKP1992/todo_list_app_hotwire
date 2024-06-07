namespace :db do
  desc "Automate setup: bundle, create db, migrate and seed"
  task setup: :environment do
    puts "Running bundle install..."
    system('bundle install')

    puts "Creating database..."
    Rake::Task['db:create'].invoke

    puts "Running migrations..."
    Rake::Task['db:migrate'].invoke

    puts "Seeding the database..."
    Rake::Task['db:seed'].invoke

    puts "Setup complete!"
  end
end
