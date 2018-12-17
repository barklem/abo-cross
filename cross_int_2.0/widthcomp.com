ifort -w -i8 widthcomp.f retcross.f -o widthcomp.out
##gfortran widthcomp.f retcross.f -o widthcomp.out