#puts Dir.pwd
#puts File.dirname(__FILE__)
#puts File.read("#{File.dirname(File.join(File.dirname(__FILE__), '../../'))}/config.json")
#puts __FILE__
#puts File.dirname( __FILE__)
# File.expand_path( __FILE__)
#require 'json'
#puts JSON.parse(File.read("../config.json"))
puts File.absolute_path __FILE__
puts File.read(File.expand_path("../../config.json", __FILE__))
