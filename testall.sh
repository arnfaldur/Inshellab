make
echo "" > testdiff
for i in {1..16}
do
	nth=$(printf %02d $i)
	make rtest$nth | sed -E "s/\([0-9]{5}\)/(pid)/g" > rtestout
	make test$nth  | sed -E "s/\([0-9]{5}\)/(pid)/g" > testout
	diff rtestout testout >> testdiff
	rm rtestout
	rm testout
	echo $'\n\n' >> testdiff
done