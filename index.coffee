connector = require './lib/slackConnector'
wordOperations = require './lib/wordOperations'
stages = require './lib/stages'

conn = new connector()
wordOperations =  new wordOperations()

controller = conn.getController()
stages = stages.getAllStages()
wrongAnswerCount = 0
alreadyQueriedChars = []

processResponse = (response, convo)->
  # Handle exit
  if /exit/.test( response.text )
    convo.say("Good Bye :)")

  # If more than one letter or non-letter
  else if /([a-zA-Z]([a-zA-Z])+)|[^a-zA-Z]/.test( response.text )
    console.log "Recieived non letter"
    convo.ask("One letter at a time please :)", processResponse)
  else 
    # Got a letter, handle
    if response.text in alreadyQueriedChars
      convo.ask("Letter already tried", processResponse)
    else
      alreadyQueriedChars.push( response.text )
    sol = wordOperations.checkIfLetterExists( response.text )
    console.log sol
    if sol is -1
      # Max guesses are over
      if wrongAnswerCount >= stages.length - 1
        convo.say("#{stages[wrongAnswerCount]} \n Game Over")
      convo.ask(" :white_frowning_face: \n #{stages[wrongAnswerCount]}", processResponse)
      wrongAnswerCount += 1
    else
      # No more dashes
      if /-/.test(sol) isnt true
        convo.say("You win !!!")
      else
        convo.ask(arrayToString( sol ), processResponse)  
  convo.next()

arrayToString = (array)->
  retVal = " "
  for item in array
    retVal += " #{item} "
  console.log retVal
  return retVal

controller.hears(["play"], ["direct_message"], (bot,message)=>
  problem = wordOperations.getNewProblem()
  wrongAnswerCount = 0
  alreadyQueriedChars = []
  bot.startConversation(message, (e, convo)=>
    convo.ask( arrayToString(problem) , processResponse )
  )
)


#   bot.reply( message, problem )
#   controller.hears(["[a-zA-Z][a-zA-Z]+"], ["direct_message"], (bot,message)->
#     bot.reply(message, "One letter at a time please :)")
#   )
#   controller.hears(["[a-zA-Z]"], ["direct_message"], (bot,message)=>
#     sol = wordOperations.checkIfLetterExists(message.text)
#     if sol is -1
#       if wrongAnswerCount < stages.length
#         bot.reply(message, "Game Over")
#       bot.reply(message, ":sad_smiley:\n #{stages[wrongAnswerCount]}")
#       wrongAnswerCount += 1
#     else
#       if /_/.test(sol) isnt true
#         bot.reply("You win !!!")
#       else
#         bot.reply(message, sol)
#   )
# )
