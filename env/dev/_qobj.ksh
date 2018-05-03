#===================================================================
# _qobj.ksh
# Provides functions for use when manipulating a variable containing
# data complying with _qobj.ksh specifications. 
#
# qobj virtual ksh object architecture
# NAME=<name>|SIZE=<size>|DATA=<data>|...
#===================================================================

#===================================================================
# Function _qobjInit
# Formats data in qobj_session array or retrieves it interactively.
# Assuming that is taken care of (without error) the function will
# return the size of initial list.
#===================================================================
unalias _qobjInit
function _qobjInit
{
	typeset qobj_NAME=$1
	shift
	typeset qobj_SIZE=1
	typeset qobj_DATA=""
	while (( $# > 0 ))
	do
		typeset arg=$1
		item=$(qobj_transl "${arg}" ' ' '^')
		qobj_DATA="${qobj_DATA}|${item}"	
		qobj_SIZE=$((qobj_SIZE+1))
		shift
	done
	# Increment size again to account for adding size value to the object
	qobj_SIZE=$((qobj_SIZE+1))
	print "name=${qobj_NAME}|size=${qobj_SIZE}${qobj_DATA}"
	return ${qobj_SIZE}
}

unalias qobj_transl
function qobj_transl
{
	typeset data=$1
	typeset from=$2
	typeset to=$3
	print "${data}"|tr "${from}" "${to}"
}

unalias qobj_addItem
# Returns Size of New Item List
function qobj_addItem
{
	typeset data=$1
	typeset newItem=$2
	typeset qobj_SIZE_before=$(qobj_getSize "${data}")
	typeset qobj_SIZE_after=$(($(qobj_getSize "${data}")+1))
	typeset qobj_ITEM=$(qobj_transl "${newItem}" ' ' '^')
	set -A qobj_itemList $(qobj_transl "${data}" '|' ' ')
	qobj_itemList[${qobj_SIZE_before}]=${qobj_ITEM}
	qobj_itemList[1]="size=${qobj_SIZE_after}"
	qobj_transl "${qobj_itemList[*]}" ' ' '|'
	unset qobj_itemList
	return ${qobj_SIZE_after}
}

unalias qobj_replace
function qobj_replace
{
	typeset data=$1
	typeset id=$2
	typeset newItem=$3
	typeset qobj_ITEM=$(qobj_transl "${newItem}" ' ' '^')
   set -A qobj_itemList $(qobj_transl "${data}" '|' ' ')
   qobj_itemList[${id}]=${qobj_ITEM}
   qobj_transl "${qobj_itemList[*]}" ' ' '|'
   unset qobj_itemList
}

unalias qobj_dump
function qobj_dump
{
	typeset data=$1
	typeset count=1
	for i in $(qobj_transl "${data}" '|' ' ')
	do
		errep "Item ${count}: $(qobj_transl ${i} '^' ' ')" "" AUDIT
		count=$((count+1))
	done
}

unalias qobj_getSize
function qobj_getSize
{
	typeset data=$1
	typeset qobj_SIZE=$(qobj_getValue $(qobj_getItem "${data}" 1))
	print "${qobj_SIZE}"
}

unalias qobj_getName
function qobj_getName
{
	typeset data=$1
	typeset qobj_NAME=$(qobj_getValue $(qobj_getItem "${data}" 0))
	print "${qobj_NAME}"
}

unalias qobj_getItem
function qobj_getItem
{
	typeset data=$1
	typeset id=$2
	set -A qobj_itemList $(qobj_transl "${data}" '|' ' ')
	typeset qobj_ITEM=$(qobj_transl ${qobj_itemList[${id}]} '^' ' ')
	unset qobj_itemList
	print "${qobj_ITEM}"
}

unalias qobj_getValue
function qobj_getValue
{
	typeset data=$1
	typeset qobj_VALUE=$(print "${data}"|cut -d'=' -f2)
	print "${qobj_VALUE}"
}	
