require_relative 'card.rb'

class Board
    attr_reader :length

    def populate
        # Build array of duplicate chars
        alphabet = ("A".."Z").to_a
        population = []
        while population.length < @area
            char = alphabet.sample
            if population.none? { |card| card.face_value  == char}
                2.times { population << Card.new(char) }
            end
        end

        # Populate grid with elements of the array
        population = population.shuffle
        @grid.each_with_index do |row, ri|
            row.each_with_index do |col, ci|
                @grid[ri][ci] = population.pop
            end
        end
    end
    
    def initialize(length)
        @grid = Array.new(length) { Array.new(length) }
        @length = length
        @area = length * length
    end

    def render
        init_row = " "
        (0...@length).each { |i| init_row += i.to_s}
        puts init_row
        @grid.each_with_index do |row, ri| 
            row_string = ri.to_s  
            row.each do |ele|
                row_string += ele.to_s 
            end
            puts row_string
        end
    end

    def won?
        flattened = @grid.flatten
        flattened.none? {|ele| ele.to_s == "_"}
    end

    def valid_play? (pos)
        row, col = pos
        
        if self[pos].face_pos
            return false
        else
            true
        end
    end

    def [] (pos)
        row, col = pos
        @grid[row][col]
    end

    def reveal(pos)
        self[pos].reveal
        return self[pos].face_value
    end

    def hide(pos)
        self[pos].hide
    end

    def reveal_all
        @grid.each do |row|
            row.each do |ele|
                ele.reveal
            end
        end
    end

    def hide_all
        @grid.each do |row|
            row.each do |ele|
                ele.hide
            end
        end
    end
end