; Assembly module to find maximum value in an array of float values
; CS G242
; Student name: Henry Ho

.686
.model flat

.code 

_max PROC						    ;name of fucntion

start:	
		push ebp                    ; save caller frame pointer
		mov ebp, esp                ; establish current frame pointer

		mov ebx, [ebp+8]	        ; store address of first array element into ebx
		mov ecx, [ebp+12]	        ; store the size of array into ecx
		xor edx, edx		        ; initialize loop counter edx to zero

		fld dword ptr[ebx]	        ; load first array element arrary onto st(0)
		inc edx                     ; increment loop counter in edx

loopMax:

		fld dword ptr[ebx+edx*4]	; load next array element onto st(1)
		fcom st(1)			        ; compare st(0) with st(1)
		
		fstsw ax			        ; copy the Status Word containing the result to AX
		fwait				        ; insure the previous instruction is completed
		sahf				        ; transfer the condition codes to the CPU's flag register
		
		ja lookNext			        ; if st(0) > st(1) jump to lookNext to continue with next array element
		fcomp 				        ; pop st(0) because new maximum is in st(1)
		                            ; after pop, the new max is again in st(0)

lookNext:
		inc edx				        ; increment counter in edx
		cmp ecx, edx		        ; compare array size in ecx with loop counter in edx
		jg loopMax			        ; if ecx > edx then jump to loopMax

		pop ebp                     ; restore caller frame pointer
		ret                         ; return contents of st(0)



_max ENDP

end
