desc "Task to run multiple EC2 instances"
task :run_multiple_ec2_instances, [:number_of_instances, :region, :command] do |t,args|
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  @return_from_config = Aws.config.update({
    credentials: @credentials,
  })
  region = args[:region]
  @ec2 = Aws::EC2::Client.new({region: , region})
  command = args[:command]
  number_of_instances  = args[:number_of_instances]

  if command == "start"
    puts 'Trying to launch multiple instances'
    run_an_instance = @ec2.run_instances({
    image_id: "ami-9ff7e8af",
    min_count: number_of_instances,
    max_count: number_of_instances,
    security_groups: ["launch-wizard-1"],
    instance_type: "t2.micro",
    }) #successfully launched an instance
    # checking instance state

    (0..0).each do |instance|
      puts "Booting instance #{run_an_instance.instances[instance].instance_id}"
      describe_my_instance = @ec2.describe_instances({instance_ids: [run_an_instance.instances[instance].instance_id]})
      while describe_my_instance.reservations[0].instances[0].state.name == "pending"
          puts "Instance #{run_an_instance.instances[instance].instance_id} is in pending state"
          sleep 4
          describe_my_instance = @ec2.describe_instances({instance_ids: [run_an_instance.instances[instance].instance_id]})
      end
      if describe_my_instance.reservations[0].instances[0].state.name == "running"
        puts "launched instance #{run_an_instance.instances[instance].instance_id}"
      else
        puts "sorry failed to launch the instance"
      end
    end

  elsif command == "terminate"
    get_all_instances = @ec2.describe_instance_statuses()

    get_all_instances.instance_statuses.each do |instance|
      if instance.state.name == "running"
        terminating_instance = @ec2.terminate_instances(instance_ids: [instance.instance_id])
        get_termination_state = @ec2.describe_instance_statuses(instance_ids: [instance.instance_id])
        while get_termination_state.instances[0].state.name == "shutting-down"
          sleep 4
          puts "Instance #{instance.instance_id} is currently #{get_termination_state.instances[0].state.name}"
          get_termination_state = @ec2.describe_instance_statuses(instance_ids: [instance.instance_id])
        end
        if get_termination_state.instances[0].state.name == "terminated"
          puts "Terminated instance #{instance.instance_id}"
        else
          puts "Error terminating #{instance.instance_id}"
        end
      end
    end

  else
    puts "invalid command"
  end

  end

end
