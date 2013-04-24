require 'spec_helper'
require_relative '../utils'
describe "Utils" do
	describe "reverse_configs" do
		it "Should return flipped hash" do
			channels=[
			{
				channel: '##testbots', 
				subreddits: ['nekosune','subredditdrama','drama']
			},
			{
				channel: '##testdramabots', 
				subreddits: ['subredditdrama','drama']
			}
			]
			chan=NekoBot::Utils::reverse_configs channels
			expected={"nekosune"=>["##testbots"],"subredditdrama"=>["##testbots", "##testdramabots"], "drama"=>["##testbots", "##testdramabots"]}
			chan.should eql(expected)
		end
	end
end