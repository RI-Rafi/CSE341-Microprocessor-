.MODEL SMALL
\n macro
    mov ah, 2
    mov dx, 10
    int 21h
    mov dx, 13
    int 21h 
    endm
print macro str
    mov ah, 9
    lea dx, str
    int 21h 
endm 

.STACK 100H

.DATA

; declare variables here 
arr db 150 dup("?")
arr2 db 100 dup("?")
choice1 db "a. Count the frequency of vowels.$"
choice2 db "b. Check if a substring exists in the main string.$"
choice3 db "c. Remove consonants from the string.$"
promt1 db "Input choice: (a, b or c)$"
choice db  ?
enter db "Enter a string: $" 
output1 db "Frequency of the Vowels: $"
substrng db "Enter substring: $" 
promt2 db "String without consonants: $" 
str2 dw ?
invalid db "Invalid choice...$"
yes db "Yes, this substring exists.$"
no db  "NO, this substring doesn't exist.$"
.CODE
MAIN PROC

; initialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here

print promt1 
\n
\n
print choice1 
\n
print choice2
\n
print choice3
\n
mov ah, 1
int 21h
mov choice , al

mov si, 0 
print enter
input_str: 
    mov ah, 1
    int 21h 
    cmp al, 0dh
    je operation
    mov arr[si], al
    inc si 
  loop input_str
input_substr:
    \n
    print substrng
    inp:
    mov ah, 1
    int 21h 
    cmp al, 0dh
    je substr
    mov arr2[si], al
    inc si 
  loop inp
operation:
    mov si, 0 
    cmp choice, 61h
    je vow
    cmp choice, 62h
    je input_substr
    cmp choice, 63h
    je rmv
    \n
    print invalid
    jmp exit

vow:
    \n
    call vowel
    jmp exit 
substr:
\n
and cx, 0
mov cx, si 
mov str2,cx
\n
    call substring
    jmp exit
rmv: 
\n
    call remove
exit:
   
;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
vowel proc
    and bx, 0
    compare:
        mov al, arr[si]
        inc si
        cmp al, 3fh
        je finish
        jmp vowl
       loop compare 
       
      vowl:
        cmp al, 61h
        je increment
                cmp al, 65h
        je increment
                cmp al, 69h
        je increment
                cmp al, 6fh
        je increment
                cmp al, 75h
        je increment
        cmp al, 41h
        je increment
        cmp al, 45h
        je increment
        cmp al, 49h
        je increment
        cmp al, 4fh
        je increment
        cmp al, 55h
        je increment
        jmp compare
      increment:
           inc bl
           jmp compare
    finish:
    \n
        print output1
        mov ah, 2
        add bl, 30h
        mov dl, bl
        int 21h
        ;jmp exit
        ret   
    vowel endp 
substring proc
     and si, 0
     ;mov cx, str2
     and di, 0
     sstr:
        mov al, arr[si] 
        mov bl, arr2[di]
        cmp al, bl
        je str_chk
        cmp al, 3fh
        je print_no
        inc si
        jmp sstr
        str_chk:
            inc si
            inc di
            cmp di, str2
            jge print_yes
            mov al, arr[si]
            mov bl, arr2[di]
            cmp al, bl
            je str_chk
            mov di, 0
            jmp sstr
        print_no:
             mov ah, 9
             lea dx, no
             int 21h
             jmp exit
          print_yes:
          mov ah, 9
          lea dx, yes
          int 21h 
            ret
    substring endp
remove proc 
    \n 
    print promt2
       compare2:
        mov al, arr[si]
        inc si
        cmp al, 3fh
        je finish2
        jmp vowl2
       loop compare2 
       
      vowl2:
        cmp al, 61h
        je com
                cmp al, 65h
        je com
                cmp al, 69h
        je com
                cmp al, 6fh
        je com
                cmp al, 75h
        je com
        cmp al, 41h
        je com
        cmp al, 45h
        je com
        cmp al, 49h
        je com
        cmp al, 4fh
        je com
        cmp al, 55h
        je com
         
        cmp al, 20h
        je com
        jmp compare2
      com: 
           mov ah, 2 
           mov dl, al
           int 21h
           jmp compare2
      finish2:
      ;jmp exit 
      ret
    remove endp
    END MAIN