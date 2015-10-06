# **CLOUD COMPUTING**
A list of cloud assignments to be deployed on AWS to help me learn about cloud

# Programmatically spinning instances up and down
## Installing Ruby
` brew install rbenv ruby-build `

Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

Install the required Ruby version
` rbenv install 2.0.0-p645 `

Set this version on the global environment
` rbenv global 2.0.0p645 `

Check if ruby has been properly installed using
` ruby -v `
*The above command should return the version of ruby installed which should be 2.0.0p645*

GoRails.com has a good tutorial on installing ruby on different operating systems

Do take a look if you have queries
  [https://gorails.com/setup/osx/10.10-yosemite#ruby]


## Clone in the repository
The easiest way is to clone in my GitHub cloud_computing repository
` git@github.com:subbu1993/cloud_computing.git `

##Install the required gems
The first step for working with a ruby application is to install bundler

Run the following at the command prompt
` gem install bundler `

Then migrate into the ruby_aws directory and run
` bundle install `

The above command fetches all of the required gems from source and downloads them for the application to use

##Run the task to spin instances up

The source code for the task is at

** *ruby_aws/lib/tasks/run_instances.rake* **

From the directory ruby_aws run
` bundle exec rake run_multiple_ec2_instances `
Running the above without any arguments spins up *one EC2 instance* in the region *us-west-2*

**To Provide command line arguments**
` bundle exec rake run_multiple_ec2_instances[number_of_instances_to_spin_up_or_down,region,start_or_terminate] `
Example
1. ` bundle exec rake run_multiple_ec2_instances[3,us-west-2,start] `
    The above command spins up 3 instances in the us-west-2 region

2. ` bundle exec rake run_multiple_ec2_instances[2,us-west-2,terminate] `
    Terminates 2 instances in the us-west-2 region
