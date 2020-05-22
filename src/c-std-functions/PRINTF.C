/*************************************************
 *  Copyright (C) 1999-2008 by  Zilog, Inc.
 *  All Rights Reserved
 *************************************************/

#include <stdio.h>
#include <stdarg.h>

/*************************************************
*
* printf - print to stdout
*
* Inputs:
*	fmt - format string
*	args - argument list
*
* Returns:
*	Number of characters transmitted, or
*	-1 if an error occured.
*
*************************************************/
int printf(char * fmt,...)
{
  va_list ap;
#ifdef _MULTI_THREAD
  register unsigned char __print_len;
#endif

  va_start(ap,fmt);
#ifndef _MULTI_THREAD
  // Set up to print to device
  __print_xputch = __print_uputch;
  _u_print((void *)NULL,fmt,ap);

  // reset to print to sprintf buffer

  // We do this here, instead of having sprintf set itself up, because printf
  // is often used for debug printing and we want to minimize the work done 
  // by sprintf.  In particular, when the compiler generates printfs and 
  // sprintfs in line, it generates this code for each printf so that no
  // additional code is needed for sprintf.
  __print_xputch = __print_sputch;
#else
  __print_len = _mt_print(fmt,ap);
#endif
  if (__print_len < 0 )
    return -1;
  return __print_len;
}

