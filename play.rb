class Hangman

    def initialize
        @word = words.sample
        @lives = 7
        @word_teaser = ""

        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    def words
        [
            ["cricket", "A game played by gentlemen"],
            ["jogging", "We are not walking"],
            ["celebrate", "Remembering special moments"],
            ["continent", "Thare are 7 of these"],
            ["exotic", "Not from around here"],
        ]
    end

    def print_teaser last_guess = nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end
 
    def update_teaser last_guess
        new_teaser = @word_teaser.split

        new_teaser.each_with_index do |letter, index|
            # Replace blank values with letters if guessed letter matches to the word
            if letter == '_' && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end
        end

        @word_teaser = new_teaser.join(' ')
    end

    def make_guess
        if @lives > 0
            puts "Enter a letter"
            guess = gets.chomp

            good_guess = @word.first.include? guess

            if guess == "exit"
                puts "Thank you for playing!"

            elsif good_guess
                puts "You are correct!"

                print_teaser guess

                if @word.first == @word_teaser.split.join
                    puts "Congratulations... you have won this round!"
                else
                    make_guess
                end
            else
                @lives -= 1
                puts "Incorrect.. you have #{ @lives } lives left. Try again"
                make_guess
            end
        else
            puts "Game over...Better luck next time!"
        end
    end 

    def begin
        # Ask user for a letter
        puts "New game started... your word has #{ @word.first.size } characters"
        puts "To exit type 'exit'"
        print_teaser

        puts "Clue: #{ @word.last }"

        make_guess
    end
    
end

game = Hangman.new
game.begin