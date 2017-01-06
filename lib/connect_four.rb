module ConnectFour

	class Player

		attr_reader :piece, :name

		def initialize(gamepiece, name)
			@piece = gamepiece
			@name = name
		end
		
	end

	class Game

		attr_accessor :board

		def initialize
			@player1 = Player.new("\u26AA", "Player 1")
			@player2 = Player.new("\u26AB", "Player 2")
			@board = GameBoard.new.board
		end

		def active_turn(player)
			puts "#{player.name} please choose a column (0-6)"
			column = gets.chomp
			column = numberize(column)
			coordinate = find_coordinate(column)
			matches = check_adjacent(player.piece, coordinate)
			unless matches.length == 0
				matches.each { | match | try_everything(coordinate, match)}
			end
			next_turn
		end

		def numberize(column, player)
			return column.to_i if [0,1,2,3,4,5,6].include? column.to_i
			puts "Choose a number between 0 and 6!"
			active_turn(player)
		end

		def find_coordinate(column)
			array = [column, column+10, column+20, column+30, column+40, column+50]
			array.select! { | each | @board[each] == nil}
			return array[0]
		end

		def four(array)
			array.each { | array | return true if array.all?{ | each | each == array[0] } }
			return false
		end

		def check_adjacent(marker, coordinate)
			coordinate
			arr = [coordinate-11, coordinate-10, coordinate-9, coordinate-1, coordinate+1, coordinate+9, coordinate+11]
			arr.select!{ | x | @board[x] == marker }
		end

		def try_everything(coordinate1, coordinate2)
			array = []
			shift = coordinate2 - coordinate1
			array << [@board[coordinate1], @board[coordinate2], @board[coordinate2+shift], @board[coordinate2+shift*2]]
			array << [@board[coordinate1-shift], @board[coordinate1], @board[coordinate2], @board[coordinate2+shift]]
			array << [@board[coordinate1-shift*2], @board[coordinate1-shift], @board[coordinate1], @board[coordinate2]]
			return winner if four(array)
			return false
		end

		def winner
			puts "well that is the game folks, see you later"
		end

	end

	class GameBoard

		attr_accessor :board

		def initialize
			@coordinates = [0,1,2,3,4,5,6,10,11,12,13,14,15,16,20,21,22,23,24,25,26,30,31,32,33,34,35,36,40,41,42,43,44,45,46,50,51,52,53,54,55,56]
			@board = board_hash
		end

		def board_hash
			board = {}
			@coordinates.each { | key | board[key] = nil }
			return board
		end

	end

end