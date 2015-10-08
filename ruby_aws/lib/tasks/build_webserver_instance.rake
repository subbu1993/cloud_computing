desc "Rake task to use cloud formation to build up a web server instance"
task :build_web_server do
  @credentials =  Aws::Credentials.new(ENV['AAK'], ENV['ASAK'])
  @return_from_config = Aws.config.update({
    credentials: @credentials,
  })
  cloud_formation = Aws::CloudFormation::Client.new(region: 'us-west-2')
end
