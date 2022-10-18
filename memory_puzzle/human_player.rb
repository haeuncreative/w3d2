class HumanPlayer
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def get_input
        puts "#{@name}, please enter a position :)"
        input = gets.chomp.split(" ").map(&:to_i)
        unless input.length == 2
            puts 'invalid input :( try again'
            input = gets.chomp.split(" ").map(&:to_i)
        end
        return input
    end 

end
