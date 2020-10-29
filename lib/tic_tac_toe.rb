require 'pry'

class TicTacToe 

    attr_accessor :board, :index_input, :move

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize 
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        @index_input = string.to_i - 1
    end

    def move(board_index, token = "X")
        @board[board_index] = token 
    end

    def position_taken?(index)
        @board[index] != " " 
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count 
        @board.count{|i| i == "X" || i == "O"}
    end

    def current_player 
        turn_count.even? ? "X" : "O"
    end

    def turn
      index = input_to_index(gets.chomp)
      if valid_move?(index)
        move(index, current_player)
        display_board
      else 
        turn
      end
    end

    def won? 
        result = nil 
        WIN_COMBINATIONS.each do |combo|
          index_zero = combo[0]
          index_one = combo[1]
          index_two = combo[2]
      
          space_one = @board[index_zero]
          space_two = @board[index_one]
          space_three = @board[index_two]
      
          if space_one == "X" && space_two == "X" && space_three == "X" || space_one == "O" && space_two == "O" && space_three == "O" 
            result = combo 
          else 
            result 
          end
        end
        result      
    end

    def full? 
        !@board.include?(" ")
    end

    def draw? 
        # full board && no winner return true
        # there is a winner return false
        # not full board && no winner return false 
        if full? == true && won? == nil 
            true
        elsif won? != nil || full? == false && won? == nil
            false
        end
    end

    def over? 
        # board full || game won return true 
        # Hint: testing to see if draw? == true 
        draw? == true || won? != nil
    end

    def winner
    #    binding.pry 
      won? != nil ? @board[won?.first] : won?
    end

    def play 
        display_board

        until over? == true do
            turn
        end

        if won? != nil
            puts "Congratulations #{winner}!"
        elsif draw? == true 
            puts "Cat's Game!"
        end
    
    end



end
