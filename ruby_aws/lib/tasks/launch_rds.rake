desc "Rake task that is going to launch a RDS instance"
task :launch_rds => :environment do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  rds = Aws::RDS::Client.new(region: 'us-west-2', credentials: @credentials)
  new_db_instance = rds.create_db_instance(
  db_name: "Nutrition",
  db_instance_identifier: "NutritionDB",
  db_instance_class: "db.t1.micro",
  engine: "MySQL",
  master_username: "root",
  master_user_password: "subbu1993",
  allocated_storage: 5
  )
  binding.pry
end
