To: tcms.wco@ontyme,tcms.eco@ontyme,tcms.b/fairchild@ontyme
    tcms.l/yarbrough@ontyme
    tcms.e/barens@ontyme,tcms.t/marconi@ontyme,tcms.m/muratore@ontyme
    tcms.s/metcalf@ontyme,tcms.r/daniels@ontyme,txs.c/baltrunas@ontyme
    txs.o/guven@ontyme,txs.c/fletcher@ontyme
Cc: carl
Subject: TYMCOM-X operating system release P034/N - procedure changes

    Date:    19-Jul-84

    To:      All Tymshare Data Center Managers

    Copies:  Software Distribution
             Craig Fletcher, Manager TYMCOM-X Operating Systems
             Robert Klute, INSG TYMCOM-X marketing support

    From:    Carl Baltrunas, TYMCOM-X Operating Systems
             Ontyme:[AA] (TXS.C/BALTRUNAS)

    Subject: Release P034/N of the TYMCOM-X operating system

------------------------------------------------------------------------

    The current release of TYMCOM-X, version P034/N has been sent to
    the software distribution department to be installed on all Tymshare
    PDP-10s and customer DEC-2020s.

    The P034/N release of TYMCOM-X contains several changes which may
    affect current operational procedures.  The changes are minor in
    nature and affect functions which are NOT performed on a regular
    basis.  These procedures are as follows:

        A.  Defining (re-building) a structure.
        B.  Changing a system number.
        C.  Bringing the system up on the console terminal.
        D.  Diagnosing system startup errors.


    The attached document, OPER.MEM, contains a detailed explanation of
    the changes and how they may affect current procedures.  A detailed
    list of other changes should be available from software distribution
    as included with the release announcement which they send out with
    each new software release.

    If you have any questions, please send an ONTYME to me at the above
    mailbox address.  Thank you.
OPER.MEM							Page  1
Operational changes for TYMCOM-X release P034/N


    The P034/N release of TYMCOM-X contains several changes which may
  affect current operational procedures.  The changes are as follows:

    A.  Defining a structure.
	All references to swapping space has been removed.

	1.  There is no active swapping list.
	2.  The TYPE and CHANGE SWAP commands have been removed.
	3.  The question "PAGES FOR SWAPPING ON UNIT" has been removed.
	4.  All messages about units in swapping list and units having
	    swapping space have been removed.

    B.  Changing a system number.
	Hosts connected PDP-11 or micro-net bases are no longer
	restricted to system numbers between 1 and 255.  The system
	number may be set to any number between 1 and 99999 on any
	KS-10 (DEC-2020 or Tymshare SYSTEM-XX), Foonly F3 (SYSTEM XXV)
	or Foonly F4 (SYSTEM XXVI or XXVI-KL).

	Note: Hosts connected to VARIAN bases (KI-10 and KL-10) are
	still restricted to system numbers between 1 and 255.

    C.  Bringing the system up on the console terminal.
	The function of the CONSOLE command has been modified to allow
	the system to be brought up on the console terminal in ANY mode.
	This command sets a flag which tells the system to ignore the
	network and the base and to ONLY talk to the console terminal.
	When the CONSOLE command is given, the system responds with:

	  Console selected.
	  Please type GO, FULL, MANUAL or READONLY to bring up the system.

	Previously, the CONSOLE command brought the system up on the
	console terminal in MANUAL mode only.

    D.  New "NETWORK" command added.
	This is the default.  After the CONSOLE command is given, the
	system will come up using only the console terminal.  If it is
	desired to use the network instead of the console, this command
	must be given before typing GO, FULL, MANUAL or READONLY.  When
	the NETWORK command is given, the system responds with:

	  Network selected.
	  Please type GO, FULL, MANUAL or READONLY to bring up the system.

    E.  Various messages have been changed in ONCE and INITIA in order
        to make it easier to diagnose startup problems. 

        As an aid in updating documentation, the following help messages
        have been copied verbatim from the monitor sources.  Please see
        that your staff understands the wording of each text and that
        the procedures and documents using portions of these messages
        are updated to reflect the changes.

OPER.MEM							Page  2
Operational changes for TYMCOM-X release P034/N


