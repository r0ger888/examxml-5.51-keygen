GenKey			PROTO	:DWORD
CharSwap		PROTO	:DWORD

.data
PRFKLAN 		db "?P?R?F?K?L?A?N??????",0
Charset 		db "MOYL0PIXL4AC65US19QHZDV2S8GTRW3FRJB7JEKN",0
MailBuffer 		db 30h dup(0)
FinalBuff 		db 0
hardcored_char1 db 0
hardcored_char2 db 0
hardcored_char3 db 0
hardcored_char4 db 0
hardcored_char5 db 0
hardcored_char6 db 0
hardcored_char7 db 0
hardcored_char8 db 0
hardcored_char9 db 0
hardcored_charA db 0
hardcored_charB db 0
hardcored_charC db 0
hardcored_charD db 0
hardcored_charE db 16h dup(0)
InitBuff 		db 0
custom_char1 	db 0
custom_char2 	db 0
custom_char3 	db 0
custom_char4 	db 0
custom_char5 	db 0
custom_char6 	db 0
custom_char7 	db 0

.code
GenKey proc near hWin:DWORD

		invoke GetDlgItemText,hWin,IDC_MAIL,offset MailBuffer,48
		.if eax == 0
			invoke GetDlgItem,hWin,IDB_COPY
			invoke EnableWindow,eax,FALSE
			invoke SetDlgItemText,hWin,IDC_SERIAL,offset PRFKLAN
			ret
		.endif
		
		invoke RtlZeroMemory,offset FinalBuff,96
		invoke RtlZeroMemory,offset InitBuff,16
		invoke CharSwap,offset MailBuffer
		
		xor esi, esi
		mov edi, offset MailBuffer

part_1:
		movzx eax, byte ptr [edi]
		test eax, eax
		jz part_2
		inc edi
		cmp eax, 20h
		jle part_1
		imul esi, 25h
		and esi, 0FFFFFFh
		add esi, eax
		jmp part_1

part_2:
		mov ebx, 9
		xor ecx, ecx

part_3:
		xor edx, edx
		mov eax, esi
		mov edi, 28h
		div edi
		shr esi, 5
		imul esi, ebx
		mov dl, Charset[edx]
		mov InitBuff[ecx], dl
		inc ecx
		cmp ecx, 8
		jb part_3
		mov al, InitBuff
		mov FinalBuff, al
		mov al, custom_char1
		mov hardcored_char2, al
		mov al, custom_char2
		mov hardcored_char4, al
		mov al, custom_char3
		mov hardcored_char6, al
		mov al, custom_char4
		mov hardcored_char8, al
		mov al, custom_char5
		mov hardcored_charA, al
		mov al, custom_char6
		mov hardcored_charC, al
		mov al, custom_char7
		mov hardcored_charE, al
		mov hardcored_char1, 50h
		mov hardcored_char3, 52h
		mov hardcored_char5, 46h
		mov hardcored_char7, 4Bh
		mov hardcored_char9, 4Ch
		mov hardcored_charB, 41h
		mov hardcored_charD, 4Eh
		; -----> hardcored result : PRFKLAN ;) (our signature)
		invoke RtlZeroMemory,offset InitBuff,16
		xor esi, esi
		mov edi, offset FinalBuff

part_4:
		movzx eax, byte ptr [edi]
		test eax, eax
		jz part_5
		inc edi
		cmp eax, 20h
		jle part_4
		imul esi, 25h
		and esi, 0FFFFFFh
		add esi, eax
		jmp part_4

part_5:
		mov ebx, 1
		xor ecx, ecx

finalserial:
		xor edx, edx
		mov eax, esi
		mov edi, 28h
		div edi
		shr esi, 5
		imul esi, ebx
		mov dl, Charset[edx]
		mov InitBuff[ecx], dl
		inc ecx
		cmp ecx, 5
		jb finalserial
		invoke lstrcat,offset FinalBuff,offset InitBuff
		invoke SetDlgItemText,hWin,IDC_SERIAL,offset FinalBuff
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,TRUE
		ret
		
GenKey endp

CharSwap proc near String:DWORD

		mov eax, [String]
		dec eax

swapstart:
		add eax, 1
		cmp byte ptr [eax], 0
		jz final
		cmp byte ptr [eax], 61h
		jb swapstart
		cmp byte ptr [eax], 7Ah
		ja swapstart
		sub byte ptr [eax], 20h
		jmp swapstart

final:
		mov eax, [String]
		ret
CharSwap endp


