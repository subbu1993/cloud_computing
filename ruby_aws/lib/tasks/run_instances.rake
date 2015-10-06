desc "Task to run multiple EC2 instances"
task :run_multiple_ec2_instances, [:number_of_instances, :region, :command] do |t,args|
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  region = args[:region]
  @return_from_config = Aws.config.update({
    region: region,
    credentials: @credentials,
  })

  @ec2 = Aws::EC2::Client.new({region: region})
  command = args[:command]
  number_of_instances  = args[:number_of_instances].try(:to_i)
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
    array_limit = number_of_instances - 1
    (0..array_limit).each do |instance|
      puts "Booting instance #{run_an_instance.instances[instance].instance_id}"
      describe_my_instance = @ec2.describe_instances({instance_ids: [run_an_instance.instances[instance].instance_id]})
      while describe_my_instance.reservations[0].instances[0].state.name == "pending"
          puts "Instance #{run_an_instance.instances[instance].instance_id} is in pending state"
          sleep 10
          describe_my_instance = @ec2.describe_instances({instance_ids: [run_an_instance.instances[instance].instance_id]})
      end
      if describe_my_instance.reservations[0].instances[0].state.name == "running"
        puts "launched instance #{run_an_instance.instances[instance].instance_id}"
      else
        puts "sorry failed to launch the instance"
      end
    end

  elsif command == "terminate"
    get_all_instances = @ec2.describe_instance_status()
    number_of_running_instances = get_all_instances.instance_statuses.count
    get_all_instances.instance_statuses.each do |instance|
      if instance.instance_state.name == "running"
        terminating_instance = @ec2.terminate_instances(instance_ids: [instance.instance_id])
        puts "Terminating instance #{instance.instance_id}"
        sleep 3
        while terminating_instance.terminating_instances[0].current_state.name == "shutting-down"
          puts "Instance #{instance.instance_id} is shutting-down"
          terminating_instance = @ec2.terminate_instances(instance_ids: [instance.instance_id])
          sleep 10
        end
        if terminating_instance.terminating_instances[0].current_state.name == "terminated"
          puts "Instance #{instance.instance_id} has been successfully terminated"
        end
      end
    end

  else
    puts "invalid command"
  end
end
