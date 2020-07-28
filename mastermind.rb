class Mastermind
  # attr_reader :name
  # attr_accessor :wins

  def initialize
    puts "Welcome to Mastermind!"
    ask_role
    set_board
    draw_board
    generate_code
    guess_code
  end

  def ask_role
    puts "Would you like to play as the Code Maker or Code Breaker?\n1: Code Maker\n2: Code Breaker\nPress 1 or 2 to choose:\n"
    role = gets.chomp
    if role == "1"
      puts "Ok! You are going to be the Code Maker!"
    elsif role == "2"
      puts "Ok! You are going to be the Code Breaker!\nThere are 6 colors to choose from: RED, YELLOW, BLUE, GREEN, WHITE and BLACK.
      \nTo guess you must type the name of the color you want. If you guess the right colors in the 4 spaces of the code, you win!
      \nAfter you guess all the colors, the Code Maker will give you feedback.\nIf you get the color and the position right it will put a R on the left."
      puts "If you guess the color right but the wrong position it will put a W.\nIf you don't get any color right it will stay blank.\n\n"
    else
      puts "Input a valid number!"
      ask_role
    end
  end

  def set_board
    @code_element = []
    48.times { @code_element << " " }
    @turn = 1
  end

  def draw_board
    puts "-------MASTERMIND--------"
    puts "[ ][ ][ ][ ] (#{@code_element[0]})(#{@code_element[1]})(#{@code_element[2]})(#{@code_element[3]})"
    puts "[ ][ ][ ][ ] (#{@code_element[4]})(#{@code_element[5]})(#{@code_element[6]})(#{@code_element[7]})"
    puts "[ ][ ][ ][ ] (#{@code_element[8]})(#{@code_element[9]})(#{@code_element[10]})(#{@code_element[11]})"
    puts "[ ][ ][ ][ ] (#{@code_element[12]})(#{@code_element[13]})(#{@code_element[14]})(#{@code_element[15]})"
    puts "[ ][ ][ ][ ] (#{@code_element[16]})(#{@code_element[17]})(#{@code_element[18]})(#{@code_element[19]})"
    puts "[ ][ ][ ][ ] (#{@code_element[20]})(#{@code_element[21]})(#{@code_element[22]})(#{@code_element[23]})"
    puts "[ ][ ][ ][ ] (#{@code_element[24]})(#{@code_element[25]})(#{@code_element[26]})(#{@code_element[27]})"
    puts "[ ][ ][ ][ ] (#{@code_element[28]})(#{@code_element[29]})(#{@code_element[30]})(#{@code_element[31]})"
    puts "[ ][ ][ ][ ] (#{@code_element[32]})(#{@code_element[33]})(#{@code_element[34]})(#{@code_element[35]})"
    puts "[ ][ ][ ][ ] (#{@code_element[36]})(#{@code_element[37]})(#{@code_element[38]})(#{@code_element[39]})"
    puts "[ ][ ][ ][ ] (#{@code_element[40]})(#{@code_element[41]})(#{@code_element[42]})(#{@code_element[43]})"
    puts "[ ][ ][ ][ ] (#{@code_element[44]})(#{@code_element[45]})(#{@code_element[46]})(#{@code_element[47]})"
    # i = 0
    # 12.times {
    #   puts "[ ][ ][ ][ ] (#{@code_element[0+i]})(#{@code_element[1+i]})(#{@code_element[2+i]})(#{@code_element[3+i]})"
    #   i = 4
    # }
  end

  def generate_code
    colors = ["RED", "YELLOW", "BLUE", "GREEN", "WHITE", "BLACK"]
    @code = []
    4.times { @code << colors.sample }
  end

  def guess_code
    puts "Type the color you want to guess:\n"
    i = 0
    @every_4_guesses = []
    @guess_feedback = []
    48.times {
      guessed_color = gets.chomp.upcase
      case guessed_color
      when "RED"
        @code_element[i] = "R"
        @every_4_guesses << "RED"
        guess_feedback(guessed_color)
        draw_board
      when "YELLOW"
        @code_element[i] = "Y"
        @every_4_guesses << "YELLOW"
        guess_feedback(guessed_color)
        draw_board
      when "BLUE"
        @code_element[i] = "B"
        @every_4_guesses << "BLUE"
        guess_feedback(guessed_color)
        draw_board
      when "GREEN"
        @code_element[i] = "G"
        @every_4_guesses << "GREEN"
        guess_feedback(guessed_color)
        draw_board
      when "WHITE"
        @code_element[i] = "W"
        @every_4_guesses << "WHITE"
        guess_feedback(guessed_color)
        draw_board
      when "BLACK"
        @code_element[i] = "B"
        @every_4_guesses << "BLACK"
        guess_feedback(guessed_color)
        draw_board
      else
        puts "Type a valid color name!"
      end
      puts "Code: #{@code}"
      puts "Board Array Element: #{i}"
      puts "Guesses: #{@every_4_guesses}"
      puts "Guess Feedback: #{@guess_feedback}"
      puts "Turn: #{@turn}"
      i += 1
      if i % 4 == 0
        @every_4_guesses = []
        @guess_feedback = []
        @turn += 1
      end
    }
  end

  def guess_feedback(guessed_color)
    if @code[@every_4_guesses.length - 1] == @every_4_guesses[@every_4_guesses.length - 1]
      @guess_feedback << "R"
    else
      @code.each { |el|
        if el == @every_4_guesses[@every_4_guesses.length - 1]
          @guess_feedback << "W"
          break
        end
      }
    end
  end
end

Mastermind.new