/*======================================================================
		     Copyright (C) 2008 by			       
		            Zilog, Inc.           	               
			All Rights Reserved			       
							 	       
		        San Jose, California     		       
========================================================================
eZ80 RzkCin.c - Contains RZK wrapper routines for the character input.

=======================================================================*/

#include <stdio.h>
#include <cio.h>

static RZK_DEVICE_CB_t *stdinDev;

/*!
 * Set the stdin device.
 * 
 * The _set_stdin() function sets a device for standard input.
 */
void _set_stdin(RZK_DEVICE_CB_t *pDev)
{
	stdinDev = pDev;
}

/*!
 * Receive a data byte from stdin.
 * 
 * The getch() function reads a data byte from the standard input device.
 */
int getch(void)
{
	char ch;
	if(stdinDev)
		stdinDev->fnRead(stdinDev,(RZK_DEV_BUFFER_t*)&ch,1);
	return((int)ch);
}
