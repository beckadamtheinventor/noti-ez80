; there need to be at least 373 function jumps
; Boot Calls
;-----------------------------------
assert $ = $80
;Version info:
	jp _boot_maj_min_ver
;   Gets boot code major version in a
;   Gets boot code minor version in b
	jp _boot_GetHardwareVers
;   Gets hardware version (7) in a
	jp _boot_GetKeyID
;   Gets key ID into hl (It's 1370h for me)
	jp _boot_GetBootVerMinor
;   Gets boot code revision version in a
	jp _boot_GetBootVerBuild
;   Gets boot code build number in ab
	jp _dbgout
;   Unknown - seems rarely used, might log data
; C standard functions
	jp _longjmp
	jp _memchr
	jp _memcmp
	jp _memcpy
	jp _memmove
	jp _memset
	jp _memclear
	jp _printf
	jp _setjmp
	jp _sprintf
	jp _strcat
	jp _strchr
	jp _strcmp
	jp _strcpy
	jp _strcspn
	jp _strlen
	jp _strncat
	jp _strncmp
	jp _strncpy
	jp _strpbrk
	jp _strrchr
	jp _strspn
	jp _strstr
	jp _strtok
	jp _riemann
	jp _bldiy
	jp _bshl
	jp _bshru
	jp _bstiy
	jp _bstix
	jp _case
	jp _case16
	jp _case16D
	jp _case24
	jp _case24D
	jp _case8
	jp _case8D
	jp __frameset
	jp __frameset0
	jp __iand
	jp __icmpzero
	jp __idivs
	jp __idivu
	jp __idvrmu
	jp _ildix
	jp _ildiy
	jp _imul_b
	jp __imulu
	jp __imuls
	jp _indcall
	jp __ineg
	jp __inot
	jp __ior
	jp __irems
	jp __iremu
	jp __ishl
	jp _ishl_b
	jp __ishrs
	jp _ishrs_b
	jp __ishru
	jp _ishru_b
	jp _istix
	jp _istiy
	jp _itol
	jp __ixor
	jp __ladd
	jp _ladd_b
	jp __land
	jp __lcmps
	jp __lcmpu
	jp __lcmpzero
	jp __ldivs
	jp __ldivu
	jp __ldvrmu
	jp _lldix
	jp _lldiy
	jp __lmuls
	jp __lmulu
	jp __lneg
	jp __lnot
	jp __lor
	jp __lrems
	jp __lremu
	jp __lshl
	jp __lshrs
	jp __lshru
	jp _lstix
	jp _lstiy
	jp __lsub
	jp __lxor
	jp __sand
	jp __scmpzero
	jp __sdivs
	jp __sdivu
	jp _seqcase
	jp _seqcaseD
	jp _setflag
	jp _sldix
	jp _sldiy
	jp __smuls
	jp __smulu
	jp __sneg
	jp __snot
	jp __sor
	jp __srems
	jp __sremu
	jp __sshl
	jp _sshl_b
	jp __sshrs
	jp _sshrs_b
	jp __sshru
	jp _sshru_b
	jp _sstix
	jp _sstiy
	jp _stoi
	jp _stoiu
	jp __sxor
	jp _fppack
	jp _fadd
	jp _fcmp
	jp _fdiv
	jp _ftol
	jp _ultof
	jp _ltof
	jp _fmul
	jp _fneg
	jp _fsub
	jp _FLTMAX
	jp _sqrtf
	jp _frbtof
	jp _frftob
	jp _frftoub
	jp _frftoi
	jp _frftoui
	jp _frftos
	jp _frftous
	jp _fritof
	jp _fruitof
	jp _frstof
	jp _frubtof
	jp _frustof

	jp _ResetPorts
;   Doesn't seem to be used by TI-OS - breakpoint did nothing
;   Is only called directly in the bootcode by a function at 32F4h
;   TODO: investigate more
	jp _ChkIfOSInterruptAvailable
;   Checks if OS is valid and ready to receive an interrupt
;   Returns nz if not ready or z if ready
; https://www.winbond.com/resource-files/w29gl032c_revh%20v3.0.pdf
; these normally contain some safety measures
; but who cares about those
; some notes about flash:
; you have to set a port, then read a special sequence from flash itself - see wikiti
; also, while programming flash, you can't read code from flash, so you have to copy to RAM
; also, CEmu doesn't emulate flash remotely close to perfectly - either PR a fix or use CEmu's mem.c as a reference
	jp _WriteFlashByte
;   TODO: registers
	jp _EraseFlash
;   TODO: registers
	jp _EraseFlashSector
;   a = sector to erase
;   there's a bug in here where it pops one item too many from flash, I think
	jp _WriteFlash
;   de = dest, hl = data, bc = size
	jp _WriteFlashByteDuplicate
;   identical to _WriteFlashByte
	jp _WriteFlashA
	jp _CleanupCertificate
;   TODO
	jp _ClrHeap
;   Empties out the OS heap
;   I think that only the bootcode directly accesses the heap, so you can implement it any way you want
	jp _CpyToHeap
;   TODO: determine which registers are used
	jp _ChkHeapTop
;   Probably returns the size of the heap in hl and the bottom of the heap in de?
	jp _ExecuteInRAM
	jp _ExecuteInRAM
	jp _ExecuteInRAM
;   TODO: determine registers
	jp _ChkCertSpace
	jp _GetFieldSizeFromType
	jp _FindFirstCertField
	jp _FindField
	jp _FindNextField
	jp _GetCertificateEnd
	jp _GetFieldSizeFromType
	jp _GetFieldFromSize
	jp _NextFieldFromSize
	jp _NextFieldFromType
	jp _GetOffsetToNextField
	jp _WriteFlashUnsafe
	jp _boot_GetCertCalcString
	jp _boot_GetCertCalcID
	jp _GetSerial
	jp _riemann
;   called from within bootcode at 1057h
;   called at 40D55h
;   seems to have something to do with the certificate
	jp _Mult16By8
	jp _Div16By8
	jp _Div16By16
	jp _Div32By16
	jp _CmpStr
	jp _boot_Sha256Init
	jp _boot_Sha256Part
	jp _boot_Sha256Hash
	jp _FindAppHeaderSubField
	jp _FindSimpleGroupedField
;   seems related to SHA and the certificate
;   maybe part of OS verification?
;   only called directly by boot code @ 12CEEh
	jp _FindAppHeaderTimestamp
	jp _boot_ClearVRAM
	jp _boot_PutS
	jp _PutSpinner
	jp _boot_GetLFontPtr
	jp boot_setup_hardware
	jp _boot_TurnOffHardware
	jp _MakeColCmd
	jp _boot_NewLine
	jp _PutBootVersion
	jp _DrawSectorProtectionTable
	jp _boot_Set6MHzMode
	jp _boot_Set48MHzMode
	jp _boot_Set6MHzModeI
	jp _boot_Set48MHzModeI
	jp _CheckHardware
	jp _GetBatteryStatus
	jp boot_Delay10ms
;   wait 10 ms
	jp boot_Delay10timesAms
;   wait 10 * a ms
; bunch of undocumented functions that crash the calc if ports are wrong
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting and after turning off
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
;   used in many places by both boot code and OS
;   breakpoint triggers shortly after restarting
;   may be related to auto-power-down
;   sets a bunch of ports
;   resets if ports are wrong
	jp _riemann
	jp _riemann
	jp _riemann
	jp _riemann
	jp usb.IsBusPowered
	jp _KeypadScan
	jp _KeypadScanFull
	jp _riemann
	jp _riemann
	jp _MarkOSInvalid
	jp usb.BusPowered
	jp usb.SelfPowered
	jp usb.ByteSwapCopy
	jp usb.ByteSwapStore
	jp usb.ResetChip
	jp usb.Get76FC
	jp usb.SetDeviceB
	jp usb.400
	jp usb.DmaCxWriteNext
	jp usb.DmaCxRead
	jp usb.DmaCxWrite
	jp usb.DmaCxReadNext
	jp usb.DmaCxTryRead
	jp usb.ResetConfig
	jp usb.41C
	jp usb.420
	jp usb.HandleOsBeginPkt
	jp usb.HandleOsHdrPkt
	jp usb.HandleOsDataPkt
	jp usb.SendOsAckPkt
	jp usb.HandleEotPkt
	jp usb.SendErrPkt
	jp usb.SendParamDataPkt
	jp usb.StorePidHeader
	jp usb.ByteSwapCopyWord
	jp usb.448
	jp usb.HandleDelayAckPkt
	jp usb.450
	jp usb.TranslateError
	jp usb.HandleErr
	jp usb.450
	jp _MarkOSValid
	jp usb.SendPkt
	jp usb.468
	jp usb.46C
	jp usb.ResetTimer2Timeout
	jp usb.HandleInvalidPkt
	jp usb.HandleBufReqPkt
	jp usb.HandleBufAllocPkt
	jp usb.HandleDataPkt
	jp usb.HandleAckPkt
	jp usb.RecvDataChk
	jp usb.SendDataChk
	jp usb.RecvData
	jp usb.SendData
	jp usb.SetupRecvXfer
	jp usb.SetupSendXfer
	jp usb.HandleXfer
	jp usb.DefaultHandler
	jp usb.SetDmaCtrl
	jp usb.DmaXfer
	jp usb.DmaCxWait
	jp usb.DevRecvPkt
	jp usb.4B8
	jp usb.ResetFifos
	jp usb.HandleVirtPkt
	jp usb.4C4
	jp usb.4C8
	jp usb.AllocOutgoingPkt
	jp usb.AllocIncomingPkt
	jp usb.AllocBuf
	jp usb.FreeBuf
	jp usb.SetupTimer2
	jp usb.XferTimeoutHandler
	jp usb.SetupTimer3NoHandler
	jp usb.TimeoutErrorHandler
	jp usb.RestoreTimer3Timeout
	jp usb.ResetTimers
	jp usb.DisableTimers
	jp usb.EnableTimers
	jp usb.SetupTimer1
	jp usb.500
	jp usb.Free
	jp usb.Alloc
	jp usb.50C
	jp usb.510
	jp usb.514
	jp _riemann
	jp _riemann
	jp _boot_SetTimersControl
	jp _boot_GetTimersControl
	jp _boot_SetTimersInterrupt
	jp _boot_GetTimersInterrupt
	jp _boot_SetTimersInterruptM
	jp _boot_GetTimersInterruptM
	jp _boot_SetTimer1Counter
	jp _boot_GetTimer1Counter
	jp _boot_SetTimer1ReloadValue
	jp _boot_GetTimer1ReloadValue
	jp _boot_SetTimer1MatchValue1
	jp _boot_GetTimer1MatchValue1
	jp _boot_SetTimer1MatchValue2
	jp _boot_GetTimer1MatchValue2
	jp _boot_SetTimer2Counter
	jp _boot_GetTimer2Counter
	jp _boot_SetTimer2ReloadValue
	jp _boot_GetTimer2ReloadValue
	jp _boot_SetTimer2MatchValue1
	jp _boot_GetTimer2MatchValue1
	jp _boot_SetTimer2MatchValue2
	jp _boot_GetTimer2MatchValue2
	jp _CheckIfEmulated
	jp _boot_GetOnInt
	jp _boot_RTCIntHandler
	jp _boot_RTCInitialize
	jp _boot_RTCGetInitStatus
	jp _boot_RTCEnable
	jp _boot_RTCDisable
	jp _boot_RTCSet24Hours
	jp _riemann
	jp _riemann
	jp _boot_RTCAckAlarmInt
	jp _riemann
	jp _boot_RTCWriteTime
	jp _boot_RTCGetTime12Hour
	jp _boot_RTCGetTime
	jp _boot_RTCSetTime
	jp _boot_RTCGetAlarm
	jp _boot_RTCSetAlarmSafe
	jp _boot_RTCCheckAlarmInt
	jp _boot_RTCSetAlarmInt
	jp _boot_RTCIsAfternoon
	jp _boot_RTCGetDay
	jp _boot_RTCSetAlarmIntSafe
	jp _boot_RTCSetAlarm
	jp _boot_RTCEnableInt
	jp _boot_RTCDisableInt
	jp _boot_RTCSetCallback
	jp _boot_RTCResetTimeStruct
	jp _riemann
	jp _boot_RTCSetFlags
	jp _riemann
	jp _CheckEmulationBit
	jp usb.SetDmaAddress
	jp usb.5FC
	jp _boot_SectorsBegin
	jp usb.604
	jp usb.InEndpointClrStall
	jp usb.InEndpointSetStall
	jp usb.InEndpointClrReset
	jp usb.InEndpointSetReset
	jp usb.InEndpointSendZlp
	jp usb.OutEndpointClrStall
	jp usb.OutEndpointSetStall
	jp usb.OutEndpointClrReset
	jp usb.OutEndpointSetReset
	jp usb.SetFifoMap
	jp usb.SetEndpointConfig
	jp usb.ClrEndpointConfig
	jp usb.SetFifoConfig
	jp usb.ResetHandler
	jp spi.Read
	jp spi.WriteCmd
	jp spi.WriteParam
	jp _riemann
	jp _riemann
	jp _riemann
assert $ = $658
