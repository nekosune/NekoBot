require 'cinch'
require_relative 'basic_plugin'
class Authentication < BasicPlugin
	include Cinch::Plugin


	match "amiadmin"
	match /addadmin (.+)/, method: :addadmin
	match /removeadmin (.+)/, method: :removeadmin
	match /updateadmin (.+) (.+)/, method: :updateadmin

	def addadmin(m,arg)
		if not DatabaseHandler.instance.admin? m.user.host
			m.reply("Sorry, you are not authorized to do that",true)
		else
			m.reply("Adding Admin #{arg}",true)
			if arg.include?('/')
				DatabaseHandler.instance.addadmin(arg)
				m.reply("Added Admin #{arg}",true)
				return
			end
			if not m.channel? 
				m.reply("Sorry, You must specify new admin by host")
				return
			end
			vals=m.channel.users.find_all{ |user,modes| user.nick.include? arg }
			if vals.size()==0
				m.reply("Sorry, no such user found",true)
			elsif vals.size()>1
				m.reply("Sorry, too many users matched",true)
			else
				m.reply("Found User #{vals[0][0].nick}",true)
				DatabaseHandler.instance.addadmin(vals[0][0].host)
				m.reply("Added Admin #{vals[0][0].nick}")
			end

		end
	end 

	def removeadmin(m,arg)
		if not DatabaseHandler.instance.admin? m.user.host
			m.reply("Sorry, you are not authorized to do that",true)
		else
			m.reply("Removing Admin #{arg}",true)
			if arg.include?('/')
				if not DatabaseHandler.instance.admin? arg
					m.reply("Sorry, that admin is not found",true)
				end
				DatabaseHandler.instance.removeadmin(arg)
				m.reply("removed Admin #{arg}",true)
				return
			end
			if not m.channel? 
				m.reply("Sorry, You must specify admin by host")
				return
			end
			vals=m.channel.users.find_all{ |user,modes| user.nick.include? arg }
			if vals.size()==0
				m.reply("Sorry, no such user found",true)
			elsif vals.size()>1
				m.reply("Sorry, too many users matched",true)
			else
				m.reply("Found User #{vals[0][0].nick}",true)
				if not DatabaseHandler.instance.admin? vals[0][0].host
					m.reply("Sorry, that admin is not found",true)
				end
				DatabaseHandler.instance.removeadmin(vals[0][0].host)
				m.reply("Removed Admin #{vals[0][0].nick}")
			end

		end
	end
	def updateadmin(m,old,newname)
		m.reply(" old: #{old} new: #{newname}",true)
	end

	def execute(m)
		#m.reply "#{m.user.host}"
		m.reply DatabaseHandler.instance.admin? m.user.host
	end
end