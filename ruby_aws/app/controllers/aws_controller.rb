class AwsController < ApplicationController
  def run_instance
    @credentials =  Aws::Credentials.new(ENV['AWS_ACCES_KEY'], ENV['AWS_SECURITY_ACCESS_ID'])
    @return_from_config = Aws.config.update({
      region: 'us-west-2',
      credentials: @credentials,
    })




    @ec2 = Aws::EC2::Client.new(region:'us-west-2', credentials: @credentials)

    @run_an_instance = @ec2.run_instances({
      image_id: "ami-9ff7e8af",
      min_count: 1,
      max_count: 1,
      security_groups: ["launch-wizard-1"],
      instance_type: "t2.micro",
    })

    @run_instances.descibe_instance_status ==

  end
end
