module NekoBot
	class Utils


		def self.reverse_configs(channels)
			h=Hash.new{|h,k| h[k]=[]}
			#chan=channels.map { |value| {value[:channel]=>value[:subreddits]}}.map(&:to_a).flatten(1).each{|v| h[v[0]] << v[1]}
			#c=chan.inject({}) { |hash,val| hash.merge(Hash[*val])}
			#c.inject({}){|h,(k,v)| v.map{|f| h[f] ? h[f] << k : h[f]=[k] }; h}
			channels.each { |hash| hash[:subreddits].each { |i| h[i] << hash[:channel]}}
			h
		end
	end
end