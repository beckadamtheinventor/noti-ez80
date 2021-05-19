
define noti? noti
namespace noti

?identifier_location     := $7F0 ; the 14 bytes starting here must be the null-terminated string,
                                 ;"noti bootcode", otherwise you are not running this revision of the noti-ez80 bootcode.

; jump table

?waitKeyCycle            := $700
?setVRAM                 := $704
?setBuffer               := $708
?gfx_Compute             := $70C
?gfx_Horizontal          := $710
?gfx_Vertical            := $714
?gfx_Rectangle           := $718
?gfx_FilledRectangle     := $71C
?homeUp                  := $720
?putS                    := $724
?putC                    := $728
?putSAndNewLine          := $72C
?drawStatusBar           := $730
?blitBuffer              := $734
?JumpToLibload           := $738
?clearVRAM               := $73C
?clearBuffer             := $740
?_UsbPowerVbus           := $744
?_UsbUnpowerVbus         := $748
?_LoadLibraryOP1         := $74C
?_CpHLDE                 := $750
?_LoadDEInd_s            := $754
?_SetHLUTo0              := $758

; second half of jump table

?num_of_extra_jumps      := $800

; RAM equates

?textColors              := $D18879 ;only must be used when working with internal graphics routines and puts/c


end namespace
