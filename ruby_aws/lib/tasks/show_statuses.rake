desc "Shows any instance running across all regions"
task :show_statuses_of_each_instance do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
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
    @ec2 = Aws::EC2::Client.new(region: region)
    get_number_of_instances = @ec2.describe_instance_status()
    puts "Total number of instances in the #{region} region is #{get_number_of_instances.instance_statuses.count}"
  end
end
