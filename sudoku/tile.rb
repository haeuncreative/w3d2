class Tile
    attr_reader :value

    def initialize(value)
        @value = value
        if value == 0
            @given = false
        else
            @given = true
        end
    end

    def to_s
        if @given
            return @value.to_s
        else
            return "_"
        end
    end



end