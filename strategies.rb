#! /usr/bin/ruby -w

require 'constants.rb'
require 'strategy.rb'

include Constants

module Strategies

#'nice' strategies

#1
class AlwaysCooperate
	@@desc = "always_coop"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		return MOVE_COOPERATE
	end
end

#2
class Tit4Tat
	@@desc = "tit4t"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		opponent_moves.empty? ? MOVE_COOPERATE : opponent_moves.last
	end
end

#3
class CooperativeAlternator
	@@desc = "coop_alt"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		move = nil
		if opponent_moves.empty?
			move = MOVE_COOPERATE
		else
			move = (@last_move == MOVE_COOPERATE) ? MOVE_DEFECT : MOVE_COOPERATE
		end	
		@last_move = move
	end
end

#4
class CooperativeOpponentCopier
	@@desc = "coop_opp_copy"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		move = nil
		if opponent_moves.empty?
			@move_counts = { MOVE_DEFECT => 0, MOVE_COOPERATE => 0}
			move = MOVE_COOPERATE
		else
			@move_counts[opponent_moves.last] += 1
			
			if @move_counts[MOVE_COOPERATE] >= @move_counts[MOVE_DEFECT]
				opponent_most_common_move = MOVE_COOPERATE
			else
				opponent_most_common_move = MOVE_DEFECT	
			end
			
			move = opponent_most_common_move
		end
		move
	end
end

#5
class MostlyCooperative
	@@desc = "mostly_coop"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		rand_int = rand(100)
		
		move = if (rand_int >= 10)
			MOVE_COOPERATE
		else
			MOVE_DEFECT
		end
		
		move
	end
end

#'nasty' strategies

#1
class AlwaysDefect
	@@desc = "always_defect"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		return MOVE_DEFECT
	end
end

#2
class DefectiveTit4Tat
	@@desc = "def_tit4t"
		
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		opponent_moves.empty? ? MOVE_DEFECT : opponent_moves.last
	end
end

#3
class DeceptiveAlternator
	@@desc = "def_alt"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		move = nil
		if opponent_moves.empty?
			move = MOVE_DEFECT
		else
			move = (@last_move == MOVE_COOPERATE) ? MOVE_DEFECT : MOVE_COOPERATE
		end	
		@last_move = move
	end
end

#4
class DefectiveOpponentCopier
	@@desc = "def_opp_copy"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		move = nil
		if opponent_moves.empty?
			@move_counts = { MOVE_DEFECT => 0, MOVE_COOPERATE => 0}
			move = MOVE_DEFECT
		else
			@move_counts[opponent_moves.last] += 1
			
			if @move_counts[MOVE_DEFECT] >= @move_counts[MOVE_COOPERATE]
				opponent_most_common_move = MOVE_DEFECT
			else
				opponent_most_common_move = MOVE_COOPERATE
			end
			
			move = opponent_most_common_move
		end
		move
	end
end

#5
class MostlyDefective
	@@desc = "mostly_def"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		rand_int = rand(100)
		
		move = if (rand_int < 10)
			MOVE_COOPERATE
		else
			MOVE_DEFECT
		end
		
		move
	end
end

# 'misc'

#1
class Random
	@@desc = "random"
	
	def self.desc
		@@desc
	end
	
	def get_move(opponent_moves)
		return VALID_MOVES[rand(2)]
	end
end

end
