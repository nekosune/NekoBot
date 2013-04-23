require 'cinch'
require_relative 'basic_plugin'
class Hello < BasicPlugin
	include Cinch::Plugin
	match "hello"

	def execute(m)
		m.reply "Hello, #{m.user.nick}"
	end
end