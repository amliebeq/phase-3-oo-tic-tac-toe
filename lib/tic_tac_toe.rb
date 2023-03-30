require 'pry'

class TicTacToe
    
    attr_accessor :board    
    
    def initialize(board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '])
        @board = board
    end
    
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

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end 
    
    def input_to_index(str)
        str.to_i - 1
    end
    
    def move(index, token = 'X')
        @board[index] = token
    end
    
    def position_taken?(index)
        @board[index] == ' ' ? false : true
    end
    
    def valid_move?(index)
        @board[index] == ' ' && index.between?(0,8) ? true : false
    end
    
    def turn_count
        count = 0
        @board.each { |i| i != ' ' ? count += 1 : count = count}
        count
    end
    
    def current_player
        turn_count().even? ? 'X' : 'O'             
    end
    
    def turn
        input = gets
        index = input_to_index(input)
        valid = valid_move?(index)
        current = current_player()
        valid == true ? move(index, current) : gets
        display_board()
    end
    
    def won?
        WIN_COMBINATIONS.any? do |combo| 
            if position_taken?(combo[0]) && position_taken?(combo[1]) && position_taken?(combo[2]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end 
        end               
    end
    
    def full?
        board.find {|item| item === " "} != nil ? false : true
    end
    
    def draw?
        full?() == true && won?() == false
    end
    
    def over?
        full?() == true || won?() == true
    end
    
    def winner
        if won?() != false && current_player() == 'X'
            'O'
        elsif won?() != false && current_player() == 'O'
            'X'
        end         
    end
    
    def play
        over?()
        if winner() == 'X'
            puts 'Congratulations X!'
        elsif winner() == 'O'
            puts 'Congratulations O!'
        elsif draw?() == true
            puts "Cat's Game!"
        else
            turn()
        end               
    end
end    