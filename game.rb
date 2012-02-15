require 'constants.rb'

class Game
	@@SEPARATOR_WIDTH = 75
	
	def update_scores(p1, m1, p2, m2)
		score_increments = @move_scores[[m1, m2]]
		@scores[p1.class] += score_increments[0]
		@scores[p2.class] += score_increments[1]
	end
	
	def fight(p1, p2, verbose=false)
		#p1_id, p2_id = @players_ids[p1.object_id], @players_ids[p2.object_id]
		
		#puts "\n'#{p1_id}' [ #{@scores[p1_id]} ] v/s '#{p2_id}' [ #{@scores[p2_id]} ] \n\n"
		
		p1_moves, p2_moves = [], []
		
		#[p1, p2].each { |p| p.start_fight }
		
		@num_moves_per_fight.times do |move_num|
			m1 = p1.get_move(p2_moves)
			m2 = p2.get_move(p1_moves)
			
			moves_validated = false

			if( (@valid_moves.include? m1) and (@valid_moves.include? m2) )
				#[p1, p2].each { |p| p.move_accepted }
				moves_validated = true
			end	
			
			next unless moves_validated
			
			p1_moves << m1
			p2_moves << m2
			
			mn1, mn2 = @move_names[m1], @move_names[m2]
			
			#puts "Move ##{move_num+1} : \n\n'#{p1_id}' => '#{mn1}' , '#{p2_id}' => '#{mn2}'\n" if verbose
			
			update_scores(p1, m1, p2, m2)
			
			#puts "\t#{p1_id} =>  #{@scores[p1_id]} , #{p2_id} => #{@scores[p2_id]}\n\n" if verbose
		end
		
		#[p1, p2].each { |p| p.end_fight }
		
		#puts "-" * @@SEPARATOR_WIDTH if verbose
		#puts "Score : #{p1_id} : #{@scores[p1_id]} , #{p2_id} : #{@scores[p2_id]}"
		
		#puts "\nFight between #{p1_id} and #{p2_id} ends"
		
		#puts "#" * @@SEPARATOR_WIDTH
	end

	def initialize(
		strategy_spawn_counts, 
		num_moves_per_fight, 
		valid_moves, 
		move_scores,
		move_names
	)
		@num_moves_per_fight			= num_moves_per_fight
		@valid_moves 					= valid_moves
		@move_scores					= move_scores
		@move_names						= move_names
		
		#@strategies					= []
		#@players_ids 					= {}
		@scores							= {}
		@players						= []
				
		count = 1
		
		strategy_spawn_counts.each_pair do |strategy, spawn_count|
			#print "Spawning #{spawn_count} instance(s) of the strategy #{strategy.desc} ... " ; $stdout.flush ;
			
			#strategies << strategy
			@scores[strategy] = 0
			spawn_count.times do
				player = strategy.new		
				#player_gen_id = "#{player.type}_#{count.to_s}"
				#@players_ids[player.object_id] = player_gen_id
				@players << player
				count += 1
			end
			
			#puts "Done" ; $stdout.flush ;
		end
		
		
	end
	
	def run	
		num_players = @players.length
		total = num_players ** 2
		done = 0
		lper = 0
		per = 0
		
		stime = Time.now
		
		@players.each do |p1|
			@players.each do |p2|
				#next if p1.object_id == p2.object_id
				fight(p1, p2)
=begin				
				done += 1
				if (Time.now - stime ) > 30
					stime = Time.now
					print '.' ; $stdout.flush ;
					sleep 5
					puts '.' ; $stdout.flush ;
					
				end
				
				per = (done*100.0/total).round
				if (per-lper) >= 1
					lper = per
					puts "#{done}/#{total}[#{per}%] Done"
				end
					
				#done += 1
=end				
			end
		end	

=begin		
		puts '100% Done'
		
		puts "\nFinal Scores : \n\n"
		
		sorted_scores = @scores.sort do |a, b|
			b[1] <=> a[1]
		end
		
		sorted_scores.each do |strategy, score|
			puts "\t#{strategy.desc} => #{score}"
		end
		
		puts
=end		
		@scores
	end
end