ONCE DIALOG:
    ONCE> HELP

    TYPE     Report information about the system.
             TYPE CORE   - the default minimum core available to users.
             TYPE SYSTEM - reports the system number.

    CHANGE   Change information about the system.
             CHANGE CORE   - changes the default minimum user core.
             CHANGE SYSTEM - changes the system number.

    FULL     Bring up the system with a FULL DSKCLN.  If there is any
             question about the integrity of the file system, then this
             command should be used in place of GO.  Unless authorized,
             DO NOT enter the FILES dialogue to set the DSKCLN type.

    GO       Bring up the system with the default settings and start
             the auto-restart process.

    FILES    Enter the FILES dialogue.  This is the subsystem of ONCE
             which is normally used ONLY for restructuring or repairing
             the disk file system.  The commands in this subsystem could
             damage the file system if they are used incorrectly.  If you
             are NOT sure of what you are doing, DO NOT enter this section.

    READONLY Bring up the system SHUT for emergency examination.
             Writing on the disk is prevented until DSKCLN has been run.
             Note: You may not UNSHUT the system until DSKCLN has been run.

    CONSOLE  Allow the system to be brought up on the CONSOLE terminal ONLY.
             The system MUST be reloaded before it can be brought up on the
             network.  This command should be followed by a command to bring
             up the system (one of: GO, FULL, MANUAL or READONLY).

    NETWORK  Allow the system to be brought up on the NETWORK (default).
             This allows normal access to the system and overrides any
             previous CONSOLE or NETWORK commands.  This command should be
             followed by a command to bring up the system. (see CONSOLE.)

    DDT      Enter executive DDT.  To be used ONLY by software wizards
             for emergency patching and examination of the monitor.
             UNDER NO CIRCUMSTANCES SHOULD YOU NORMALLY USE THIS COMMAND!

    MANUAL   Bring up the system in the SHUT state for DEBUGGING ONLY!
             The auto-restart process is not performed.
             Note: You may not UNSHUT the system until DSKCLN has been run.

    BOOTS    Crash the system with "BOOTS LOADED" immediately.

For KS-10 only:
    KMC      Bring the system up loading the KMC-11 but without the
             rest of the automatic restart procedure.  This must NEVER
             be used for a restart after a system CRASH.  ONLY to be
             used when the system has been taken down gracefully and
             DSKCLN has already been run.

OPER.MEM							Page  3
Operational changes for TYMCOM-X release P034/N


ONCE DIALOG:
    ONCE> HELP TYPE

    TYPE CORE   - Type the default minimum core available to users.
    TYPE SYSTEM - Type the system number.
    TYPE HELP   - Type out this message.


ONCE DIALOG:
    ONCE> HELP TYPE

    CHANGE CORE   - Change the default minimum core available to users.
    CHANGE SYSTEM - Change the system number.  (This should ONLY be
                    done when bringing up a system on hardware other
                    than what it was originally built for).
    CHANGE HELP   - Type out this message.


FILES DIALOG:
    FILES* HELP

    DSKCLN  Query or Select DSKCLN mode.
            List the current mode and allow the operator to change it.

    TYPE    List information about the structure.
            Type "TYPE HELP" for a list of options.

    CHANGE  Change information about the structure.
            Type "CHANGE HELP" for a list of options.

    ADD     Add a unit to the structure.
            Reconfigure the disk structure and add another pack.

    DISOLVE Disolve the structure.
            Remove all units from the system structure.

    DEFINE  Define a NEW structure.
            Create a completely new system structure.

    REFRESH Refresh the structure.
            Erase the current file system and start over
            with a "FRESH" disk.

    GO      Leave the FILES dialogue and return to the ONCE
            dialogue.

    HELP    Type this message.

OPER.MEM							Page  4
Operational changes for TYMCOM-X release P034/N


FILES DIALOG:
    FILES* HELP TYPE

    STR     Name of the STRUCTURE and UNITS on it.
    UNITS   Names of all units NOT in a file structure.
    BAT     Number of BAD pages and regions for a unit.
    SATPCBS Number of SAT PCBs.
    RIBPCBS Number of RIB PCBs.
    ALL     f the above.
    str-name  Type information about the structure.
    unit-name Type information about the unit.
    HELP    Type this message.


FILES DIALOG:
    FILES* HELP CHANGE

    SATPCBS   Change the number of SAT PCBs.
    RIBPCBS   Change the number of RIB PCBs.
    BAT       Refresh the BAT pages for a UNIT.
    str-name  Change parameters for the structure
    unit-name Change parameters for a unit.
    HELP      Type this message.


FILES DIALOGUE:
    Type "TYPE str-name HELP" for a list of options.        (or)
    Type "CHANGE str-name HELP" for a list of options.

    FILES* TYPE str-name HELP

    ... OVERDRAW  The number of pages for overdraw.
    ... CRASH     The number of pages for CRASH.SAV.
    ... ALL       All of the ABOVE.
                  The number of pages for Overdraw, for CRASH.SAV.
    ... HELP      Type this message.

 C :?