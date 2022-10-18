require_relative './human_player.rb'
require_relative './computer_player.rb'
require_relative './board.rb'


class Game
    attr_reader :current_player, :board
   
    def initialize(length, num_bots, *players)
        @previous_guess
        @current_guess

        @board = Board.new(length)
        @board.populate

        @players = Array.new() 
        players.each do |player|
            @players << HumanPlayer.new(player)
        end
        make_robos(num_bots)

        @scores = Hash.new(0)
    end

    def make_robos(num_bots)
        
        (0...num_bots).each do |i|
            @players << ComputerPlayer.new("BOT #{i}", @board.length)
        end
    end

    def play_game
        
        while !@board.won?
            system('clear')
            play_round
            switch_turn
        end
        

        sorted_scores = @scores.sort_by {|k, v| v}
        max_score = sorted_scores[-1][-1]
        winners = @scores.select {|key, val| val == max_score}
        winner_names = winners.keys.map {|winner| winner.name}
        winner_names.each do |winner|
            puts "#{winner} wins!"
        end
       

    end


    def play_round
        @board.render

        1.times do 
            first_guess = current_player.get_input  
            redo if !@board.valid_play?(first_guess)
            @previous_guess = first_guess
        end
        
        system("clear")
        char_1 = @board.reveal(@previous_guess)
        @board.render

        1.times do 
            second_guess = current_player.get_input
            redo if !@board.valid_play?(second_guess)
            @current_guess = second_guess
        end

        system("clear")
        char_2 = @board.reveal(@current_guess)
        @board.render
        sleep(1)

        if current_player.instance_of?(ComputerPlayer)
            current_player.add_memory(char_1, char_2, @previous_guess, @current_guess)
        end

        if make_guess(@previous_guess, @current_guess)
            puts 'correct guess!'
            @scores[current_player] += 1
            puts @scores
        else
            puts 'incorrect guess >:('
            @board.hide(@previous_guess)
            @board.hide(@current_guess)
        end

        @previous_guess = ""
        @current_guess = ""
    end

    def current_player
        @players[0]
    end

    def switch_turn
        last = @players.shift
        @players << last
        
    end

    def make_guess(card_one, card_two)
        @board[card_one] == @board[card_two]
    end

    

end