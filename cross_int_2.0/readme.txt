WIDTHCOMP documentation
-----------------------

Paul Barklem, Uppsala, 1998-2000


0.  VERSION HISTORY
-------------------

Released 12/08/2000

Tested using Sun Fortran77

Some updates 5/3/2009 following discovery of a bug which showed up under the Intel compiler

1.  INTRODUCTION
----------------

The Original Program (v1.x)
---------------------------

The original program interpolates cross-sections from our (Anstee, Barklem and O'Mara) computed tables of line broadening parameters for transitions of neutral atoms broadened by collisions with neutral hydrogen atoms. 

This version includes code to interpolate from the tables, and compute the line width at a given temerature. It was primarily written with the idea that users would take the code and merge into their own code, or alternatively it can be used in stand alone mode. Another aim was simply to make available electronic verisons of the tables to save you, the end user, the hassle of typing it all in yourself which is likely to lead to errors.  This was probably why I included the data as external files.

The New Interface (v2.x)
------------------------

The main features of the new version are: 

  (1) The computation of effective principal quantum number is done by the program, input is simply energy levels; 
  (2) Uses input and output files which has several advantages namely: 
       (i) Enables easier computation for long line lists; 
       (ii) A record is automatically kept of all calculations; 
  (3) Atomic masses of elements are stored in the program.

The changes are really just a more advanced user interface. 


2.  INPUT FILES
---------------

Input files are simple text files where each line provides a "record" of data corresponding to a spectral line to be processed.  The first 3 characters of any given record determine how the program will process the record.  This enables 4 possible input types:

  (1) A record of line data to be processed indicated by a valid species label eg Na.  It is not case sensitive.

  (2) A comments line.  The program supports 2 types of comments:

      (i) A comment in the input file which is ignored is indicated by ### being the first three characters.

      (ii) A comment in the input file which is passed to the "long" (see next section) output file is indicated by using $$$ as the first three characters.

  (3) A blank line.  Any line with three leading blanks is assumed totally blank, and a corresponding blank line is produced in the "long" output file.  

  (4) An end instruction.  If the first three characters are "end" or "END" the program stops reading input. (Currently case sensitive).

Line Input Data Format
----------------------

There are two types of line data input:

  (1) Lines where broadening cross sections are to be computed from tables;

  (2) Lines where cross sections are supplied, which is in particular meant to take data for ionised lines which is computed line by line.  This allows easy integration of these data into line lists.

Type 1 input lines:
-------------------

Records of line data must contain the following data in the following order:

  (1) Species (eg. Fe or Ba)
  (2) Ionisation stage (1=neutral, 2=singly ionised etc.)
  (3) Wavelength in Angstroms
  (4) Lower level energy in cm^-1
  (5) Ionisation limit of the lower level in cm^-1
  (6) Upper level energy in cm^-1
  (7) Ionisation limit of the upper level in cm^-1
  (8) Orbital angular momentum quantum number l for the lower state
  (9) Orbital angular momentum quantum number l for the upper state
  (10) Total angular momentum quantum number J for the lower state
  (11) Total angular momentum quantum number J for the upper state

It should be noted that J quantum numbers are not actually used in calculation.  They are simply passed to the output as they provide a very strong test for identifying/matching lines with other data.

A typical example would be say the sodium D lines.  Input could be as below:

Na 1	5889.953	0		41449.65	16973.379	41449.65	0	1	0.5	1.5
Na 1	5895.923	0		41449.65	16956.183	41449.65	0	1	0.5	0.5

Here I have separated data with spaces (tabs in fact), however commas could also be used.  All data are read in in double precision and so upto 15 digits should be retained. 


Type 2 Input Lines
------------------

Currently I use a some what inelegant way of doing this but it works.  The input is as above for the first 3 entries.  The fourth entry is used to flag that the input is of this type.  This is done with any negative value.  The remaining data are then in order:

  (5) Line broadening cross section in atomic units (square bohr radii)
  (6) Velocity parameter "alpha"

Then follows the quantum number inputs 8-11 from above as inputs 7-10 in this case.

So a typical example would be the Ca II resonance lines:

Ca 2	3968.47		-1		234		.223				0	1	0.5	0.5
Ca 2	3933.66		-1		234		.223				0	1	0.5	1.5

Comment Lines
-------------

The comments which are ignored indicated by a leading ### are self explanatory.  

Comments passed to "long" output are indicated by $$$.  Columns 4-104 of these records are simply passed verbatim to the "long" output file.

Blank lines make things nice to read and are passed through to the "long" output file.

A Complete Example
------------------

For a complete example, lets integrate the above lines into one nice file:

### My first input file

$$$ Multiplet 1 of Na
Na 1	5889.953	0		41449.65	16973.379	41449.65	0	1	0.5	1.5
Na 1	5895.923	0		41449.65	16956.183	41449.65	0	1	0.5	0.5

$$$ A line of O
O  1   	7771.9440    	73767.810      109836.700       86631.040      109836.700    	0    	1  	2.0  	3.0

$$$ The Ca II resonance lines
Ca 2	3968.47		-1		234		.223				0	1	0.5	0.5
Ca 2	3933.66		-1		234		.223				0	1	0.5	1.5

end

Note you could type anything below the "end" and it will be ignored.  I included the O line to demonstrate that single character elements are handled in the same way, but note the ionisation stage must be in the fourth column.

This is the output you would get in the "long" format file:

************************************************************************************************************************
VERSION 2.0                                 By Paul Barklem
 
 Input Filename: first.list                    
Output Filename: first.out                     
Time: Wed Apr 28 14:30:26 1999
 
Processed   5 Lines.
************************************************************************************************************************
Spec     Wavel      Elow     Elimit       Eupp     Elimit   L      J     N*low N*upp  Sigma    Alpha Log(Gamma/N)
  
 Multiplet 1 of Na                                                                                  
Na 1  5889.953      0.000  41449.650  16973.379  41449.650 0->1 0.5->1.5 1.627 2.117  406.87   0.273  -7.526
Na 1  5895.923      0.000  41449.650  16956.183  41449.650 0->1 0.5->0.5 1.627 2.116  406.58   0.273  -7.527
  
 A line of O                                                                                        
O  1  7771.944  73767.810 109836.700  86631.040 109836.700 0->1 2.0->3.0 1.744 2.174  453.35   0.234  -7.469
  
 The Ca II resonance lines                                                                          
Ca 2  3968.470      cross section input                    0->1 0.5->0.5              234.00   0.223  -7.760
Ca 2  3933.660      cross section input                    0->1 0.5->1.5              234.00   0.223  -7.760
************************************************************************************************************************

The last column is the linewidth (full) per perturber in 10000 K.  This number is used by various spectral synthesis programs.  One should note however that alpha must be considered to find the "correct" temperature dependance which is T**((1-alpha)/2).

3.  OUTPUT FILES
----------------

The program produces 2 output files a "long" and "short" version.  The long version is intended to be read by humans and so is nicely formatted etc.  An example was shown above.  The short version is a more easily machine readable form.  Only line data is passed to it, and only those which are particularly useful in identfying/matching the line.  For example the above input and long output files have the corresponding short output:

11.00   5889.953  0.5  1.5   0.000   2.103   406.87  0.273      0.000  41449.650  16973.379  41449.650 0 1  -7.526
11.00   5895.923  0.5  0.5   0.000   2.101   406.58  0.273      0.000  41449.650  16956.183  41449.650 0 1  -7.527
 8.00   7771.944  2.0  3.0   9.140  10.734   453.35  0.234  73767.810 109836.700  86631.040 109836.700 0 1  -7.469
20.01   3968.470  0.5  0.5  -1.000  -1.000   234.00  0.223     -1.000     -1.000     -1.000     -1.000 0 1  -7.760
20.01   3933.660  0.5  1.5  -1.000  -1.000   234.00  0.223     -1.000     -1.000     -1.000     -1.000 0 1  -7.760

The columns are:

  (1) Species number Z + (ionisation stage-1)/100
  (2) Wavelength in Angstroms
  (3) Lower J quantum number
  (4) Upper J quantum number 
  (5) Lower energy level in eV
  (6) Upper energy level in eV
  (7) Line broadening cross-section in atomic units
  (8) The velocity parameter alpha
  (9) Lower level energy in cm^-1
  (10) Ionisation limit of the lower level in cm^-1
  (11) Upper level energy in cm^-1
  (12) Ionisation limit of the upper level in cm^-1
  (13) Orbital angular momentum quantum number l for the lower state
  (14) Orbital angular momentum quantum number l for the upper state
  (15) Log of linewidth per perturber at 10000K (rad/s cm^3)

You can of course, change this output to whatever you want very easily.

Although 2 decimal places of the cross section are retained here, the cross sections are only expected to be accurate to around 5 per cent.






