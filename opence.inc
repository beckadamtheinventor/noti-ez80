
define oce? oce
namespace oce

?identifier_location     := $7F0 ; the 16 bytes starting here must be the null-terminated string,
                                 ;"OpenCE bootcode", otherwise you are not running this revision of the OpenCE bootcode.

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


; RAM equates

?textColors              := $D18879 ;only must be used when working with internal graphics routines and puts/c


end namespace
