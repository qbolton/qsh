##################################################################
# test_menu.ksh
##################################################################
. ${sQshInit}/menu.env >/dev/null

###############################################
# Error Codes
###############################################

###############################################
# Global Definitions
###############################################

function One
{
	errep "It worked!!!!" 0 AUDIT
}

###############################################
# Build Menu
###############################################
menu_setName "Quentin's Test Menu"
menu_setUsage "USAGE: test_menu <mode>"
menu_setPrompt "Enter Selection> "
menu_setOptions "One Two Three Four Five"
menu_setData "Bolton Venus Paris"
menu_setMenuHeader "Active User: ${LOGNAME}"

menu_init 0  
menu_showMenu
