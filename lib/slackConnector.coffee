botkit = require 'botkit'

class SlackConnector
  constructor : ()->
    @controller = botkit.slackbot()
    @bot = @controller.spawn({
      token : 'xoxb-18767645623-SGxXeItoBPNt8Eb5wj5Ugk29' 
    })
    @bot.startRTM()
  
  getController : ()->
    return @controller
    
module.exports = SlackConnector

