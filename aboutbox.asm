_words_ struct			
  char	CHAR	?		
  x		DWORD	?		
  y		DWORD	?		
  ex		DWORD	?		
  ey		DWORD	?		
  pcount	BYTE	?
_words_ ends


IFDEF USE_JPG			
	USE_IMAGE = 1			
ELSEIFDEF USE_BMP			
	USE_IMAGE = 1		
ENDIF					


.const
	aWidth			equ	400
	aHeight			equ	175

	aStandartDelayTime	equ	2500	

	aStartXPos			equ	30	
	aStartYPos			equ	10	

.data

	ahDC			dd	0	
	ahBmp			dd	0	
	
	IFDEF USE_BRUSH			
		ahBrush	dd	0	
	ENDIF
	
	ahFont 		dd	0	
  
	aWnd			dd	0	
	aMainDC		dd	0	
						

	IFDEF USE_IMAGE			
		ahBitmap	dd	0	
		ahBitmapDC	dd	0
	ENDIF

	aThread		dd	0	

	awords 		dd	0	

	aGlobalStop		BOOL	FALSE	

	aDelayTime		dd	0	
	
	aRandSeed		dd	0	
	
	aStartPos		dd	0	
	aEndPos		dd	0	
						
						
						
						
						
						
						
						
						
						
						
	astrLen		dd	0	


	szaFontName		db	"COURIER NEW",0
	szaTitle		db	"ab0utb0x", 0	
	
	szaText	db	13,13,13,13
		db  "  P E R Y F E R i A H    k L A N   ",8
		db      13,13,13
		db  "   Target     : ExamXML 5.51     ",13
		db  "   Cracker    : MaryNello        ",13
		db  "   Date       : o4.1o.2o22       ",13
		db  "   Protection : Custom           ",8
 		db	13,13
 		db	"   10x 2:                        ",13,13
		db  "   r0ger 4 CooL GFX              ",13
		db  "   Zalza 4 CooL Music            ",13
 		db	"   x0man 4 CooL About Template   ",8
 		
 		db	"  Greets 2:                      ",13,13
 		db	"  Al0hA...................[PRF]  ",13
 		db	"  r0ger...................[PRF]  ",13
 		db  "  DAViiiiDDDDDDD..........[PRF]  ",13
		db  "  B@TRyNU.................[PRF]  ",13
 		db	"  r0bica..................[PRF]  ",13
		db  "  ShTEFY..................[PRF]  ",13
 		db	"  GRUiA^neinfricatul......[PRF]  ",13
 		db	"  WeeGee..................[PRF]  ",13
 		db	"  st3fan(C)ADR!AN.........[PRF]  ",8,13

 		db	"  yMRAN...................[PRF]  ",13
 		db  "  Gyahnni.................[PRF]  ",13
 		db  "  sabYn...................[PRF]  ",13
 		db  "  s0r3l...................[PRF]  ",13
 		db  "  aMaLiaVerSace...........[PRF]  ",13
 		db  "  bDM10...................[PRF]  ",13
 		db  "  oViSpider...............[PRF]  ",13
 		db  "  zzLaTaNN................[PRF]  ",13
 		db  "  ........and other PRF memberz  ",8
 		db	13
 		db	"  also                           ",13,13
 		db	"  Cachito................[TSRh]  ",13
 		db	"  Roentgen...............[TSRh]  ",13
 		db	"  kao..........................  ",13
 		db  "  Intel Core 2 Extreme.........  ",13
 		db  "  rooster1...............[TSRh]  ",13
 		db  "  Talers.................[TSRh]  ",13
 		db  "  Xylitol.................[RED]  ",8
 		db  13,13
 		db  "  Bang1338..............[BGSPA]  ",13
 		db  "  Bl4ckCyb3rEnigm4........[UST]  ",13
 		db  "  Log0.........................  ",13
 		db  "  Dilik........................  ",13
 		db  "  kEy-tONe.....................  ",13
 		db  "  Vad1m........................  ",8
 		db  13,13,13,13
 		db  "    and other positive ppl =)      ",8
 		db	13,13
 		db	"  ig      : @r0ger888.............  ",13
 		db  "          : @marian_andr..........  ",13
		db  "  discord : r0ger#2649............  ",13
		db  "  telegram: t.me/r0ger888.........  ",13
 		db	"  github  : r0ger888..............  ",8,0
			

.code

TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, sDim
    sub eax, wDim

    ret

TopXY endp

GetLinesCount proc
	
	push ecx
	push edx
	
	xor eax, eax
	xor ecx, ecx
	mov edx, offset szaText

	.repeat
		
		.if (byte ptr [edx + ecx] == 8)
			inc eax
		.endif

		inc ecx
	.until ecx >= astrLen
	
	pop edx
	pop ecx

	ret
GetLinesCount endp

