desc " To stop all instances running in every region "
task :stop_all_instances do
  args.with_defaults(:number_of_instances => 1, :region => 'us-west-2', :command => 'start')
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  region = args[:region]
  @return_from_config = Aws.config.update({
    credentials: @credentials,
  })
  list_of_regions = Array.new
  list_of_regions.push('us-east-1')
  list_of_regions.push('us-west-1')
  list_of_regions.push('us-west-2')
  list_of_regions.push('eu-west-1')
  list_of_regions.push('eu-central-1')
  list_of_regions.push('ap-southeast-1')
  list_of_regions.push('ap-southeast-2')
  list_of_regions.push('ap-northeast-1')
  list_of_regions.push('sa-east-1')

  list_of_regions.each do |region|
    @ec2 = Aws::EC2::Client.new({region: region})
    get_all_instances = @ec2.describe_instance_status()
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
  end


end
