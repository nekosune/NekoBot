require 'snoo'
require_relative '../config/settings'
module NekoBot
class Reddit

    def reddit
		@reddit ||=Snoo::Client.new
    end

	def initialize()
     	reddit.log_in NekoBot::Config::REDDIT[:username],NekoBot::Config::REDDIT[:password]
	end

	def latest
		File.read('latest.bin')
	end

	def latest=(id)
		File.open('latest.bin','w+'){|f|f.write(id)}
	end
end
end