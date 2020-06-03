;void _boot_SetTimersControl(uint16_t value);
_boot_SetTimersControl:
	push hl
	ld hl,6
	add hl,sp
	ld hl,(hl)
	push bc
	ld bc,$7030
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

;uint16_t _boot_GetTimersControl(void);
_boot_GetTimersControl:
	push bc
	ld bc,$7030
	call _boot_InBC_s
	pop bc
	ret

;void _boot_SetTimersInterrupt(uint16_t value);
_boot_SetTimersInterrupt:
	push hl
	ld hl,6
	add hl,sp
	ld hl,(hl)
	push bc
	ld bc,$7034
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

;uint16_t _boot_GetTimersInterrupt(void);
_boot_GetTimersInterrupt:
	push bc
	ld bc,$7034
	call _boot_InBC_s
	pop bc
	ret


;void _boot_SetTimersInterruptM(uint16_t value);
_boot_SetTimersInterruptM:
	push hl
	ld hl,6
	add hl,sp
	ld hl,(hl)
	push bc
	ld bc,$7038
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

;uint16_t _boot_GetTimersInterruptM(void);
_boot_GetTimersInterruptM:
	push bc
	ld bc,$7038
	call _boot_InBC_s
	pop bc
	ret

;void _boot_SetTimer1Counter(uint16_t upper,uint16_t lower);
_boot_SetTimer1Counter:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7000
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

;uint32_t _boot_GetTimer1Counter(void);
_boot_GetTimer1Counter:
	push bc
	ld bc,$7000
	call _boot_InBC_s
	ex hl,de
	call _boot_InBC_s
	pop bc
_boot_rtc_HL_DE_to_EUHL:
	ld (ScrapMem),de ;bytes 0-1
	ld a,l ;byte 2
	ld e,h ;byte 3
	ld (ScrapMem+2),a ;byte 2
	ld hl,(ScrapMem) ;bytes 0-3
	ret

;void _boot_SetTimer1ReloadValue(uint16_t upper,uint16_t lower);
_boot_SetTimer1ReloadValue:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7004
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

;uint32_t _boot_GetTimer1ReloadValue(void);
_boot_GetTimer1ReloadValue:
	push bc
	ld bc,$7004
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL

;void _boot_SetTimer1MatchValue1(uint16_t upper,uint16_t lower);
_boot_SetTimer1MatchValue1:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7008
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret
	ret

;uint32_t _boot_GetTimer1MatchValue1(void);
_boot_GetTimer1MatchValue1:
	push bc
	ld bc,$7008
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL

_boot_SetTimer1MatchValue2:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$700C
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

_boot_GetTimer1MatchValue2:
	push bc
	ld bc,$700C
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL


_boot_SetTimer2Counter:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7010
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

_boot_GetTimer2Counter:
	push bc
	ld bc,$7010
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL


_boot_SetTimer2ReloadValue:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7014
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret


_boot_GetTimer2ReloadValue:
	push bc
	ld bc,$7014
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL


_boot_SetTimer2MatchValue1:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$7018
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

_boot_GetTimer2MatchValue1:
	push bc
	ld bc,$7018
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL


_boot_SetTimer2MatchValue2:
	push hl
	ld hl,6
	add hl,sp
	push bc
	push hl
	ld hl,(hl)
	ld bc,$701C
	call _boot_OutBC_s
	pop hl
	inc hl
	inc hl
	inc hl
	ld hl,(hl)
	call _boot_OutBC_s
	pop bc
	pop hl
	ret

_boot_GetTimer2MatchValue2:
	push bc
	ld bc,$701C
	call _boot_InBC_s
	ex de,hl
	call _boot_InBC_s
	pop bc
	jq _boot_rtc_HL_DE_to_EUHL


_boot_RTCIntHandler:
;	ld hl,-1
;	call _frameset
;	ld sp,ix
;	pop ix
	ret


_boot_RTCInitialize:=_boot_RTCEnable


_boot_RTCGetInitStatus:
	ret


_boot_RTCEnable:
	push bc
	ld bc,$8020
	in a,(bc)
	set 0,a
	out (bc),a
	pop bc
	ret

_boot_RTCDisable:
	push bc
	ld bc,$8020
	in a,(bc)
	res 0,a
	out (bc),a
	pop bc
	ret

_boot_RTCSet24Hours:
	
	ret

_boot_RTCAckAlarmInt:
	push bc
	ld bc,$8034
	in a,(bc)
	set 4,a
	out (bc),a
	pop bc
	ret

_boot_RTCWriteTime:


_boot_RTCGetTime12Hour:


_boot_RTCGetTime:


_boot_RTCSetTime:


_boot_RTCGetAlarm:


_boot_RTCSetAlarmSafe:


_boot_RTCCheckAlarmInt:


_boot_RTCSetAlarmInt:


_boot_RTCIsAfternoon:


_boot_RTCGetDay:


_boot_RTCSetAlarmIntSafe:


_boot_RTCSetAlarm:


_boot_RTCEnableInt:


_boot_RTCDisableInt:


_boot_RTCSetCallback:


_boot_RTCResetTimeStruct:


_boot_RTCSetFlags:
	ret

