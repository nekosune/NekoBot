class BasicPlugin
	def self.plugins
		@plugins ||=[]
	end

	def self.inherited(klass)
		plugins << klass
	end
end