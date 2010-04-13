require 'config/environment'
require 'resque/server'

use Rails::Rack::LogTailer
use Rails::Rack::Static
use Rack::ShowExceptions

run Rack::URLMap.new \
  "/" => ActionController::Dispatcher.new,
  "/resque" => Resque::Server.new
