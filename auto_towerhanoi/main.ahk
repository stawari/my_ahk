#Include, <basic_default>
#Include, hanoi_func.ahk

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

global IMG_T1:="t1.png"

t_num:=3
global t_dict_ro := make_tdict(get_first_t(),t_num)
global t_dict := make_tdict(get_first_t(),t_num)
global col_dict:=make_coldict(get_first_t(),t_num)


tower_move(t_num, "col1", "col3","col2")

