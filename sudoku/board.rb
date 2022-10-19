class Board 
    TEST_HASH = {
        1 = 1,
        2 = 1,
        3 = 1,
        4 = 1,
        5 = 1,
        6 = 1,
        7 = 1,
        8 = 1,
        9 = 1
        }


    def self.from_file(file_path)
        arr = []

        File.open(file_path).each do |line|
            row_arr = Array.new
            line.each do |num|
                row_arr << Tile.new(num)
            end
            arr << row_arr
        end

        arr
   
    end

    def initialize(file_path)
        @grid = self.from_file(file_path)
    end

    def position(arr, value)
        row = arr[0]
        col = arr[1]
        @grid[row][col] = value
    end

    def render
        @grid.each do |row|
            puts row
        end
    end

    def rows_solved?(grid)

        grid.each do |row|
            row_hash = Hash.new(0)
            row.each do |tile|
                row_hash[tile.value] += 1
            end
            return false if row_hash != TEST_HASH
        end

        true
    end

    def cols_solved?
        rows_solved?(@grid.tranpose)
    end

    def three_solved?
        sub_grids = make_sub_grids
        sub_grids.all? do |hash|
            hash == TEST_HASH
        end
    end

    def make_sub_grid(row_range, col_range)
        row_start, row_end = row_range
        col_start, col_end = col_range
        three_hash = Hash.new(0)
        (row_start..row_end).each do |ri|
            (col_start..col_end).each do |ci|
                three_hash[@grid[ri][ci]] += 1
            end
        end

        return three_hash
                
    end


    def make_sub_grids
        sub_grids = Array.new
        i = 0
        while i < 9
            j = 0
            sub2 = Array.new
            while j < 9
                row_range = [i, i + 2]
                col_range = [j, j + 2]
                sub_grids << make_sub_grid(row_range, col_range)
                j += 3
            end
            i += 3
        end
        return sub_grids
    end

    def solved?
        rows_solved?(@grid) && cols_solved? && three_solved?
    end


end