desc "Task to run multiple EC2 instances"
task :run_multiple_ec2_instances do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  @return_from_config = Aws.config.update({
    credentials: @credentials,
  })
  @ec2 = Aws::EC2::Client.new({region: 'us-west-2',})

  run_an_instance = @ec2.run_instances({
  image_id: "ami-9ff7e8af",
  min_count: 1,
  max_count: 1,
  security_groups: ["launch-wizard-1"],
  instance_type: "t2.micro",
  }) #successfully launched an instance
  # checking instance state

  run_an_instance.instances.each do |instance|
    describe_my_instance = @ec2.describe_instances({instance_ids: [instance.instance_id]})
    while describe_my_instance.reservations[0].instances[0].state.name == "pending"
        sleep 4
        describe_my_instance = @ec2.describe_instances({instance_ids: [instance.instance_id]})
    end
    if describe_my_instance.reservations[0].instances[0].state.name == "running"
      puts "launched instance #{instance.instance_id}"
    else
      puts "sorry failed to launch the instance"
    end
  end
end
