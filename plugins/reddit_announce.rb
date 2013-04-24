require 'cinch'
require_relative 'basic_plugin'
class RedditAnnounce < BasicPlugin
	include Cinch::Plugin
	match "whoami"

	def execute(m)
		#m.reply "#{m.user.host}"
		m.reply DatabaseHandler.instance.latest('nekosune')
	end
end