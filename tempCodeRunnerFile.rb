if @code[@every_4_guesses.length - 1] == @every_4_guesses[@every_4_guesses.length - 1]
      @guess_feedback << "R"
    else
      i = 0
      temp_code.each { |el|
        if temp_code[i] == @every_4_guesses[@every_4_guesses.length - 1]
          temp_code.pop()
          @guess_feedback << "W"
          break
        end
        i += 1
      }
    end