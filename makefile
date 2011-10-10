all:
	cd src; ghc --make Main.hs
	mv src/Main bin/

test: all
	./bin/Main

clean:
	./sys/clean.pl

tmp:
	make
	make clean

