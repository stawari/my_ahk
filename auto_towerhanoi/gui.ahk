#Include, <basic_default>
#Include, hanoi_func.ahk
; play game on https://mathsisfun.com/games/towerofhanoi.html
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

;VAR
; IMG
global NUM3_IMG:=".\img\3.png"
global NUM4_IMG:=".\img\4.png"
global NUM5_IMG:=".\img\5.png"
global NUM6_IMG:=".\img\6.png"
global NUM7_IMG:=".\img\7.png"
global T1_IMG:=".\img\t1.png"
global RESET1_IMG:=".\img\reset.png"
global READY1_IMG:=".\img\ready.png"

status:="Not Ready"
global running:=0

gui, font, s11, Consolas
Gui, Add, Button, x332 y99 w-1034 h-496 , Button
Gui, Add, Text, x22 y19 w170 h20 , Number of Tower in Game:
Gui, Add, Edit, x72 y49 w50 h20 vTowerNum, 
Gui, Add, Button, x12 y79 w160 h30 gCheckTower, Check Tower
Gui, Add, Button, x12 y150 w100 h30 gBreset, Reset
Gui, Add, Button, x+20 w100 h30 gBshow_t , Show
Gui, Add, Button, x+20 w100 h30 gBsolve , Solve
Gui, Add, Button, x+20 w100 h30 gBstop , Stop
gui add, StatusBar,, 
SB_SetParts(100) 
SB_SetText("AutoHNTower", 1) ; settext for part 1
SB_SetText("Status: " status,2) 
SB_SetText("0%",3)

; Generated using SmartGUI Creator 4.0
Gui, Show, x1770 y727 h230 w479, AutoHNTower
Return

CheckTower:
    if !(WinExist("Play Tower of Hanoi"))
    {
        MsgBox % "please active the game"
        return
    }
    if (check_image(NUM3_IMG))
        numberoftower:=3
    else if (check_image(NUM4_IMG))
        numberoftower:=4
    else if (check_image(NUM5_IMG))
        numberoftower:=5
    else if (check_image(NUM6_IMG))
        numberoftower:=6
    else if (check_image(NUM7_IMG))
        numberoftower:=7
    else
        numberoftower:=0
    GuiControl,,TowerNum, %numberoftower%

    SB_SetText("Status: Getting Data" ,2)
    global t_dict_ro := make_tdict(get_first_t(),numberoftower)
    global t_dict := make_tdict(get_first_t(),numberoftower)
    global col_dict:=make_coldict(get_first_t(),numberoftower)
    sleep, 500
    SB_SetText("Status: Done Getting Data" ,2)

    if (check_ready(READY1_IMG)){
        status:="READY"
        SB_SetText("Status: " status ,2)
    }
    else{
        SB_SetText("Status: Not Ready, please reset" ,2)
    }

    ;TODO => check xong thi show dot + hoi correct chua, 
    ;📝 confirm thi set la ready

return

Breset:
    areset := check_image(RESET1_IMG)
    if areset{
        MouseGetPos, cX, cY
        MouseClick, left, areset.1, areset.2
        MouseMove, cX, cY
    }
    else
        SB_SetText("Status: Can not reset..." status,2) 
return

Bshow_t:
return

Bsolve:
    running := !running
    tower_move(numberoftower, "col1", "col3", "col2")
return

Bstop:
running := !running
return

GuiClose:
ExitApp

GuiEscape:
ExitApp, 

Esc::Goto, Bstop
