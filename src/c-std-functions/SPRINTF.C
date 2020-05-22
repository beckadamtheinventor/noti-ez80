/************************************************************************/
/*									*/
/*			Copyright (C)1987-2008 by				*/
/*		            Zilog, Inc.           			*/
/*									*/
/*		        San Jose, California     			*/
/*									*/
/************************************************************************/
#include <stdio.h>
#include <stdarg.h>
#include <format.h>

/*************************************************
*
* sprintf - print to a string
*
* Inputs:
*	string - string to print to
*	fmt - format string
*	args - argument list
*
* Returns:
*	Number of characters transmitted, or
*	-1 if an error occured.
*
*************************************************/
int sprintf(char *string,char *fmt,...)
{
  va_list ap;

  va_start(ap,fmt);
#ifndef _MULTI_THREAD
  return(_u_print(string,fmt,ap));
#else
  return(_mt_sprint(string,fmt,ap));
#endif
}
