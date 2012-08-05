require File.expand_path('./../handler', __FILE__)

Dir[File.expand_path('./../', __FILE__) + "/*.rb"].each do |file|
  require file
end