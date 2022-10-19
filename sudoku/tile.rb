class Tile


    def initialize(value, given)
        @value = value
        @given = given
    end

    def to_s
        if @given
            return @value.to_s
        else
            return "_"
        end
    end



end