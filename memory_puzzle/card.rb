class Card
    attr_reader :face_value, :face_pos
    
    def initialize(face_value)
        @face_value = face_value
        @face_pos = false
    end
    
    def == (card)
        if @face_value == card.face_value
            return true
        else
            return false
        end        
    end
    
    def hide
        if @face_pos == true
            @face_pos = false
        end
    end

    def reveal
        if @face_pos == false
            @face_pos = true
            @face_value
        end 
    end

    def to_s
        if @face_pos 
            return @face_value
        else
            return '_'
        end
    end


end