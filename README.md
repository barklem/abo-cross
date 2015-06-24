# abo-cross

Hydrogen broadening Cross-Section Calculator

This code was announced in Publications of the Astronomical Society of Australia,15(3), 336-338, 1998.

This program interpolates cross-sections from the Anstee, Barklem and O'Mara computed tables of line broadening parameters for transitions of neutral atoms broadened by collisions with neutral hydrogen atoms.  The code will interpolate from the tables, and compute the line width at a given temperature. It was written with the idea that users would take the code and merge into their own codes, but it can be used in stand alone mode. Another aim to make available electronic verisons of the tables for convenience.

I provide the original basic version of the program (v1.1) and a newer verison (v2.0).  The main internal codes are exactly the same but a different front end routine (plus necessary extras) is provided in v2.0 which has the folowing advantages:

 - The computation of effective principal quantum number is done by the program, input is simply energy levels;
 - Uses input and output files which has several advantages:
   - easier computation for long line lists;
   - record is automatically kept of all calculations;
 - Atomic masses of elements are stored in the program.
 
Each version has its own README.

Please report any bugs or problems by email.
