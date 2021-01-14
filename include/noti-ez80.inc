
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

; second half of jump table

?num_of_extra_jumps      := $800
?_PushOP1                := $804
?_PushOP2                := $808
?_PushOP3                := $80C
?_PushOP4                := $810
?_PushOP5                := $814
?_PushOP6                := $818
?_PopOP1                 := $81C
?_PopOP2                 := $820
?_PopOP3                 := $824
?_PopOP4                 := $828
?_PopOP5                 := $82C
?_PopOP6                 := $830
?_Mov9ToOP1              := $834
?_Mov9ToOP2              := $838
?_Mov9ToOP3              := $83C
?_Mov9ToOP4              := $840
?_Mov9ToOP5              := $844
?_Mov9ToOP6              := $848
?_Mov11b                 := $84C
?_Mov9b                  := $850
?_Mov8b                  := $854
?_CpHLDE                 := $858
?_EnoughMem              := $85C
?_InsertMem              := $860
?_LoadDEInd_s            := $864
?_SetHLUTo0              := $868

; RAM equates

?textColors              := $D18879 ;only must be used when working with internal graphics routines and puts/c


end namespace