SEPos proc

	push ecx
	push edx
	
	mov ecx, aStartPos
	mov edx, offset szaText
	
	.repeat
		
		.if (byte ptr [edx + ecx] == 8)
			mov aEndPos, ecx
			jmp @ex
		.endif

	inc ecx
	.until ecx > astrLen
	
	
@ex:	pop edx
	pop ecx
	
	ret
SEPos endp

Init_Proc proc

	mov aGlobalStop, FALSE
	
	push aStandartDelayTime
	pop aDelayTime

	invoke GetDC, aWnd
	mov aMainDC, eax
	
	invoke CreateCompatibleDC, 0
	mov ahDC, eax

	; creating bitmap using ahDC
	invoke CreateBitmap, aWidth, aHeight, 1, 32, NULL
	mov ahBmp, eax

	; creating font
  	invoke CreateFont, 16, 0, 0, 0, 400, 0, 0, 0,
					DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
					DEFAULT_QUALITY, DEFAULT_PITCH, addr szaFontName
	mov ahFont, eax

	; assign ahDC with other variables
	invoke SelectObject, ahDC, ahBmp
	invoke SelectObject, ahDC, ahFont
	
	; set the color of the text
	invoke SetTextColor, ahDC, White

	;...and the color of the background
	IFDEF USE_BRUSH
		invoke CreateSolidBrush, 00000000h
		mov ahBrush, eax
		
		invoke SelectObject, ahDC, eax
	ENDIF
	
	; you can either set the JPG/BMP image as a background for this aboutbox , just to make sure it has the same dimensions as the aboutbox's.
	IFDEF USE_IMAGE
	
		IFDEF USE_JPG
			invoke BitmapFromResource, 0, 550
		ELSEIFDEF USE_BMP
			invoke GetModuleHandle, 0
			invoke LoadBitmap, eax, 550
		ENDIF
	
	mov ahBitmap, eax
	
	invoke CreateCompatibleDC, NULL
	mov ahBitmapDC, eax
	
	invoke SelectObject, ahBitmapDC, ahBitmap
	
	ENDIF
	
	invoke SetBkMode, ahDC, TRANSPARENT

	invoke lstrlen, addr szaText
	mov astrLen, eax

	inc eax

	imul eax, sizeof _words_
	
	invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, eax
	mov awords, eax

	ret
Init_Proc endp

Free_Proc proc

	IFDEF USE_IMAGE
		invoke DeleteObject, ahBitmap
		invoke DeleteDC, ahBitmapDC
	ELSEIFDEF USE_BRUSH
		invoke DeleteObject, ahBrush
	ENDIF

	invoke DeleteObject, ahBmp
	invoke DeleteObject, ahFont
		
	invoke DeleteDC, ahDC
	invoke DeleteDC, aMainDC
	
	invoke GlobalFree, awords

	ret
Free_Proc endp

Resort_Words proc
LOCAL xPos:DWORD, yPos:DWORD
	
	push aStartXPos
	pop xPos
	
	push aStartYPos
	pop yPos
	
	xor ecx, ecx
	mov ebx, offset szaText
	mov edi, awords
	
	assume edi : ptr _words_

	.repeat
		mov al, byte ptr [ebx + ecx]
		mov byte ptr [edi].char, al

		push xPos
		pop [edi].ex
		
		push yPos
		pop [edi].ey

		push aHeight
		pop [edi].x

		push yPos
		pop [edi].y

		mov [edi].pcount, 0
		
		add xPos, 10
		
		.if al == 13	
			push aStartXPos
			pop xPos
			
			add yPos, 14	

		.elseif al == 8	
			push aStartXPos
			pop xPos
			
			push aStartYPos
			pop yPos

		.endif
		
		add edi, sizeof _words_
		inc ecx
		
	.until ecx >= astrLen
	
	assume edi : ptr nothing
	
	ret
Resort_Words endp

;---------------------------------------

