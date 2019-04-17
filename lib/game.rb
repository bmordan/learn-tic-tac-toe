WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count_plays = Proc.new { |cell| cell == "O" || cell == "X" }
  board.filter(&count_plays).length
end

def current_player(board)
  turns = turn_count(board)
  if turns == 0
    "X"
  else
    turns % 2 == 0 ? "X" : "O"
  end
end

def position_taken?(board, index)
  !board[index].is_a? Integer
end

def won?(board)
  winning_combo = WIN_COMBINATIONS
    .filter { |combo|
    combo.all? { |index| position_taken?(board, index) }
  }
    .filter { |combo|
    combo.map { |index| board[index] }.uniq.length == 1
  }

  winning_combo.empty? ? nil : winning_combo.first
end

def full?(board)
  (0..8).to_a.map { |i| position_taken?(board, i) }.all?
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if !won?(board) then return nil end

  winning_combo = WIN_COMBINATIONS
    .filter { |combo|
    combo.all? { |index| position_taken?(board, index) }
  }
    .filter { |combo|
    combo.map { |index| board[index] }.uniq.length == 1
  }
    .first
    .map { |i| board[i] }
    .uniq
    .first
end
