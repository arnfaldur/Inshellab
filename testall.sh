#!/bin/bash
make
echo "" > testdiff
for i in {1..16}
do
	nth=$(printf %02d $i)
	echo "Testing $i"
	# Remove seds at will, the first one removes pid numbers and is probably the only one that
	# makes sense to remove as it removes all numbers of length 3-5.
	make rtest$nth | sed -E "s/[0-9]{3,5}/(pid)/g" | sed -E "s/tshref/tsh/g" | sed -E "s/rtest/test/g" > rtestout
	make test$nth  | sed -E "s/[0-9]{3,5}/(pid)/g" | sed -E "s/tshref/tsh/g" | sed -E "s/rtest/test/g" > testout
	# Change this to a cool git merge like diff thing please or not whatever idc.
	diff rtestout testout >> testdiff
	rm rtestout
	rm testout
	echo "Test number: $i"$'\n\n' >> testdiff
done
echo "Job's done!"
