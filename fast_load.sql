.SESSIONS 1;
/*
############################################################################
#  Logon String for Teradata 
############################################################################
*/

.LOGON 10.16.5.102/username,password;

 
 /*
############################################################################
#  Default Delimiter
#  Specifies a delimiter prerect in the source file
############################################################################
*/
.set record VARtext ","

/*
############################################################################
#  Default Database
#  Specifies a restart log table for the fast export checkpoint information
#  Fast Export utility use this information for restarting the job.
############################################################################
*/
DATABASE DATABASE_NAME;
/*
############################################################################
#  The ErrLimit Command limits the number of records that can be rejected
#  while inserting data into the Fastload table.
############################################################################
*/
ERRLIMIT 3000;
/*
############################################################################
#  Droping tables that are going to be used by fastload.
#  Fastload can only run on the tables which are empty. It is esrectial
#  to drop then before begining.
############################################################################
*/
DROP TABLE TABLE_NAME_FOR_INSERTION;

/*
############################################################################
#  DDL - Data Defination Language
#  Creating the Target Tables
############################################################################
*/
CREATE multiset TABLE TABLE_NAME_FOR_INSERTION
	(
	       Unique_key  INTEGER,
		   Target_Predicted BYTEINT 
    )
	 UNIQUE PRIMARY INDEX ( Unique_key );

/*
############################################################################
#  The Function of the Begin Loading Statement is
#	- Identify the Fastload table to recieve data transfered from a
#	  data source on the client compter
#	- Specify the name two Error table ( ERRORFILES ) Two extra tables for error
#	- Start a new fastload job or Restart a job that has been paused
#	- retailerks the target until the end loading statement is not issued
#	- CHECKPOINTS, indicates how often they are taken.
########################################
####################################
*/
    BEGIN TABLE_NAME_FOR_INSERTION
    ERRORFILES TABLE_NAME_FOR_INSERTION_3, TABLE_NAME_FOR_INSERTION_4
    CHECKPOINT 10000;
/*
############################################################################
#  Extract Specification :
############################################################################
#  SET RECORD command specifies the format of the input data
############################################################################
*/
/*
############################################################################
#  The function of the DEFINE command is
#	- DESC_GRPribe the fields in a record of input data that are inserted
#	  in the fastload table
#	- Identifies the name of the input data source or use of an INMOD
#	  routine
#  FILE - The name of the file from which the data will be loaded
############################################################################
*/
--RECORD 2;
DEFINE
unique_key		(VARCHAR(20),NULLIF='?') 
Target_Predicted (VARCHAR(20),NULLIF='?') 

FILE=./FILENAME_prediction.csv;


/*
############################################################################
#  The show command displays active dimension for the input data source or
#  INMOD routine and the field names that were established by one or more
#  in the DEFINE command.
############################################################################
*/ 
SHOW;
/*
############################################################################
#  INSERT is a Teradata SQL statement that inserts data records into the
#  rows of the fastload table.
############################################################################
*/
INSERT INTO TABLE_NAME_FOR_INSERTION
( 

unique_key,
Target_Predicted

) 
VALUES
(
:unique_key,
:Target_Predicted
 
      );


/*
############################################################################
#  The END LOADING command distributes all the rows that were rect from the
#  client to the Teradata RDBMS during the loading phase to their final
#  destination on the AMPs.
############################################################################
*/
END LOADING;
/*
############################################################################
#  LOGOFF - Quit Fastload and all the Teradata RDBMS Sessions.
############################################################################
*/
LOGOFF;

