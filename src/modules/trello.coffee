trello = () ->
  apiUrl:        "https://api.trello.com/1/"
  trelloApiKey:  process.env.TRELLO_API_KEY
  trelloToken:   process.env.TRELLO_TOKEN
  test:          process.env.TEST
  colors:        ['blue', 'green', 'red', 'orange', 'pink', 'purple', 'sky', 'grey', 'lime']
  getColor:() ->
    c = this.colors
    return c[Math.floor(Math.random() * c.length)]

module.exports = trello