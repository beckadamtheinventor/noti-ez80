/*======================================================================
		     Copyright (C) 2008 by			       
		            Zilog, Inc.           	               
			All Rights Reserved			       
							 	       
		        San Jose, California     		       
========================================================================
eZ80 RzkCout.c - Contains RZK wrapper routines for the character output.

=======================================================================*/

#include <stdio.h>
#include <cio.h>

static RZK_DEVICE_CB_t *stdoutDev;

/*!
 * Set the stdout device.
 * 
 * The _set_stdout() function sets a device for standard output.
 */
void _set_stdout(RZK_DEVICE_CB_t *pDev)
{
	stdoutDev = pDev;
}

/*!
 * Send a data byte to stdout.
 * 
 * The putch() function writes a data byte to the standard output device.
 */
int putch(int ch)
{
	if(stdoutDev)
		return(stdoutDev->fnWrite(stdoutDev,(RZK_DEV_BUFFER_t*)&ch,1)<0?EOF:ch);
	return EOF;
}
