files := --consult-file input.prolog --consult-file day1.prolog

default: run-partA run-partB

run-partA:
	gprolog $(files) --query-goal 'calibrationDocSumPartA(Sum)' --query-goal 'halt'

run-partB:
	gprolog $(files) --query-goal 'calibrationDocSumPartB(Sum)' --query-goal 'halt'
