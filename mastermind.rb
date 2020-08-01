class Mastermind

  def initialize
    puts "Welcome to Mastermind!"
    @colors = ["RED", "YELLOW", "BLUE", "GREEN", "WHITE", "BLACK"]
    @probable_color = []
    @human = false
    @victory = false
    ask_role
  end

  def ask_role
    puts "Would you like to play as the Code Maker or Code Breaker?\n1: Code Maker\n2: Code Breaker\nPress 1 or 2 to choose:\n"
    role = gets.chomp
    if role == "1"
      puts "Ok! You are going to be the Code Maker!\nThere are 6 colors to choose from: RED, YELLOW, BLUE, GREEN, WHITE and BLACK.\nType 4 colors to be the code, one at a time:\n"
      create_code
      set_board
      draw_board
      ai_guess_code
    elsif role == "2"
      puts "\nOk! You are going to be the Code Breaker!\nThere are 6 colors to choose from: RED, YELLOW, BLUE, GREEN, WHITE and BLACK.
      \nTo guess you must type the name of the color you want.\nIf you guess the right colors in the 4 spaces of the code, you win!
      \nAfter you guess all the colors, the Code Maker will give you feedback.\nIf you get both the color and the position right it will put an \"X\" on the left."
      puts "If you guess the color right but in the wrong position it will put an \"O\".\nIf you don't get any color right it will stay blank.\nBeware: They will not necessarily appear in order!\n\n"
      @human = true
      set_board
      draw_board
      generate_code
      guess_code
    else
      puts "Input a valid number!"
      ask_role
    end
  end

  def set_board
    @tip_element = []
    48.times { @tip_element << " " }
    @code_element = []
    48.times { @code_element << "   " }
    @turn = 1
  end

  def draw_board
    puts "-----------MASTERMIND------------"
    i = 0
    12.times {
      puts "[#{@tip_element[0+i]}][#{@tip_element[1+i]}][#{@tip_element[2+i]}][#{@tip_element[3+i]}] (#{@code_element[0+i]})(#{@code_element[1+i]})(#{@code_element[2+i]})(#{@code_element[3+i]})"
      i += 4
    }
  end

  def generate_code
    @code = []
    4.times { @code << @colors.sample }
  end

  def create_code
    @code = []
    chosen_color = ""
    i = 4
    while i > 0
      chosen_color = gets.chomp.upcase
      if @colors.any? { |color| color == chosen_color }
        @code << chosen_color
        puts "Code: #{@code}"
        i -= 1
      else
        puts "Invalid color name! Type a valid color!"
      end
    end
  end

  def guess_code
    i = 0
    @turn_guesses = []
    @guess_feedback = []
    while @turn < 13 && @victory == false
      puts "Type the color you want to guess:\n"
      guessed_color = gets.chomp.upcase
      case guessed_color
      when "RED"
        @code_element[i] = "RED"
        @turn_guesses << "RED"
        draw_board
      when "YELLOW"
        @code_element[i] = "YEL"
        @turn_guesses << "YELLOW"
        draw_board
      when "BLUE"
        @code_element[i] = "BLU"
        @turn_guesses << "BLUE"
        draw_board
      when "GREEN"
        @code_element[i] = "GRE"
        @turn_guesses << "GREEN"
        draw_board
      when "WHITE"
        @code_element[i] = "WHI"
        @turn_guesses << "WHITE"
        draw_board
      when "BLACK"
        @code_element[i] = "BLA"
        @turn_guesses << "BLACK"
        draw_board
      else
        puts "Type a valid color name!"
        i -= 1
      end
      i += 1
      if i % 4 == 0
        check_for_correct_guesses
        draw_board
        check_for_code_break
      end
    end
    if @victory == false
      puts "\nYou failed to break the code!\n\nThe code was: #{@code}\n\n"
    end
  end

  def ai_guess_code
    i = 0
    @turn_guesses = []
    @guess_feedback = []
    last_guess = []
    while @turn < 13 && @victory == false
      if @probable_color.size > 0
        chance = rand(2)
        if chance > 0
          guessed_color = @probable_color.sample
        else
          guessed_color = @colors.sample
        end
      else
        guessed_color = @colors.sample
      end
      case guessed_color
      when "RED"
        @code_element[i] = "RED"
        @turn_guesses << "RED"
        draw_board
      when "YELLOW"
        @code_element[i] = "YEL"
        @turn_guesses << "YELLOW"
        draw_board
      when "BLUE"
        @code_element[i] = "BLU"
        @turn_guesses << "BLUE"
        draw_board
      when "GREEN"
        @code_element[i] = "GRE"
        @turn_guesses << "GREEN"
        draw_board
      when "WHITE"
        @code_element[i] = "WHI"
        @turn_guesses << "WHITE"
        draw_board
      when "BLACK"
        @code_element[i] = "BLA"
        @turn_guesses << "BLACK"
        draw_board
      end
      i += 1
      if i % 4 == 0
        last_guess = @turn_guesses
        check_for_correct_guesses
        draw_board
        check_for_code_break
      end
    end
    if @victory == false
      puts "\nThe AI failed to break the code!\n\nYour code was: #{@code}\n\n"
    end
  end

  def check_for_correct_guesses
    temp_code_array = @code.map(&:clone)
    temp_turn_guesses_array = @turn_guesses.map(&:clone)
    @code.each_index { |i|
      if @code[i] == @turn_guesses[i]
        @guess_feedback << "X"
        temp_code_array[i] = " "
        temp_turn_guesses_array[i] = " "
      end
    }
    temp_code_array.each { |el|
      temp_turn_guesses_array.each_with_index { |el2, idx|
        if el == el2 && el != " "
          @guess_feedback << "O"
          @probable_color << el2
          temp_turn_guesses_array.delete_at(idx)
        end
      }
    }
    while @guess_feedback.length < 4
      @guess_feedback << " "
    end
    first_tip_element_of_row = @turn*4-4
    i = 0
    4.times {
      @tip_element[first_tip_element_of_row+i] = @guess_feedback[i]
      i += 1
    }
  end

  def check_for_code_break
    right_guesses = 0
    @guess_feedback.each { |el|
      if el == "X"
        right_guesses += 1
      end
    }
    if right_guesses > 3 && @human == true
      puts "\nYou broke the code! You win!\n\n"
      @victory = true
    elsif right_guesses > 3 && @human == false
      puts "\nThe AI broke the code! You lose!\n\n"
      @victory = true
    else
      @turn_guesses = []
      @guess_feedback = []
      @turn += 1
    end
  end
end

Mastermind.new