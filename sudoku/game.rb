class Game

    def initialize(file_path)
        @board = Board.new(file_path)
    end

    def play
        while !@board.solved?
            @board.render
            puts "Please enter two numbers with a space in between, i.e., 5 4"
            input = gets.chomp
            position = input.split(" ") 
            @board.position(position)
        end


    end
         


end
