require_relative "./player.rb"
require_relative "./gameboard.rb"
require_relative "./game_engine.rb"


game = GameEngine.new({game_board: GameBoard.new(), player1: Player.new, player2: Player.new})

game.play

