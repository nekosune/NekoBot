require 'cinch'
Dir[File.dirname(__FILE__)+'/plugins/*.rb'].each { |file| require file}
Dir[File.dirname(__FILE__)+'/libs/*.rb'].each { |file| require file}
Dir[File.dirname(__FILE__)+'/config/*.rb'].each { |file| require file}
require 'pp'




bot=Cinch::Bot.new  do
	configure do |c|
		c.server="irc.snoonet.org"
		c.channels=["##testbots"]
		c.plugins.plugins=BasicPlugin.plugins
	end
end
#bot.start

reddit=NekoBot::Reddit.new
reddit.latest='kitty'