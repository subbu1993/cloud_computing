class AwsController < ApplicationController
  def run_instance
    # @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
    @hello =  ENV['ASAK']
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
    binding.pry
    @my_instance_id = @run_an_instance.instances[0].instance_id
    @get_a_state = @ec2.describe_instance_status({

      instance_ids: ["@run_an_instance.instances[0].instance_id"],
      })

      while @get_a_state.instance_statuses[0].instance_state_name == "pending"
        sleep 10
      end

      if   @get_a_state.instance_statuses[0].instance_state_name == "running"
        @terminate_the_instance = @ec2.terminate_instances({

          instance_ids: [@run_an_instance.instances[0].instance_id]
          })
      end
  end
end
