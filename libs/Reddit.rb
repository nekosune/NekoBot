require 'snoo'
require 'sqlite3'
require_relative '../config/settings'
require_relative '../utils'
module NekoBot
class Reddit

    def reddit
		@reddit ||=Snoo::Client.new
    end
    def subreddits
    	@subreddits ||=NekoBot::Utils::reverse_configs NekoBot::Config::Channels
    end
	def initialize()
     	reddit.log_in NekoBot::Config::REDDIT[:username],NekoBot::Config::REDDIT[:password]
	end
end
end