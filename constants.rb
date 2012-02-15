module Constants

INIT_NUM_PLAYERS_PER_STRATEGY = 1


MOVE_DEFECT 	= 1
MOVE_COOPERATE 	= 2 

VALID_MOVES = [MOVE_DEFECT, MOVE_COOPERATE]

MOVE_NAMES = {
	MOVE_DEFECT 	=> 'Defect',
	MOVE_COOPERATE 	=> 'Cooperate'
}

OUTCOME_REWARD 			= 1
OUTCOME_SUCKERS_PAYOFF 	= 2
OUTCOME_TEMPTATION 		= 3
OUTCOME_PUNISHMENT 		= 4

SCORES = {
	OUTCOME_SUCKERS_PAYOFF 	=> 0,
	OUTCOME_PUNISHMENT 		=> 1,
	OUTCOME_REWARD 			=> 2,
	OUTCOME_TEMPTATION 		=> 3
}


NUM_MOVES_PER_FIGHT = 100

MAX_INSTANCES_PER_GENERATION = 100

MOVE_SCORES = {
	[MOVE_DEFECT	, MOVE_COOPERATE] 	=> [SCORES[OUTCOME_TEMPTATION]		, SCORES[OUTCOME_SUCKERS_PAYOFF]],
	[MOVE_DEFECT	, MOVE_DEFECT	] 	=> [SCORES[OUTCOME_PUNISHMENT]		, SCORES[OUTCOME_PUNISHMENT]	],
	[MOVE_COOPERATE	, MOVE_DEFECT	] 	=> [SCORES[OUTCOME_SUCKERS_PAYOFF]	, SCORES[OUTCOME_TEMPTATION]	],
	[MOVE_COOPERATE	, MOVE_COOPERATE] 	=> [SCORES[OUTCOME_REWARD]			, SCORES[OUTCOME_REWARD]		]
}

end
