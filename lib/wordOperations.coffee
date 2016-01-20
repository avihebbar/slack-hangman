class wordValidator
  constructor : ()->
    @words = ["testingword", "anothertestword"]
    @currWord = ""
    @encryptedWord = []

  _getNewWord : ()->
    return @words[ Math.floor(Math.random()* @words.length) ]

  getNewProblem : ()->
    word = @_getNewWord()
    @currWord = word
    @encryptedWord = []
    @encryptedWord.push("-") for letter in @currWord
    return @encryptedWord

  checkIfLetterExists : (letter)->
    regex = new RegExp(letter)
    if not regex.test( @currWord )
      return -1
    for i in [0...@currWord.length]
      if @currWord[i] == letter
        @encryptedWord[i] = letter
    return @encryptedWord

  endProblem : ()=>
    @currWord = ""
    @encryptedWord = []

module.exports = wordValidator  