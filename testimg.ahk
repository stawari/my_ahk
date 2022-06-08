#Include, <basic_default>
#Include, ShinsImageScanClass.ahk
CoordMode, Pixel, Screen
settitlematchmode, 1


scan := new ShinsImageScanClass()

if (scan.Image(".\auto_towerhanoi\img\t1.png",0,mX,mY)){
    ;msgbox % "found the img"
    MouseMove, mX, mY
}
else
    msgbox % "not found"