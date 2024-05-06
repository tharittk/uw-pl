# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_MyPieces = All_Pieces + 
               [rotations([[0, 0], [1, 0], [2, 0], [0, 1], [1, 1]]), # whale
               [[[0, 0],[-1, 0],[-2, 0], [1, 0], [2, 0]], # long 5 (only needs two)
               [[0, 0], [0, -1], [0, -2], [0, 1], [0, 2]]],
               rotations([[0, 0], [1, 0], [0, 1]])] # chevron
  # your enhancements here
  def initialize (point_array, board)
    super(point_array, board)
  end

  def self.next_piece (board)
    MyPiece.new(All_MyPieces.sample, board)
  end

  def self.next_cheat_piece (board)
    MyPiece.new([[[0,1]]], board)
  end

end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @is_cheating = false
  end

  def is_cheating
    @is_cheating
  end

  # gets the next piece
  def next_piece
    if is_cheating
      @current_block = MyPiece.next_cheat_piece(self)
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
    @is_cheating = false
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def activate_cheat
    if @score >= 100 and not is_cheating
      @is_cheating = true
      @score -= 100
    end
  end

end

class MyTetris < Tetris
  # your enhancements here
  def initialize
    super
  end

  def key_bindings
    super
    @root.bind('u', proc {
      @board.rotate_clockwise
      @board.rotate_clockwise
    })
    @root.bind('c',  proc {
      @board.activate_cheat
    })
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end  
end


