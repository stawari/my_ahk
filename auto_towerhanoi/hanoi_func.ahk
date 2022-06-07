
show_dict(debugdict){
    for k, v in %debugdict%    
        OutputDebug % k " : " v
    return
}

show_dot(x,y, name){
    Gui, %name%:New, +AlwaysOnTop -Caption, 
    Gui, %name%:Show, w5 h5 x%x% y%y%, 
    return
}

show_t(name){
    show_dot(t_dict[name].x,t_dict[name].y,name)
    return
}

check_ready(ready_img){
    return check_image(ready_img) 
}

check_image(img_local){
    
    ImageSearch, Img_X, Img_Y, 0, 0, A_ScreenWidth, A_ScreenHeight, %img_local%
    OutputDebug, %img_local% "=>" %ErrorLevel%
        if(ErrorLevel=0)
            {
                return [Img_X+15, Img_Y+5]
            }
        else{
            return False
            }
            
}

get_first_t(){

    ImageSearch, Img_X, Img_Y, 0, 0, A_ScreenWidth, A_ScreenHeight, %T1_IMG%
    if(ErrorLevel=0)
    {
        return [Img_X+15, Img_Y+5]
    }
    else{
        MsgBox Can't find the first T, Exit..
        ExitApp
    }
}

make_tdict(firstxy_t, t_num=3){
    t_dict:={}
    yplus := 0
    loop, %t_num% {
        t_dict["t" A_index]:= {"name": "t" A_index, "x":firstxy_t.1, "y":firstxy_t.2 + yplus}
        yplus+=18
    }
    return t_dict
}

make_coldict(firstxy_t, t_num=3){
    coldict := {}
    xplus := 0
    loop, 3{
        if (a_index=1)
            coldict["col" a_index]:={"name": "col"a_index ,"x": firstxy_t.1 + xplus, "y":firstxy_t.2, "hold": t_num}
        else
            coldict["col" a_index]:={"name": "col"a_index ,"x": firstxy_t.1 + xplus, "y":firstxy_t.2, "hold":0}
        xplus += 160
    }
    return coldict
}

moveto(tname , colfrom, colto){
    ;data => tdata | colfrom.3 | colto1/2/3
    OutputDebug %tname% "|" %colfrom% "=>" %colto%
    MouseClickDrag, left, t_dict[tname].x, t_dict[tname].y, col_dict[colto]["x"], col_dict[colto]["y"], 5
    if (col_dict[colto]["hold"] = 0)
    {
        t_dict[tname].x := col_dict[colto]["x"]
        t_dict[tname].y := t_dict_ro["t"t_dict.Count()].y
    }
    else
    {
        t_dict[tname].x := col_dict[colto]["x"]
        num := t_dict.Count() - col_dict[colto]["hold"] 
        ;MsgBox % t_dict_ro["t" num]["y"]
        t_dict[tname].y := t_dict_ro["t"num].y

    }
    col_dict[colto]["hold"] += 1
    col_dict[colfrom]["hold"] -= 1

    return
}

tower_move(n, start, end, middle){
    if !running 
        return
    if (n=1){
        OutputDebug, Move %n% from tower %start% to %end%
        moveto("t" n,start,end)
    } 
    else {
        ;sleep, 100
        outputDebug, N = %n% truoc khi vao ham-1
        tower_move(n-1, start, middle, end)
        outputDebug, Move %n% from tower %start% to %end%
        moveto("t" n,start,end)
        outputDebug, N = %n% sau khi qua buoc 1
        tower_move(n-1, middle, end, start)
    }
    return
}