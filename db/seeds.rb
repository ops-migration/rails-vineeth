puts "Seeding database..."

Task.destroy_all

tasks = [
  { title: "Set up Rails application", description: "Initialize the project with all required gems and configurations.", status: "completed", due_date: 1.week.ago },
  { title: "Design database schema", description: "Create migrations for users, tasks, and related tables.", status: "completed", due_date: 5.days.ago },
  { title: "Build REST API endpoints", description: "Implement CRUD operations for the Tasks resource.", status: "in_progress", due_date: 2.days.from_now },
  { title: "Add TailwindCSS styling", description: "Style all views using utility classes for a modern look.", status: "in_progress", due_date: Date.tomorrow },
  { title: "Write integration tests", description: "Cover all API endpoints and model validations.", status: "pending", due_date: 1.week.from_now },
  { title: "Configure Thruster web server", description: "Set up Thruster as HTTP accelerator in front of Puma.", status: "completed", due_date: 3.days.ago },
  { title: "Dockerize the application", description: "Create Dockerfile and docker-compose.yml for container deployment.", status: "completed", due_date: 2.days.ago },
  { title: "Add API authentication", description: "Implement JWT or API key authentication for the REST API.", status: "pending", due_date: 2.weeks.from_now },
  { title: "Set up CI/CD pipeline", description: "Configure GitHub Actions for automated testing and deployment.", status: "pending", due_date: 3.weeks.from_now },
  { title: "Performance optimization", description: "Add caching, query optimization, and response compression.", status: "pending", due_date: 1.month.from_now },
]

tasks.each do |attrs|
  Task.create!(attrs)
  print "."
end

puts "\nCreated #{Task.count} tasks!"
