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

    # let us make the task run 2 instances
    (0..1).each do |instance_number|
      run_an_instance = @ec2.run_instances({
        image_id: "ami-9ff7e8af",
        min_count: 1,
        max_count: 1,
        security_groups: ["launch-wizard-1"],
        instance_type: "t2.micro",
      }) #successfully launched an instance

      # checking instance state
      run_an_instance.instances.each do |instance|
        while instance.state.name == "pending"
          sleep 5
        end
        if instance.state.name == "running"
          puts "launched instance #{instance.instace_id}"
        end
      end
    end
  end





end
