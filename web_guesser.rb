require 'sinatra'
require 'sinatra/reloader'
	set :SECRET_NUM, rand(100)
	@@counter = 6
	@@secretNumber = settings.SECRET_NUM
	cheats = ""	
get '/' do
	@@counter -= 1
	score = @@counter
    guess = params["guess"].to_i
    cheats = params["cheat"]
    @numberCheck = @@secretNumber
    if cheats == "on"
    	cheats = "The Secret Number is #{@@secretNumber}"
    else
    	cheats = nil
    end
	def check_guess(guess)
		case guess
	  	when @@secretNumber then "Yes! The secret number was #{@@secretNumber}"
	  	when (@@secretNumber+5..Float::INFINITY) then "WAY too high!"
			when (@@secretNumber...100) then "Too high!"
			when (-(Float::INFINITY)..@@secretNumber-5) then "WAY too low!"
			when (0...@@secretNumber) then "Too low!"
			else "error"
	 	end
	end
    message = check_guess(guess)
	def check_message(check)
	    case check
		    when "Yes! The secret number was #{@@secretNumber}" then "#00FF00"
		    when "WAY too high!" then "#FF0000"
		    when "Too high!" then "#FF9999"
		    when "WAY too low!" then "#FF0000"
		    when "Too low!" then "#FF9999"
		    else "#FFFFFF"
	   	end
    end
    background = check_message(message)
    def check_win(check)
    	if check == "Yes! The secret number was #{@@secretNumber}"
    		@@counter = 5
    		score = 5
    		win = "You Win! The Secret Number was #{@@secretNumber}. A new number has been generated."
    		@@secretNumber = rand(100)
    		return win
    	end
    end
    @win = check_win(message)
    def check_lost(check)
    	if check <= 0 && @win != "You Win! The Secret Number was #{@numberCheck}. A new number has been generated."
			@@counter = 5
			score = 5
			lose = "You Lose! Try Again. The Secret Number was #{@@secretNumber}. A new number has been generated."
			@@secretNumber = rand(100)
			return lose
		end
    end
    @lose = check_lost(score)
    erb :index, :locals => {:number => cheats, :message => message, :background => background, :score => score, :win => @win, :lose => @lose}
end
