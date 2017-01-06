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
			@game = GameBoard.new
			@board = @game.board
			@turn = 0
			system "clear" or system "cls"
			introduction
		end

		def introduction
			puts "Welcome to Connect Four. You know the rules, choose a column to place your piece. \nPlayer 1 will start."
			next_turn
		end

		def next_turn
			return game_over if @turn == 42
			@turn += 1
			active_turn(@player1) if @turn % 2 == 1
			active_turn(@player2) if @turn % 2 == 0
		end

		def active_turn(player)
			puts " "
			puts @game.view
			puts "#{player.name} please choose a column (0-6)"
			column = gets.chomp
			column = numberize(column, player)
			coordinate = find_coordinate(column)
			@board[coordinate] = player.piece
			matches = check_adjacent(player.piece, coordinate)
			unless matches.length == 0
				matches.each { | match | try_everything(coordinate, match)}
			end
			next_turn
		end

		def numberize(column, player)
			return column.to_i if ['0','1','2','3','4','5','6'].include? column
			puts "\nChoose a number between 0 and 6!"
			active_turn(player)
		end

		def find_coordinate(column)
			array = [column, column+10, column+20, column+30, column+40, column+50]
			array.select! { | each | @board[each] == " "}
			return array[0]
		end

		def four(array)
			array.each { | array | return true if array.all?{ | each | each == array[0] } }
			return false
		end

		def check_adjacent(marker, coordinate)
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
			puts @game.view
			puts "Looks like we have a winner!"
			play_again?
		end

		def game_over
			puts "You both suck!"
			play_again?
		end

		def play_again?
			puts  "Want to play again?(y to start over, anything else to exit)"
			Game.new if gets.chomp == 'y'
			exit
		end
	end

	class GameBoard

		attr_accessor :board

		def initialize
			@coordinates = [0,1,2,3,4,5,6,10,11,12,13,14,15,16,20,21,22,23,24,25,26,30,31,32,33,34,35,36,40,41,42,43,44,45,46,50,51,52,53,54,55,56]
			@board = board_hash
		end

		def view
			first_row = "|"
			second_row = "|"
			third_row = "|"
			fourth_row = "|"
			fifth_row = "|"
			sixth_row = "|"
			count = 0
			@board.each do | key, value |
				first_row += "#{value}|" if count < 7
				second_row += "#{value}|" if (count >= 7 && count < 14)
				third_row += "#{value}|" if (count >= 14 && count < 21)
				fourth_row += "#{value}|" if (count >= 21 && count < 28)
				fifth_row += "#{value}|" if (count >= 28 && count < 35)
				sixth_row += "#{value}|" if (count >= 35 && count < 42)
				count += 1
			end
			grid =  " 0 1 2 3 4 5 6\n#{sixth_row}\n#{fifth_row}\n#{fourth_row}\n#{third_row}\n#{second_row}\n#{first_row}"
			return grid
		end

		def board_hash
			board = {}
			@coordinates.each { | key | board[key] = " " }
			return board
		end

	end

end

ConnectFour::Game.new