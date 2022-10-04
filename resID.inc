include		windows.inc 
include		kernel32.inc 
include		user32.inc 
include     gdi32.inc  
include 	shell32.inc
include		winmm.inc
include		masm32.inc
include		msvcrt.inc
include		comctl32.inc
include		oleaut32.inc
include		ole32.inc
include		advapi32.inc
include		comdlg32.inc
include     /masm32/macros/macros.asm

includelib	kernel32.lib
includelib	user32.lib 
includelib 	gdi32.lib
includelib 	shell32.lib
includelib	winmm.lib
includelib 	masm32.lib
includelib	msvcrt.lib
includelib	comctl32.lib
includelib  oleaut32.lib
includelib  ole32.lib
includelib	advapi32.lib
includelib	comdlg32.lib

include btnt.inc

include bassmod.inc
includelib bassmod.lib

DlgProc					PROTO	:DWORD,:DWORD,:DWORD,:DWORD
FadeOut					PROTO	:DWORD
MakeDialogTransparent	PROTO	:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDD_ABOUT	equ	2000
IDB_EXIT	equ	1001
IDB_COPY	equ	1002
IDB_ABOUT	equ	1003
IDC_MAIL	equ	1004
IDC_SERIAL	equ	1005

.data
include nws.inc
WindowTitle	db	"ExamXML 5.51 KeyGen",0
DefaultMail	db	"y0_deejay@spindatshit.com",0
r3kt			RECT	<>
TxtFont		LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'terminal'>
TxtFont2		LOGFONT <12,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'courier'>
DELAY_VALUE			equ		6
Transparency		dd		?
TRANSPARENT_VALUE	equ 254

.data?
hInstance		dd	?
xWnd			dd	?
hBrush			dd 	?
hFont			dd	?
hMail			dd	?
hSerial			dd	?
hIMG			dd  ?
WndRect			RECT	<>
XndRect			RECT	<>
YndRect			RECT	<>
MailRect		RECT	<>
SerialRect		RECT	<>
StaticRect		RECT	<>
nHeight    		dd ?
nWidth			dd ?