MAX_FORWARD equ 6
M_PI_2_360 equ 0.017453292519943295 ; M_PI*2 / 360

perfptch:
    push rbp
    mov rbp, rsp
    sub rsp, 176

    ; check
    mov rax, [rip + sv_player] 
    mov eax, [rax + v_flags] 
    and eax, FL_ONGROUND
    test eax, eax
    jz .end

    ; calc angleval, sinval, cosval
    movsd xmm0, [rax + v_angles + YAW] 
    mulsd xmm0, [rip + M_PI_2_360] 
    call sin
    movsd [rbp - 8], xmm0 
    movsd xmm0, [rax + v_angles + YAW] 
    mulsd xmm0, [rip + M_PI_2_360] 
    call cos
    movsd [rbp - 16], xmm0 

    ; prep loop
    xor rcx, rcx ; i = 0

.loop:
    ; calc top and bottom vectors
    ; somehow ....

    ; call move + handle trace
    ; somehow ....

    ; store z[i] 
    ; if we even manage to get this far

    ; increment i and check loop
    inc rcx
    cmp rcx, MAX_FORWARD
    jl .loop

    ; second loop
    ; right ...

    ; set sv_player->v.idealpitch
    ; definitely not happening today

.end:
    add rsp, 176
    pop rbp
    ret
