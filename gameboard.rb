class GameBoard 
	attr_reader :squares

	def initialize()
		reset
	end

	def reset 
		@squares = {
					a1: " ", a2: " ", a3: " ",
					b1: " ", b2: " ", b3: " ",
					c1: " ", c2: " ", c3: " "
					}
	end

	def show 
		puts <<-SHOW
	          1   2   3

	 a	| #{@squares[:a1]} | #{@squares[:a2]} | #{@squares[:a3]} |
	      -----------------
	 b	| #{@squares[:b1]} | #{@squares[:b2]} | #{@squares[:b3]} |
	      -----------------
	 c	| #{@squares[:c1]} | #{@squares[:c2]} | #{@squares[:c3]} |
		
		SHOW
	end

	def valid_square?(square)
		has_square?(square) && open_square?(square)
	end

	def mark_square(square, symbol)
		if valid_square?(square)
			@squares[square] = symbol
		end
	end

	def board_filled_up?
		@squares.values.none? {|value| value == " "}
	end

	private

	def has_square?(square)
		@squares.keys.include?(square)
	end

	def open_square?(square) 
		@squares[square] == " "
	end
end