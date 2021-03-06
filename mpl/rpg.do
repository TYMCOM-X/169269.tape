0010?		The wonderful "DO" command
0020?	
  0030?	Purpose:	Provide a command to simplify running common programs
0040?	
  0050?	Format:		-DO program
  0060?			-CTEST SETDOLIST = dolist
0070?			-CTEST ADDDOLIST = dolist
0080?		A dolist is some number of directories separated by commas.
  0090?		Directories may be specified as (USERNAME) or [gan,uun].  In
 0100?		addition the special names DEFAULT or LOG may be used, to
    0110?		indicate the directory currently GFD'd to and the directory
  0120?		this job is logged in as respectively.
   0130?	
                                                                             0140?	Use:	Behaves very much like RUN (or R), but will search a list of
  0150?		directories in the order specified until it finds a program
  0160?		of the appropriate name.  [Currently, the default list is
    0165?		DEFAULT, LOG, (SYS)]
 0170?	
  0180?	Restrictions:	All directories are assumed to be on device DSK.  The
0190?		default list is actually represented as the null list, so
    0200?		an initial "CTEST ADDDOLIST=(UPL)" will set the do list to
   0210?		a single entry, rather than appending (UPL) to the default.
  0220?		The "DO" command will ignore the list if a directory is
                                    0230?		specified.  Since the "DO" command code is in RPG, a RESCAN
  0240?		from the program will not succeed. (Thus programs which reread
    0250?		the command line and check for ";program commands" will not
  0260?		find the proper results.)
 