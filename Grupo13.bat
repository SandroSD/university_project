tasm /la /zi Final.asm
REM tasm /la /zi numbers.asm
tlink /3 Final.obj numbers.obj /v /s /m
del FINAL.OBJ
del FINAL.MAP
del FINAL.LST