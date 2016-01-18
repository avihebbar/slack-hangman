botkit = require 'botkit'

class SlackConnector
	constructor : ()->
		@controller = botkit.slackbot()
		@bot = @controller.spawn({
			token : 'xoxb-18767645623-SGxXeItoBPNt8Eb5wj5Ugk29'	
		})
		@bot.startRTM()
		@_listen()
		
	_listen : ()->
		@controller.hears(["play"], ["direct_message"], (bot,message)=>
		# @controller.on('direct_message', (bot,message)=>
			@controller.hears(["[a-zA-Z][a-zA-Z]+"], ["direct_message"], (bot,message)->
				bot.reply(message, "One letter at a time please :)")
			)
			@controller.hears(["[a-zA-Z]"], ["direct_message"], (bot,message)=>
				bot.reply(message, @finalReply)
			)
		)
		
module.exports = SlackConnector

