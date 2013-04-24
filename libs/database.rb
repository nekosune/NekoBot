require 'sqlite3'
require_relative '../config/settings'
require_relative '../utils'
require 'singleton'
class DatabaseHandler
	include Singleton

	def initialize()
		@db=SQLite3::Database.open("reddit.db")
		@db.execute("CREATE TABLE IF NOT EXISTS Subreddits(Id INTEGER PRIMARY KEY,Subreddit TEXT,Thread TEST)")
		(NekoBot::Utils::reverse_configs NekoBot::Config::Channels).each do |name,value|
			stm = @db.prepare "SELECT COUNT(*) FROM Subreddits where Subreddit=?"
			stm.bind_param 1, name
			contain=stm.execute
			contain=contain.next
			if contain[0] == 0 
				stm=@db.prepare "INSERT INTO Subreddits (Subreddit,Thread) VALUES(?,?)"
				stm.bind_param 1, name
				stm.bind_param 2, ''
				stm.execute
			end			
		end 
		@db.execute("CREATE TABLE IF NOT EXISTS Admin(Id INTEGER PRIMARY KEY,Host TEXT)")
		stm = @db.prepare "SELECT COUNT(*) FROM Admin"
		contain=stm.execute
		contain=contain.next
		if contain[0] == 0 
			stm=@db.prepare "INSERT INTO Admin (Host) VALUES(?)"
			stm.bind_param 1, NekoBot::Config::FirstAdmin
			stm.execute
		end			
	end


	def latest(subname)
		stm=@db.prepare "select Thread from Subreddits where Subreddit=?"
		stm.bind_param 1, subname
		return stm.execute.next[0] 
	end

	def set_latest(subname,id)
		stm=@db.prepare "update Subreddits set Thread=? Where Subreddit=?"
		stm.bind_param 2, subname
		stm.bind_param 1, id
		stm.execute
	end
	def admin?(host)
		stm=@db.prepare "select count(*) from Admin where Host=?"
		stm.bind_param 1, host
		return stm.execute.next[0]!=0 
	end
	def addadmin(host)
		stm=@db.prepare "INSERT INTO Admin (Host) VALUES(?)"
		stm.bind_param 1, host
		stm.execute
	end
	def removeadmin(host)
		stm=@db.prepare "DELETE FROM Admin WHERE Host=?"
		stm.bind_param 1, host
		stm.execute
	end
end