# This client-side CoffeeScript is compiled 
# by express browserify middleware using the
# coffeeify transform

hello = require '../modules/coffee-module'
console.log(hello + ' world :o')

$ = require 'jquery'
apiUrl = "https://glitch-to-trello.glitch.me/api/create-board"

glitchApiUrl = "https://api.glitch.com/"



projectsList = (project) ->
  console.log project.domain + ": " + project.description
  $( "#glitch-projects" ).append '<li class="glitch-project"><h4>' + project.domain + '</h4><p>' + project.description + '</p><select>' + $( "#create-board-form > .background-color" ).html() + '</select><button class="board-from-project">Create Board</button></li>'
  

  
setGlitchStatus = (status) ->
  $( "#glitch-api-status" ).html("<p>" + status + "</p>")
  
  
glitchError = (error) ->
  setTimeout(
    () ->
      setGlitchStatus "Error: Project not found"
      console.log(error)
    , 300
  )


$( "#glitch-project-submit" ).click( (e) ->
  e.preventDefault()
  setGlitchStatus "Loading . . ."
  projectName = $( "#glitch-project-name" ).val()
  $( "#glitch-project-name" ).val("")
  $.get(glitchApiUrl + "projects/" + projectName, (pData) ->
    if pData && pData.id
      glitchUserId = pData.users[0].id
      $.get(glitchApiUrl + "users/" + glitchUserId, (uData) ->
        if uData && uData.id
          projects = uData.projects
          projectsList project for project in projects
        else
          glitchError uData
      )
    else
      glitchError pData
  )
)

$( "#glitch-projects" ).on("click", ".board-from-project", (e) ->
  e.preventDefault()
  color = $( this ).prev().val()
  boardName = $( this ).prev().prev().prev().html()
  console.log("Color: " + color)
  console.log("Board Name: " + boardName)
  createBoard(boardName, color)
)

createBoard = (boardName, color) ->
  $.get(apiUrl + "?boardName=" + boardName + "&color=" + color, (data) ->
    if data.success
      clearTimeout(alertTimeout)
      $( "#alert-container" ).hide()
      console.log("Board created:")
      console.log(data.boardName + ": " + data.boardUrl)
      boardHTML = '<div class="board-color ' + data.boardColor + '"></div>' + data.boardName + ': <a href="' + data.boardUrl + '">' + data.boardUrl.substring(8, data.boardUrl.length) + '</a>'
      $( "#created-boards-list" ).append(
        '<li>' + boardHTML + '</li>'
      )
      $( "#created-boards" ).show()
      $( "#alert > .message ").html(boardHTML)
      $( "#alert-container" ).show()
      alertTimeout = setTimeout(
        () ->
          $( "#alert-container" ).hide()
        , 3000
      )
    else
      console.log("Error")
      console.log(data.error)
  )




$( "#create-board-submit" ).click( (e) ->
  e.preventDefault()
  boardName = $( "#boardName" ).val()
  $( "#boardName" ).val("")
  color = $( "#create-board-form > .background-color" ).val()
  $( "#create-board-form > .background-color" ).val("")
  console.log(color)
  createBoard(boardName, color)

)