

comment &
   funkcija f(X, Y):
   (3X(Z^2)-(Y^3)+4) / (-2X-(Y^2)Z+1)
   (3*-2*1^2--1^3+4) / (-2 * -2 - -1^2 * 1 + 1)
&

.386
.model flat, stdcall
option casemap:none

include    \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.stack   4096

.const
    x        byte  -2
    y        db    -1  ; byte un db - viens efekts 
    z	       byte   1

.data
whole    word   ?
rem      dw     ?  ; word un dw - viens efekts

.code
start    proc
         
	 mov  al, y
     imul al      ; y^2 (word)
     mov  bx, ax
     mov  al, y
     cbw
     imul bx      ; y^3 (double word)
	 neg  ax
     add  ax, 4   ; y^3 + 4
     mov  bx, ax  ; y^3 + 4 is now in bx
	 mov  al, z   ;
	 imul al      ; z^2 in ax
	 mov  dx, ax  ; z^2 in dx
     mov  al, x
     imul dx      ; ax = xz^2
     mov  dx, ax  ; xz^2 in dx
	 mov  al, 3
	 imul dx      ; ax = 3xz^2 
	 add  ax, bx   ; ax = 3xz^2 - y^3 - 4
	 mov  dx, ax  ; store A branch result
	 	 
	 mov   al, y
     imul  al      ; ax = y^2
	 mov   bx, ax
	 mov   al, z
	 cbw
     imul  bx      ; ax = y^2 * z
	 neg   ax	   ; ax = - (y^2 * z)
	 inc   ax      ; ax = -(y^2 * z) + 1
	 mov   bx, ax
	 mov   cx, 2
     mov   al, x
	 cbw 
	 imul  cx      ; ax = 2*x
	 neg   ax      ; ax = -2*x
	 add   ax, bx  ; ax = -2x - y^2 * z + 1
	 
	 mov  bx, dx
	 xchg ax, bx
	 cwd
	 idiv bx
	
         push 0
         call ExitProcess
start    endp
         end start