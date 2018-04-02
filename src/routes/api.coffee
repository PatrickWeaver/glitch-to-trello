express = require('express')
router = express.Router()

trello = require('../modules/trello')()

rp = require('request-promise-native')

router.get('/', (req, res) ->
  res.send("API")  
)

router.get("/create-board", (req, res) ->
  
  q = req.query
  
  body =
    key: process.env.TRELLO_API_KEY
    token: process.env.TRELLO_TOKEN
    name: q.boardName
    
  
  if process.env.TRELLO_TEAM_ID
    body.idOrganization = process.env.TRELLO_TEAM_ID
  
  body.prefs_background = if q.color && trello.colors.indexOf(q.color) >= 0 then q.color else trello.getColor()
    
  console.log(body)
  
  options =
    method: "POST"
    uri: trello.apiUrl + "boards/"
    body: body
    json: true
    
  rp(options)
  .then (data) ->
    console.log(data)
    
    response =
      success: true
      boardName: data.name
      boardId: data.id
      boardOrganization: data.idOrganization
      boardUrl: data.url
      boardColor: data.prefs.background
    res.json(response)
    
  .catch (err) ->
    console.log("Error:")
    console.log(err)
    
    response =
      success: false
      error: err
    res.json(response)
  
)

module.exports = router