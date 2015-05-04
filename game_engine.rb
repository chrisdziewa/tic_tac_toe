class GameEngine
    attr_reader :game_board, :player1, :player2
    attr_accessor :current_player
    def initialize(params)
        @game_board = params[:game_board]
        puts intro
        @player1 = params[:player1]
        @player2 = params[:player2]
        add_players
        @current_player = @player1
        @winning_combinations =
            [
                [:a1,:a2,:a3], [:b1,:b2,:b3],
                [:c1,:c2,:c3], [:a1,:b1,:c1],
                [:a2,:b2,:c2], [:a3,:b3,:c3],
                [:a1,:b2,:c3], [:a3,:b2,:c1]
            ]
            @game_over = false
            @draw = true
    end

    def intro
        <<-INTRO
================================================================

Hello, and welcome to my Tic-Tac-Toe game!
The rules are simple. The game consists of two
players-each of which has an 'X' or an 'O' for a marker.
Players alternate turns, filling in the 3 X 3 grid until
either one of the players has 3 of their marker in a row
or there are no more places left. Winning combinations
include: vertical, horizontal, and diagonal.

================================================================
INTRO
    end

    def empty_name?(player)
        player.name.nil? || player.name == ""
    end

    def display_board
        @game_board.show
    end

    def choose_square
        puts "Please choose an open and valid square:"
        square = request_square
        until @game_board.valid_square?(square) do
            display_board
            puts "Invalid, please choose an open and valid square:"
            square = request_square
        end
        square
    end

    def play
        sleep 2
        system("clear")
        display_board
        until @game_board.board_filled_up? do
            puts "#{@current_player.name}, it's your turn, you are #{@current_player.marker}'s!"
            puts ""

            square = choose_square
            marker = @current_player.marker
            @game_board.mark_square(square, marker)

            check_for_winner

            change_turn
            system ("clear")
            display_board
        end
        end_game
    end

    private

    def add_players
        add_player_markers
        number = 1
        [@player1, @player2].each do |player|
            puts "Player #{number}, please enter your name:"
            add_player_name(player)
            puts "Thanks #{player.name}, your marker will be #{player.marker}"
            puts ""
            number += 1
        end
    end

    def add_player_name(player)
        while empty_name?(player)
            name = gets.chomp
            player.name = name
            if empty_name?(player)
                puts "Please enter in a valid name:"
            end
        end
    end

    def add_player_markers
        @player1.marker = (["X", "0"].shuffle)[0]
        @player2.marker = @player1.marker == "X" ? "O" : "X"
    end

    def change_turn
        @current_player = (@current_player == @player1) ? @player2 : @player1
    end

    def request_square
        square = gets.chomp.to_sym
    end

    def reset
        @game_board.reset
        @current_player = @player1
        @draw = true
        intro
        play
    end

    def end_with_draw_check
        if @draw
            puts "================================================================"
            puts "Looks like you were equally matched! The game ended in a draw.."
            puts "================================================================"
        end
    end

    def check_for_winner
        @winning_combinations.each do |combination|
            index = 0
            current_marker_count = 0
            while index < combination.length
                if @game_board.squares[combination[index]] == @current_player.marker
                    current_marker_count += 1
                end
                if current_marker_count >= 3
                    display_board
                    @draw = false
                    puts "============================================================"
                    puts "#{@current_player.name} Wins!!!!!!"
                    puts "============================================================"
                    end_game
                end
                index += 1
            end
        end
    end

    def end_game
        end_with_draw_check
        puts "Would you like to play again? (y/n)"
        response = ""
        until response.downcase == "y" || response.downcase == "n" do
            response = gets.chomp
            if response.downcase == "y"
                puts "Alright! Here we go again!"
                reset
            elsif response.downcase == "n"
                puts "Alright, thanks for playing!"
                exit
            else
                puts "Type 'y' to play again or 'n' to exit"
            end
        end
    end
end