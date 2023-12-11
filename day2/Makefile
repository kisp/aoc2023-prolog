files := --consult-file input.prolog --consult-file day2.prolog

default: run-partA run-partB

run-partA:
	gprolog $(files) --query-goal 'partApossibleGameIds(GameIds, Sum)' --query-goal 'halt'

run-partB:
	gprolog $(files) --query-goal 'partBPowers(Powers, Sum)' --query-goal 'halt'
