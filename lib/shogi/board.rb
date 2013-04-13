module Shogi
  class Board
    DEFAULT_POSITION = [
      ["-KY", "-KE", "-GI", "-KI", "-OU", "-KI", "-GI", "-KE", "-KY"],
      [   "", "-HI",    "",    "",    "",    "",    "", "-KA",    ""],
      ["-FU", "-FU", "-FU", "-FU", "-FU", "-FU", "-FU", "-FU", "-FU"],
      [   "",    "",    "",    "",    "",    "",    "",    "",    ""],
      [   "",    "",    "",    "",    "",    "",    "",    "",    ""],
      [   "",    "",    "",    "",    "",    "",    "",    "",    ""],
      ["+FU", "+FU", "+FU", "+FU", "+FU", "+FU", "+FU", "+FU", "+FU"],
      [   "", "+KA",    "",    "",    "",    "",    "", "+HI",    ""],
      ["+KY", "+KE", "+GI", "+KI", "+OU", "+KI", "+GI", "+KE", "+KY"],
    ]

    def initialize
      @position = DEFAULT_POSITION.dup
      @captured = []
    end

    def to_csa
      @position.map.with_index {|row, i|
        row.map {|cell|
          (cell == "") ? " * " : cell
        }.unshift("P#{i + 1}").join
      }.join("\n") << "\n"
    end

    def to_usi
      @position.map {|row|
        usi_row = ""
        space_count = 0
        row.each do |cell|
          if cell == ""
            space_count += 1
          else
            if space_count > 0
              usi_row << space_count.to_s
              space_count = 0
            end
            usi = eval("Piece::#{cell[1..2]}.new").usi
            if cell[0] == "-"
              usi_row << usi.downcase
            else
              usi_row << usi
            end
          end
        end
        if space_count > 0
          usi_row << space_count.to_s
          space_count = 0
        end
        usi_row
      }.join("/") << "\n"
    end
  end
end
