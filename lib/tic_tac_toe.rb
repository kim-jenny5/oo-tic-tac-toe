require 'pry'

class TicTacToe
    def initialize
        @board = [" ", " ", " " , " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8], [0,4,8],
        [2,4,6], [0,3,6], [1,4,7], [2,5,8]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "------------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "------------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i-1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O" ? true : false
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8) ? true : false
    end

    def turn_count
        @board.count {|position| position == "X" || position == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please specify a position between 1-9."
        input = gets.chomp
        input_int = input_to_index(input)
        if valid_move?(input_int)
            move(input_int, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]] == @board[win_combo[2]] && position_taken?(win_combo[0])
        end
    end

    def full?
        @board.all? {|position| position != " "}
    end

    def draw?
        full? && !won? ? true : false
    end

    def over?
        if draw? || won?
            true
        end
    end

    def winner
        won? ? @board[won?[0]] : nil
        # if won
        # return won?
    end

    def play
        turn until over?

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

    
end