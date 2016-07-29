# SnakeAndLadder

This gem comprises the 'Snake and Ladder' in a terminal version.
Totally playable from the terminal between multiple people. The game does not end until all the players have completed the game.

Board configuration can be custom set by the players, it is explained below.

Enjoy!

## Installation

Download the gemfile and execute the command below:


    $ gem install snake_and_ladder

## Usage

### Creating game board
  The board configuration should be stored in `config.json`. The file should reside in the same directory as from where you are running the game. If the file is not found, default configuration will be used. The file is pretty self explanatory. First you define the total cells, then two arrays for snake and ladder each. Each array contains entries for each snake and ladder.

  While defining a snake, make sure the position of head of the snake is greater than the tail of the snake. This has been made so that to justify the fact that snakes gets you down to a lower level.

  Sample config file is shown below
  ```json
  {
    "total_cells": "100",
    "snakes" : [
      {
        "head": "10",
        "tail": "5"
      }
    ],
    "ladders": [
      {
        "start": "20",
        "end" : "30"
      }
    ]
  }
  ```

  If a game config is not found then the user will be asked to create a board on runtime, this board will not be saved.
  
### Running the game
You can execute the game from terminal using

    $ snl

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/manuraj17/snake_and_ladder.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
