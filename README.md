# Glitch to Trello

This project is a first attempt at creating a system for automatically keeping track of Glitch projects in Trello using the Glitch API and the Trello API. If you submit the name of one of your Glitch projects it will create a list of all of your Glitch projects, with the option to create a Trello Board for the project, with a color of your choice. It is written in CoffeeScript and you can [view the source here](https://glitch.com/edit/#!/glitch-to-trello). The boards for this proof of concept are created in the [PatrickWeaverGlitchProjects Team](https://trello.com/patrickweaverglitch) on Trello.

#### You will need to set the following env variables to use the project with your Trello account:

    - TRELLO_API_KEY
    - TRELLO_TOKEN
    - TRELLO_TEAM_ID
