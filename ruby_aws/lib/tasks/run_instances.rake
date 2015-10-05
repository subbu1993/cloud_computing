desc "Task to run multiple EC2 instances"
task :run_multiple_ec2_instances do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  @return_from_config = Aws.config.update({
    credentials: @credentials,
  })
  @ec2 = Aws::EC2::Client.new({region: 'us-west-2',})

  # get a list of running instances
  running_instances = @ec2.describe_instances()


  if running_instances.reservations.empty?
    puts "You do not currently have any instance running"
  end



end
