require_relative './board.rb'

class ComputerPlayer
    attr_reader :name
    
    def initialize(name, length)
        @name = name
        @memory = Hash.new {|h,k| h[k] = Array.new}
        @length = length
        @first_input
        @second_input
        @queued_answer = []
    end

    # def get_input
    #     puts "#{@name}, please enter a position :)"
    #     input = gets.chomp.split(" ").map(&:to_i)
    #     unless input.length == 2
    #         puts 'invalid input :( try again'
    #         input = gets.chomp.split(" ").map(&:to_i)
    #     end
    #     return input
    # end

    def get_input
        known_pairs = @memory.select { |k, v| v.length > 1}

        @memory.delete_if { |k, v| v.length > 1}
        
        if @queued_answer.length == 1
            return @queued_answer.pop()
        elsif known_pairs.length > 0 # @memory.has_value? {|v| v.length == 2}
            known_keys = known_pairs.keys.to_a
            random_key = known_keys.sample
            # random_guess = known_pairs[random_key]
            @queued_answer = known_pairs[random_key]
            return @queued_answer.pop()
        else
            row = [*0...@length].sample
            col = [*0...@length].sample
            return [row, col]
        end
    end

    def add_memory(char_1, char_2, guess1, guess2)
        @memory[char_1] << guess1 if !@memory[char_1].include?(guess1) 
        @memory[char_2] << guess2 if !@memory[char_2].include?(guess2)
    end

end