Draw proc
LOCAL aLinesCount	: DWORD	
LOCAL aLineNumber	: DWORD	
LOCAL await:BOOL			
LOCAL aNextLine:BOOL		
LOCAL aChangeDelayTime:BOOL	


	call GetLinesCount
	mov aLinesCount, eax

	mov aLineNumber, 1
	mov aStartPos, 0
	call SEPos
	
	push aStandartDelayTime
	pop aDelayTime

	assume edi : ptr _words_	
	mov edi, awords
	
	.repeat
	
		IFDEF USE_IMAGE
			invoke BitBlt, ahDC, 0, 0, aWidth, aHeight, ahBitmapDC, 0, 0, SRCCOPY
		ELSE
			invoke Rectangle, ahDC, 0, 0, aWidth, aHeight
		ENDIF
		
		mov await, TRUE
		
		mov edi, awords
		mov ecx, aStartPos

		mov eax, ecx
		imul eax, sizeof _words_
		add edi, eax

		.repeat
		
		.if aGlobalStop == TRUE
			jmp @@ex
		.endif

		
		.if [edi].char != 13 && [edi].char != 8
			
				push ecx	
				push edi

				invoke TextOut, ahDC, [edi].x, [edi].y, addr [edi].char, 1
				
				pop edi 
				pop ecx
		.endif
					
			mov eax, [edi].x
			.if eax != [edi].ex
				
				mov eax, [edi].x
				.if eax < [edi].ex
					inc [edi].x
				.else
					dec [edi].x
				.endif
				
			.endif
			
			mov eax, [edi].y
			.if eax != [edi].ey
			
				mov eax, [edi].y
				.if eax < [edi].ey
					inc [edi].y
				.else
					dec [edi].y
				.endif
				
			.endif
			
			mov eax, [edi].x
			mov edx, [edi].y				
			.if (eax != [edi].ex) || ( edx != [edi].ey)
				mov await, FALSE	
			.endif
				
			
			inc ecx
			add edi, sizeof _words_
			
		.until (ecx >= aEndPos) || (ecx >= astrLen)
		
		invoke BitBlt, aMainDC, 0, 0, aWidth, aHeight, ahDC, 0, 0, SRCCOPY
				

			.if await == TRUE
			
				mov aNextLine, TRUE
				mov aChangeDelayTime, TRUE

				push edi
				push ecx
				
				invoke GetTickCount
				mov ecx, eax
				

				.repeat
				.if aGlobalStop
					jmp @@ex
				.endif
					
					push ecx
					invoke BitBlt, aMainDC, 0, 0, aWidth, aHeight, ahDC, 0, 0, SRCCOPY
					invoke GetTickCount
					pop ecx
					
					sub eax, ecx
					
				.until eax >= aDelayTime
				
				mov edi, awords
				mov ecx, aStartPos
				
				mov eax, ecx
				imul eax, sizeof _words_
				add edi, eax

				inc [edi].pcount

				.if ( [edi].pcount != 2)
					mov aNextLine, FALSE
				.endif

				.if ([edi].pcount != 1)
					mov aChangeDelayTime, FALSE
				.endif
			
				.repeat
					.if aGlobalStop == TRUE
						jmp @@ex
					.endif
					
					push aHeight
					pop [edi].ey	
					
					add edi, sizeof _words_					
					inc ecx
				.until (ecx >= aEndPos) || (ecx >=astrLen)

				pop ecx
				pop edi
								
				.if aNextLine == TRUE					
					inc aLineNumber
					
					push aStandartDelayTime
					pop aDelayTime
					
					push aEndPos
					pop aStartPos
					
					inc aStartPos
					
					call SEPos
				.endif
				
				.if aChangeDelayTime
					xor eax, eax
					mov aDelayTime, eax
				.endif
						
				mov eax, aLinesCount
				.if aLineNumber > eax

					mov aLineNumber, 1	
					mov aStartPos, 0		

					push aStandartDelayTime
					pop aDelayTime
					
					call Resort_Words
					call SEPos
				.endif

			.endif
	
	.until aGlobalStop == TRUE
	
	@@ex:
	
	mov aGlobalStop, FALSE

	xor eax, eax
	ret
Draw endp

AboutProc proc yWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL x
LOCAL y
LOCAL rect:RECT

	mov eax, uMsg
	
	.if eax == WM_INITDIALOG
			
		push yWnd
		pop aWnd
		
		invoke GetSystemMetrics, SM_CXSCREEN
		invoke TopXY, aWidth, eax
		mov x, eax
		
		invoke GetSystemMetrics, SM_CYSCREEN
		invoke TopXY, aHeight, eax
		mov y, eax
		
		invoke SetWindowPos, yWnd, 0, x, y, aWidth, aHeight, SWP_SHOWWINDOW
		
		;invoke CreateRoundRectRgn, 1, 0, aWidth, aHeight, 50, 50
		;invoke SetWindowRgn, hWnd, eax, TRUE
		
		invoke SetWindowText, yWnd, addr szaTitle
		call Init_Proc
		
		call Resort_Words

		invoke CreateThread, NULL, 0, addr Draw, 0, 0, addr aThread

	.elseif eax == WM_LBUTTONDOWN
		invoke SendMessage, yWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
				
	.elseif eax == WM_RBUTTONUP		
		invoke SendMessage, yWnd, WM_CLOSE, 0, 0

	.elseif eax == WM_CLOSE
	
		mov aGlobalStop, TRUE
		
		.repeat
			invoke Sleep, 1
		.until aGlobalStop == FALSE
		
		call Free_Proc
		invoke EndDialog, yWnd, 0
		
	.endif
	
	xor eax, eax
	ret
AboutProc endp
