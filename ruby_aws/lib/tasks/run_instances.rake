desc "Task to run multiple EC2 instances"
task :run_multiple_ec2_instances do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  @return_from_config = Aws.config.update({
    region: 'us-west-2',
    credentials: @credentials,
  })
  @ec2 = Aws::EC2::Client.new

  # get a list of running instances
  running_instances = @ec2.describe_instances()
  puts running_instances.class.to_s
  binding.pry



end
