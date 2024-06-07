# db/seeds.rb

# Clear existing data
Task.destroy_all

# Create tasks
3.times do |i|
  Task.create!(
    title: "Active Task #{i + 1}",
    archived: false
  )
end

3.times do |i|
  Task.create!(
    title: "Archived Task #{i + 1}",
    archived: true
  )
end

puts "Created #{Task.count} tasks"
