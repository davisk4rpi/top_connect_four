require 'connect_four'

describe ConnectFour do
	describe "::Player" do

	end

	describe "::Game" do
		game = ConnectFour::Game.new

		describe ".check_adjacent" do
			context "given a coordinate and piece" do
				context "'X', 0 with one adjacent match" do
					it "finds an adjacent match" do
						game.board[1] = "0"
						game.board[11] = "X"
						expect(game.check_adjacent('X', 0)).to match_array([11])
						expect(game.board[-7]).to eql(nil)
					end
				end
				context "'X', 13 with two adjacent matches" do 
					it "finds all adjacent matches" do
						game.board[2] = "O"
						game.board[3] = "O"
						game.board[12] = "X"
						game.board[22] = "X"
						expect(game.check_adjacent("X", 13)).to match_array([12, 22])
						expect(game.board[4]).to eql(" ")
					end
				end
			end
		end

		describe ".try_everything" do 
			context "given the coordinate, and match" do
				context "11, 22" do
					it "is a match" do
						game.board[0] = 'X'
						game.board[11] = 'X'
						game.board[22] = 'X'
						game.board[33] = 'X'
						expect(game.try_everything(11, 22)).not_to be false
					end
				end
			end
		end

		describe ".four" do
			context "given an array" do 
				context "[['X','X','X','X'],['X','X','X','O'],['X','X','O','O']]" do
					it "returns true" do
						expect(game.four([['X','X','X','X'],['X','X','X','O'],['X','X','O','O']])).to be true
					end
				end
				context "[['O','X','X','X'],['X','X','X','O'],['X','X','O','O']]" do
					it "returns true" do
						expect(game.four([['O','X','X','X'],['X','X','X','O'],['X','X','O','O']])).to be false
					end
				end
			end
		end
	end

	describe "::GameBoard" do
		board = ConnectFour::GameBoard.new

		describe ".initialize" do
			context "board.size should = 42" do
				it "returns 42" do
					expect(board.board.length).to eql(42)
				end
			end
			context "board[13] == ' '" do 
				it "returns ' '" do 
					expect(board.board[13]).to eql(" ")
				end
			end
		end

		describe ".view" do
			context "display the game board" do
				context "an empty board" do
					it "displays an empty board" do
						expect(board.view).to eql("| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |")
					end
				end
				context "first row full" do
					it "displays a full first row" do
						board.board[0] = "X"
						board.board[1] = "O"
						board.board[2] = "O"
						board.board[3] = "O"
						board.board[4] = "X"
						board.board[5] = "X"
						board.board[6] = "X"
						expect(board.view).to eql("| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n|X|O|O|O|X|X|X|")
					end
				end
			end
		end
	end
end