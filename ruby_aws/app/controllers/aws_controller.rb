class AwsController < ApplicationController
  def run_instance
    # @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
    @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
    @return_from_config = Aws.config.update({
      region: 'us-west-2',
      credentials: @credentials,
    })



    @ec2 = Aws::EC2::Client.new

    @run_an_instance = @ec2.run_instances({

      image_id: "ami-9ff7e8af",
      min_count: 1,
      max_count: 1,
      security_groups: ["launch-wizard-1"],
      instance_type: "t2.micro",
    })
    @my_instance_id = @run_an_instance.instances[0].instance_id
    @get_a_state = @ec2.describe_instances({
      instance_ids: [@run_an_instance.instances[0].instance_id.to_s],
      })
      while @get_a_state.reservations[0].instances[0].state.name.to_s == "pending"
        # do nothing
        @get_a_state = @ec2.describe_instances({
          instance_ids: [@run_an_instance.instances[0].instance_id.to_s],
          })
      end
      @get_a_state = @ec2.describe_instances({
        instance_ids: [@run_an_instance.instances[0].instance_id.to_s],
        })
      if  @get_a_state.reservations[0].instances[0].state.name.to_s  == "running"
        @terminate_the_instance = @ec2.terminate_instances({
                instance_ids: [@run_an_instance.instances[0].instance_id.to_s]
          })
      end

  end
end
