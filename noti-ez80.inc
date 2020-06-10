
define noti? noti
namespace noti

?identifier_location     := $7F0 ; the 16 bytes starting here must be the null-terminated string,
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
?unpackDynamicLibraries  := $738
?clearVRAM               := $73C
?clearBuffer             := $740

; second half of jump table

?num_of_extra_jumps      := $800
?_pushOP1                := $804
?_pushOP2                := $808
?_pushOP3                := $80C
?_pushOP4                := $810
?_pushOP5                := $814
?_pushOP6                := $818
?_popOP1                 := $81C
?_popOP2                 := $820
?_popOP3                 := $824
?_popOP4                 := $828
?_popOP5                 := $82C
?_popOP6                 := $830
?_mov9ToOP1              := $834
?_mov9ToOP2              := $838
?_mov9ToOP3              := $83C
?_mov9ToOP4              := $840
?_mov9ToOP5              := $844
?_mov9ToOP6              := $848
?_mov11b                 := $84C
?_mov9b                  := $850
?_mov8b                  := $858



; RAM equates

?textColors              := $D18879 ;only must be used when working with internal graphics routines and puts/c


end namespace
