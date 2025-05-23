#start=Traffic_Lights.exe#
name "traffic"
.MODEL SMALL
.STACK 100H

.DATA
; Traffic light situations
situation  DW 0000001100001100b
s1         DW 0000011010011010b
s2         DW 0000100001100001b
s3         DW 0000100001100001b
s4         DW 0000010011010011b
sit_end=$

all_red    EQU 0000001001001001b

; Emergency lane patterns
lane1_green EQU 0000001100001001b
lane2_green EQU 0000100001001001b
lane3_green EQU 0000001001100001b
lane4_green EQU 0000001001001100b   

lane1_4_green EQU 0000001100001100b
lane2_3_green EQU 0000100001100001b


walk_msg       DB 13,10,'WALK SIGNAL ACTIVE$'
dontwalk_msg   DB 13,10,"DON'T WALK - TRAFFIC MOVING$"
emergency_msg  DB 13,10,'EMERGENCY! SELECT LANE (1-4) OR ANY OTHER TO CANCEL:$'
traffic_prompt DB 13,10,'HIGH TRAFFIC MODE - SELECT 1 (Lanes 1+4) or 2 (Lanes 2+3). Others cancel:$'

.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Set all lights to red initially
    MOV AX, all_red
    OUT 4, AX

    ; Point to first traffic situation
    MOV SI, OFFSET situation

main_loop:
    ; Check for key press
    MOV AH, 01h
    INT 16h
    JZ cycle        ; If no key, continue cycle

    ; Get key
    MOV AH, 00h
    INT 16h
    CMP AL, 'R'
    JE emergency
    CMP AL, 'H'
    JE high_traffic_phase

cycle:
    ; Output current traffic light state
    MOV AX, [SI]
    OUT 4, AX

    ; Analyze for pedestrian walk
    MOV BX, AX
    TEST BX, 0010h
    JNZ show_walk
    TEST BX, 1000h
    JNZ show_walk

show_dontwalk:
    LEA DX, dontwalk_msg
    MOV AH, 09h
    INT 21h
    JMP wait_delay

show_walk:
    LEA DX, walk_msg
    MOV AH, 09h
    INT 21h

wait_delay:
    ; Wait 5 seconds
    MOV CX, 4Ch
    MOV DX, 4B40h
    MOV AH, 86h
    INT 15h

    ; Next situation
    ADD SI, 2
    CMP SI, OFFSET sit_end
    JB main_loop

    ; Restart
    MOV SI, OFFSET situation
    JMP main_loop

; --------------------------
; HIGH TRAFFIC MODE
; --------------------------
high_traffic_phase:
    ; Prompt for high traffic lane group
    LEA DX, traffic_prompt
    MOV AH, 09h
    INT 21h

    ; Get user choice
    MOV AH, 00h
    INT 16h

    CMP AL, '1'
    JE ht_lanes_1_4
    CMP AL, '2'
    JE ht_lanes_2_3

    ; Cancel: resume normal
    JMP main_loop

ht_lanes_1_4:
    ; Lanes 1 and 4 green
    MOV AX, lane1_4_green
    JMP ht_output

ht_lanes_2_3:
    ; Lanes 2 and 3 green
    MOV AX, lane2_3_green

ht_output:
    ; Output combined green lanes
    OUT 4, AX

    ; Hold 10 seconds
    MOV CX, 96h
    MOV DX, 9680h
    MOV AH, 86h
    INT 15h

    JMP main_loop

; --------------------------
; EMERGENCY MODE
; --------------------------
emergency:
    LEA DX, emergency_msg
    MOV AH, 09h
    INT 21h

    MOV AH, 00h
    INT 16h

    CMP AL, '1'
    JE set_lane1
    CMP AL, '2'
    JE set_lane2
    CMP AL, '3'
    JE set_lane3
    CMP AL, '4'
    JE set_lane4

    MOV AX, all_red
    JMP output_emergency

set_lane1:
    MOV AX, lane1_green
    JMP output_emergency

set_lane2:
    MOV AX, lane2_green
    JMP output_emergency

set_lane3:
    MOV AX, lane3_green
    JMP output_emergency

set_lane4:
    MOV AX, lane4_green

output_emergency:
    OUT 4, AX

    ; Hold 5 sec
    MOV CX, 4Ch
    MOV DX, 4B40h
    MOV AH, 86h
    INT 15h

    JMP main_loop

    ; Exit
    MOV AX, 4C00h
    INT 21h

MAIN ENDP
END MAIN
