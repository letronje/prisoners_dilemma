#! /usr/bin/ruby

require 'strategies.rb'
require 'game.rb'
require 'constants.rb'

include Strategies, Constants

def normalize(spawn_counts)
	print "Normalizing instance counts to #{MAX_INSTANCES_PER_GENERATION} ... " ; $stdout.flush ;
	
	total_count = 0
	spawn_counts.values.each { |c| total_count += c }
	
	new_spawn_counts = {}
	
	if total_count < MAX_INSTANCES_PER_GENERATION
		spawn_counts.each_pair do |strategy, count|
			new_spawn_counts[strategy] = count.round
		end
	else
		spawn_counts.each_pair do |strategy, count|
			next if count.zero?
			new_spawn_counts[strategy] = ((count * MAX_INSTANCES_PER_GENERATION) / total_count).round
		end	
	end
	
	print "Done\n" ; $stdout.flush ;
	
	new_spawn_counts
end

def print_spawn_counts(spawn_counts)
	puts
	sorted_spawn_counts = spawn_counts.sort do|a, b|
		b[1] <=> a[1]
	end
	sorted_spawn_counts.each do |spawn_count|
		puts "#{spawn_count[0].desc} => #{spawn_count[1]}"
	end
	puts
end

strategies = Strategies.constants.collect { |s| eval(s.to_s) }

spawn_counts = {}

sleep_time = 5

100.times do |x|
	puts "\nRound #{x+1} : \n\n"
	if x.zero?
		spawn_counts = {}
		strategies.each { |s| spawn_counts[s] = INIT_NUM_PLAYERS_PER_STRATEGY }
	end
		
	game = Game.new(
		spawn_counts, 
		NUM_MOVES_PER_FIGHT, 
		VALID_MOVES, 
		MOVE_SCORES, 
		MOVE_NAMES
	)
	
	stime = Time.now
	
	spawn_counts = game.run
	
	etime = Time.now
	
	#puts "Before : \n\n"
	#print_spawn_counts(spawn_counts)
	spawn_counts = normalize(spawn_counts)
	#puts "After : \n\n"
	print_spawn_counts(spawn_counts)
	
	puts "Time Taken : #{etime-stime} secs\n"
	
	print "\nSleeping for #{sleep_time} seconds ... " ; $stdout.flush ;
	sleep sleep_time
	
	print "Done\n" ; $stdout.flush ;
end



