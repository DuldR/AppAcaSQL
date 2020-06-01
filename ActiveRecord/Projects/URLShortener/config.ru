# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
config.console = Pry
run Rails.application
