# Load the rails application

require File.expand_path('../application', __FILE__)

# Initialize the rails application
SampleApp::Application.initialize!

require 'bleak_house' if ENV['BLEAK_HOUSE']

