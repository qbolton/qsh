#!/usr/bin/ksh
# ------------
# (c) Copyright Capital One Financial Corporation 1998-2002
#
# This software is the confidential and proprietary information of
# Capital One Financial Corporation and/or its affiliates.  It is
# not to be reproduced, used or distributed in whole or in part,
# without the express written permission of Capital One Financial
# Corporation.  This software is protected under the copyright
# laws of the United States.
#
#--------------------------------------------------------------------
# Script  : _NAME_ 
# Author  : _AUTHOR_
# Date    : _DATE_
# Purpose : _PURPOSE_
#         : 
#         :
#         :
# Inputs  : none
# Outputs : Return Codes
#         :   0 = Successfully executed.
#         :   1 = Incorrect number of parameters.
#         : 
#         : 
#         :
#         :
#--------------------------------------------------------------------
#
# Change History
#--------------------------------------------------------------------
# Date Changed  By Change
#--------------------------------------------------------------------
# 08/08/02  
#--------------------------------------------------------------------

#-----------------------------------------------------------------------------#
#                **********  Error Codes and Constants  **********            #
#-----------------------------------------------------------------------------#
typeset -r INCORRECT_NUMBER_PARMS=1

#-----------------------------------------------------------------------------#
#                **********  FUNCTION DEFINITIONS  **********                 #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#                **********  TEST FOR DEBUG_MODE  **********                  #
#-----------------------------------------------------------------------------#
# Check if Debug_Mode has been set in environment

if [[ -n ${Debug_Mode} ]]; then
   if (( ${Debug_Mode} != 0 )); then
      set -x
   fi
fi

#-----------------------------------------------------------------------------#
#                 **********  INITIALIZE SCRIPT  **********                   #
#-----------------------------------------------------------------------------#
# Initialize job name, number of parameters, and usage.

typeset Job=$(basename $0)
typeset Num_Parms=_PARMS_
typeset Usage="Usage: ${Job}"

print "\nStarting ${Job}\n\ton $(date)."

#-----------------------------------------------------------------------------#
#              **********  TEST NUMBER OF PARAMETERS  **********              #
#-----------------------------------------------------------------------------#

if (( $# < ${Num_Parms} )); then
   print "Incorrect number of parameters."
   print "${Usage}"
   print "Exiting ${Job} with error code 1."
   exit ${INCORRECT_NUMBER_PARMS}
fi

#-----------------------------------------------------------------------------#
#                  **********  INCLUDE DOT (.) SCRIPTS   **********           #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#                  **********  INITIALIZE LOCAL VARIABLES  **********         #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#                  **********  <ENTER SECTION TITLE HERE>  **********         #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#                    **********  END OF SCRIPT  **********                    #
#-----------------------------------------------------------------------------#

print "\n\nSuccessfully completed ${Job}\non $(date)."
exit ${RetCode}

