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
						game.board[2] = "0"
						game.board[3] = "0"
						game.board[12] = "X"
						game.board[22] = "X"
						expect(game.check_adjacent("X", 13)).to match_array([12, 22])
						expect(game.board[4]).to eql(nil)
					end
				end
			end
		end

		describe ".try_everything" do 
			context "given a marker, coordinate, and shift" do
				context "'X', 11, 10" do
					it "is a match" do
						game.board[21] = 'X'
						expect(game.continue_check('X', 11, 10)).to be true
					end
				end
			end
		end

		describe ".four_in_a_row" do
			context "given an array" do 
				context "['X','X','X','X']" do
					it "returns true" do
						expect(game.four(["X","X","X","X"])).to be true
					end
				end
				context "['X','O','X','X']" do
					it "returns true" do
						expect(game.four(["X","O","X","X"])).to be false
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
			context "board[13] == nil" do 
				it "returns nil" do 
					expect(board.board[13]).to eql(nil)
				end
			end
		end
	end


end