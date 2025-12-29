;
; Bank C & Bank D
; ===============
;
; What's inside:
;
;   - The ending sequence with Mario sleeping and the cast roll
;

MarioDream_Pointers:
	.dw PPUBuffer_301
	.dw MarioDream_Bed
	.dw MarioDream_Bubble
	.dw MarioDream_DoNothing
	.dw MarioDream_EraseBubble1
	.dw MarioDream_EraseBubble2
	.dw MarioDream_EraseBubble3
	.dw MarioDream_EraseBubble4
	.dw MarioDream_EraseBubble5
	.dw MarioDream_Palettes


WaitForNMI_MarioSleeping_TurnOffPPU:
	LDA #$00
	BEQ WaitForNMI_MarioSleeping_SetPPUMaskMirror


WaitForNMI_MarioSleeping_TurnOnPPU:
	LDA #PPUMask_ShowLeft8Pixels_BG | PPUMask_ShowLeft8Pixels_SPR | PPUMask_ShowBackground | PPUMask_ShowSprites

WaitForNMI_MarioSleeping_SetPPUMaskMirror:
	STA PPUMaskMirror

WaitForNMI_MarioSleeping:
	LDA ScreenUpdateIndex
	ASL A
	TAX
	LDA MarioDream_Pointers, X
	STA RAM_PPUDataBufferPointer
	LDA MarioDream_Pointers + 1, X
	STA RAM_PPUDataBufferPointer + 1

	LDA #$00
	STA NMIWaitFlag
WaitForNMI_MarioSleepingLoop:
	LDA NMIWaitFlag
	BPL WaitForNMI_MarioSleepingLoop

	RTS


EnableNMI_BankC:
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x16 | PPUCtrl_NMIEnabled
	STA PPUCtrlMirror
	STA PPUCTRL
	RTS


DisableNMI_BankC:
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x16 | PPUCtrl_NMIDisabled
	STA PPUCTRL
	STA PPUCtrlMirror
	RTS


MarioDream_Palettes:
	.db $3F, $00, $20
	.db $02, $22, $12, $0F
	.db $02, $30, $16, $0F
	.db $02, $30, $16, $28
	.db $02, $22, $31, $0F
	.db $02, $27, $16, $0F
	.db $02, $27, $2A, $0F
	.db $02, $27, $25, $0F
	.db $02, $27, $3C, $0F
	.db $00

MarioDream_Bed:
	.db $20, $00, $60, $FF
	.db $20, $20, $60, $FF
	.db $20, $40, $60, $FF
	.db $20, $60, $60, $FF
	.db $23, $40, $60, $FF
	.db $23, $60, $60, $FF
	.db $23, $80, $60, $FF
	.db $23, $A0, $60, $FF
	.db $20, $80, $D6, $FF
	.db $20, $81, $D6, $FF
	.db $20, $82, $D6, $FF
	.db $20, $83, $D6, $FF
	.db $20, $9C, $D6, $FF
	.db $20, $9D, $D6, $FF
	.db $20, $9E, $D6, $FF
	.db $20, $9F, $D6, $FF
	.db $20, $84, $58, $FC
	.db $20, $A4, $58, $FC
	.db $20, $C4, $58, $FC
	.db $20, $E4, $58, $FC
	.db $21, $04, $58, $FC
	.db $21, $24, $58, $FC
	.db $21, $44, $58, $FC
	.db $21, $64, $58, $FC
	.db $21, $84, $58, $FC
	.db $21, $A4, $58, $FC
	.db $21, $C4, $58, $FC
	.db $21, $E4, $58, $FC
	.db $22, $04, $58, $FC
	.db $22, $24, $58, $FC
	.db $22, $44, $58, $FC
	.db $22, $64, $58, $FC
	.db $22, $84, $58, $FC
	.db $22, $A4, $58, $FC
	.db $22, $C4, $58, $FC
	.db $21, $4E, $02, $60, $61
	.db $21, $6E, $02, $70, $71
	.db $21, $8E, $02, $80, $81
	.db $21, $AC, $06, $36, $37, $38, $39, $3A, $3B
	.db $21, $CA, $0C, $36, $37, $35, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
	.db $21, $E8, $0E, $36, $37, $35, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D
	.db $5E, $5F ; $F
	.db $22, $06, $10, $36, $37, $35, $FC, $64, $65, $66, $67, $68, $69, $6A, $6B
	.db $6C, $6D, $6E, $6F ; $F
	.db $22, $24, $12, $36, $37, $35, $FC, $FC, $FC, $74, $75, $76, $77, $78, $79
	.db $7A, $7B, $7C, $7D, $7E, $7F ; $F
	.db $22, $44, $18, $35, $FC, $FC, $FC, $82, $83, $84, $85, $86, $87, $88, $89
	.db $8A, $8B, $8C, $8D, $8E, $8F, $00, $01, $02, $03, $04, $05 ; $F
	.db $22, $68, $14, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D
	.db $9E, $9F, $10, $11, $12, $13, $14, $15 ; $F
	.db $22, $88, $14, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD
	.db $AE, $AF, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $22, $A7, $15, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC
	.db $BD, $BE, $BF, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $22, $C6, $16, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB
	.db $CC, $CD, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $22, $E4, $18, $B1, $F1, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9
	.db $DA, $DB, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $23, $04, $18, $F0, $FE, $FE, $FE, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9
	.db $EA, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $23, $24, $18, $FE, $FE, $FE, $FE, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9
	.db $FA, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE ; $F
	.db $00

MarioDream_Bubble:
	.db $20, $8F, $84, $06, $16, $07, $17
	.db $20, $D0, $85, $08, $18, $09, $19, $1D
	.db $20, $90, $4C, $FD
	.db $20, $B0, $4C, $FD
	.db $20, $D1, $4B, $FD
	.db $20, $F1, $0B, $FD, $FD, $FD, $28, $29, $29, $29, $29, $2A, $FD, $FD
	.db $21, $11, $0B, $FD, $FD, $FD, $FD, $27, $FD, $FD, $27, $FD, $FD, $FD
	.db $21, $31, $0B, $FD, $FD, $FD, $FD, $27, $FD, $FD, $27, $FD, $FD, $FD
	.db $21, $51, $0B, $FD, $FD, $23, $24, $25, $22, $23, $24, $25, $25, $FD
	.db $21, $71, $0B, $0B, $0C, $0D, $0E, $0F, $FD, $FD, $FD, $FD, $FD, $FD
	.db $21, $95, $07, $1F, $1A, $30, $31, $32, $33, $1B
	.db $21, $B5, $06, $53, $FC, $40, $41, $42, $43
	.db $21, $D7, $03, $50, $51, $52
	.db $21, $F6, $02, $20, $21
	.db $23, $CB, $04, $44, $55, $A5, $65 ; Attribute table changes
	.db $23, $D4, $03, $55, $5A, $56
	.db $23, $DD, $02, $45, $15
	.db $23, $E4, $01, $3F
	.db $00

; This is pointed to, but the very first byte
; is the terminating 0, so nothing gets drawn.
; This would have undone the attribute changes
; done in the above PPU writing, but I guess
; Nintendo realized they were never going to
; use that part of the screen again
MarioDream_DoNothing:
	.db $00
	.db $23, $CB, $44, $00
	.db $23, $D4, $43, $00
	.db $23, $DD, $42, $00
	.db $00

MarioDream_EraseBubble1:
	.db $20, $8F, $4D, $FC
	.db $20, $AF, $4D, $FC
	.db $00

MarioDream_EraseBubble2:
	.db $20, $CF, $4D, $FC
	.db $20, $EF, $4D, $FC
	.db $00

MarioDream_EraseBubble3:
	.db $21, $10, $4C, $FC
	.db $21, $30, $4C, $FC
	.db $00

MarioDream_EraseBubble4:
	.db $21, $50, $4C, $FC
	.db $21, $71, $4B, $FC
	.db $00

MarioDream_EraseBubble5:
	.db $21, $95, $47, $FC
	.db $21, $B5, $46, $FC
	.db $21, $D7, $43, $FC
	.db $21, $F6, $42, $FC
	.db $00

MarioDream_BubbleSprites:
	.db $28, $00, $00, $A8
	.db $28, $04, $01, $B0
	.db $28, $08, $02, $C0
	.db $28, $0C, $03, $B8

MarioDream_BubbleSprites2:
	.db $28, $02, $00, $A8
	.db $28, $06, $01, $B0
	.db $28, $0A, $02, $C0
	.db $28, $0E, $03, $B8

MarioDream_SnoringFrameCounts:
	.db $20
	.db $0A
	.db $0A
	.db $0A
	.db $0A
	.db $0A
	.db $0A
	.db $20
	.db $0A
	.db $0A
	.db $0A
	.db $0A
	.db $0A
	.db $0A

MarioDream_WakingFrameCounts:
	.db $08
	.db $08
	.db $50
	.db $40
	.db $30
	.db $10
	.db $10

MarioDream_SnoringFrames:
	.db CHRBank_MarioSleepingBackground1
	.db CHRBank_MarioSleepingBackground2
	.db CHRBank_MarioSleepingBackground3
	.db CHRBank_MarioSleepingBackground4
	.db CHRBank_MarioSleepingBackground5
	.db CHRBank_MarioSleepingBackground6
	.db CHRBank_MarioSleepingBackground7
	.db CHRBank_MarioSleepingBackground8
	.db CHRBank_MarioSleepingBackground7
	.db CHRBank_MarioSleepingBackground6
	.db CHRBank_MarioSleepingBackground5
	.db CHRBank_MarioSleepingBackground4
	.db CHRBank_MarioSleepingBackground3
	.db CHRBank_MarioSleepingBackground2
MarioDream_SnoringFrames_End:

MarioDream_WakingFrames:
	.db CHRBank_MarioSleepingBackground11
	.db CHRBank_MarioSleepingBackground10
	.db CHRBank_MarioSleepingBackground9
	.db CHRBank_MarioSleepingBackground12
	.db CHRBank_MarioSleepingBackground9
	.db CHRBank_MarioSleepingBackground10
	.db CHRBank_MarioSleepingBackground11
MarioDream_WakingFrames_End:


MarioSleepingScene:
	JSR WaitForNMI_MarioSleeping_TurnOffPPU

	LDA #VMirror
	JSR ChangeNametableMirroring

	JSR ClearNametablesAndSprites

	LDA #Stack100_Menu
	STA StackArea
	JSR EnableNMI_BankC

	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_Palettes
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_Bed
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_Bubble
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #$10
	STA MarioSnoringWaveFrameCounter
	LDA #$04 ; 5 snores before waking up
	STA MarioSnoringLoopCounter

;
; Dream Bubble Intro
; ==================
;
; The part where Mario is snoring with a little dream bubble containing the
; characters waving.
;
MarioDream_DreamBubbleIntro:
	LDA #$00
	STA MarioSnoringFrameIndex
	LDA #(MarioDream_SnoringFrames_End - MarioDream_SnoringFrames - 1)
	STA MarioSnoringFrameCounter
	LDA #$00
	STA MarioSnoringWaveFrame

	JSR MarioDream_WriteBubbleSprites

	JSR WaitForNMI_MarioSleeping_TurnOnPPU

MarioDream_DreamBubbleIntro_Loop:
	LDY MarioSnoringFrameIndex
	LDA MarioDream_SnoringFrames, Y
	STA BackgroundCHR1
	CLC
	ADC #$02
	STA BackgroundCHR2

	; Hold the animation frame briefly
	LDA MarioDream_SnoringFrameCounts, Y
	STA byte_RAM_10
MarioDream_DreamBubbleIntro_DelayLoop:
	DEC MarioSnoringWaveFrameCounter
	BPL MarioDream_DreamBubbleIntro_AfterWaveFrameUpdate

	LDA #$10
	STA MarioSnoringWaveFrameCounter
	INC MarioSnoringWaveFrame
	JSR MarioDream_WriteBubbleSprites

MarioDream_DreamBubbleIntro_AfterWaveFrameUpdate:
	JSR WaitForNMI_MarioSleeping

	DEC byte_RAM_10
	BPL MarioDream_DreamBubbleIntro_DelayLoop

	INC MarioSnoringFrameIndex
	DEC MarioSnoringFrameCounter
	BPL MarioDream_DreamBubbleIntro_Loop

	DEC MarioSnoringLoopCounter
	BMI MarioDream_WakeUp

	JMP MarioDream_DreamBubbleIntro

;
; Wake Up
; =======
;
; Mario wakes up, effectively bursting his dream bubble, looks around, and then
; falls back asleep and continues snoring.
;
MarioDream_WakeUp:
	LDA #MarioSleepingUpdateBuffer_DoNothing
	STA ScreenUpdateIndex
	LDA #$F8
	STA SpriteDMAArea
	STA SpriteDMAArea + $04
	STA SpriteDMAArea + $08
	STA SpriteDMAArea + $0C
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_EraseBubble1
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_EraseBubble2
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_EraseBubble3
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_EraseBubble4
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #MarioSleepingUpdateBuffer_EraseBubble5
	STA ScreenUpdateIndex
	JSR WaitForNMI_MarioSleeping

	LDA #$00
	STA MarioSnoringFrameIndex
	LDA #(MarioDream_WakingFrames_End - MarioDream_WakingFrames - 1)
	STA MarioSnoringFrameCounter
	LDA #$00
	STA MarioSnoringLoopCounter

	JSR WaitForNMI_MarioSleeping_TurnOnPPU

MarioDream_WakeUp_Loop:
	LDY MarioSnoringFrameIndex
	LDA MarioDream_WakingFrames, Y
	STA BackgroundCHR1
	CLC
	ADC #$02
	STA BackgroundCHR2

	LDA MarioDream_WakingFrameCounts, Y
	STA byte_RAM_10
MarioDream_WakeUp_DelayLoop:
	JSR WaitForNMI_MarioSleeping

	DEC byte_RAM_10
	BPL MarioDream_WakeUp_DelayLoop

	INC MarioSnoringFrameIndex
	DEC MarioSnoringFrameCounter
	BPL MarioDream_WakeUp_Loop

	LDA #$10
	STA MarioSnoringWaveFrameCounter
	LDA #$01 ; 2 snores before showing cast
	STA MarioSnoringLoopCounter

;
; Pre-Cast Roll
; =============
;
; Just Mario snoring a little bit more.
;
MarioDream_PreCastSleep:
	LDA #$00
	STA MarioSnoringFrameIndex
	LDA #(MarioDream_SnoringFrames_End - MarioDream_SnoringFrames - 1)
	STA MarioSnoringFrameCounter

	JSR WaitForNMI_MarioSleeping_TurnOnPPU

MarioDream_PreCastSleep_Loop:
	LDY MarioSnoringFrameIndex
	LDA MarioDream_SnoringFrames, Y
	STA BackgroundCHR1
	CLC
	ADC #$02
	STA BackgroundCHR2

	; Hold the animation frame briefly
	LDA MarioDream_SnoringFrameCounts, Y
	STA byte_RAM_10
MarioDream_PreCastSleep_DelayLoop:
	JSR WaitForNMI_MarioSleeping

	DEC byte_RAM_10
	BPL MarioDream_PreCastSleep_DelayLoop

	INC MarioSnoringFrameIndex
	DEC MarioSnoringFrameCounter
	BPL MarioDream_PreCastSleep_Loop

	DEC MarioSnoringLoopCounter
	BMI MarioDream_StartCastRoll

	JMP MarioDream_PreCastSleep

MarioDream_StartCastRoll:
	JSR MarioDream_CastRollSetup

	JSR WaitForNMI_MarioSleeping

;
; Cast Roll
; =========
;
; Mario snoring while the cast roll crawls up the screen.
;
MarioDream_CastSleep:
	LDA #$00
	STA MarioSnoringFrameIndex

	LDA #(MarioDream_SnoringFrames_End - MarioDream_SnoringFrames - 1)
	STA MarioSnoringFrameCounter

	JSR WaitForNMI_MarioSleeping_TurnOnPPU

MarioDream_CastSleep_Loop:
	LDY MarioSnoringFrameIndex
	LDA MarioDream_SnoringFrames, Y
	STA BackgroundCHR1
	CLC
	ADC #$02
	STA BackgroundCHR2

	; Hold the animation frame briefly
	LDA MarioDream_SnoringFrameCounts, Y
	STA byte_RAM_10
MarioDream_CastSleep_DelayLoop:
	JSR CastRoll_ScrollSprites

	JSR WaitForNMI_MarioSleeping

	DEC byte_RAM_10
	BPL MarioDream_CastSleep_DelayLoop

	INC MarioSnoringFrameIndex
	DEC MarioSnoringFrameCounter
	BPL MarioDream_CastSleep_Loop

	JMP MarioDream_CastSleep


;
; Draw the sprites of the characters waving
;
MarioDream_WriteBubbleSprites:
	LDY #$0F
	LDA MarioSnoringWaveFrame
	AND #$01
	BNE MarioDream_WriteBubbleSprites_Frame2

MarioDream_WriteBubbleSprites_Frame1:
	LDA MarioDream_BubbleSprites, Y
	STA SpriteDMAArea, Y
	DEY
	BPL MarioDream_WriteBubbleSprites_Frame1

	RTS

MarioDream_WriteBubbleSprites_Frame2:
	LDA MarioDream_BubbleSprites2, Y
	STA SpriteDMAArea, Y
	DEY
	BPL MarioDream_WriteBubbleSprites_Frame2

	RTS


CastRoll_PaletteFadeIn:
	.db $22
	.db $32
	.db $30


CastRoll_ScrollSprites:
	; Throttle used to slow down the cast roll
	INC CastRollThrottle
	LDA CastRollThrottle
	AND #$01
	BNE CastRoll_ScrollSprites_AfterSpriteCounter

	DEC CastRollSpriteCounter1
	DEC CastRollSpriteCounter2
	DEC CastRollSpriteCounter3

CastRoll_ScrollSprites_AfterSpriteCounter:
	LDA CastRollSequenceIndex
	JSR JumpToTableAfterJump

	.dw CastRoll_FadeIn
	.dw CastRoll_CrawlDelay
	.dw CastRoll_CrawlStart
	.dw CastRoll_CrawlContinue
	.dw CastRoll_WartSetup
	.dw CastRoll_WartScroll
	.dw CastRoll_WartLaugh
	.dw CastRoll_DoPaletteFadeOut
	.dw CastRoll_HideSprites
	.dw CastRoll_TheEndDelay
	.dw CastRoll_TheEndAnimation

	RTS


CastRoll_CASTText:
	.db $60, $D4, $00, $28
	.db $60, $D0, $00, $38
	.db $60, $F4, $00, $48
	.db $60, $F6, $00, $58


;
; Loads the pointer for the current cast roll sprite and then increments the index
;
; ##### Input
; - `CastRollSpriteIndex`: current sprite index
;
; ##### Output
; - `CastRollSpriteHi`: high byte for sprite
; - `CastRollSpriteLo`: low byte for sprite
; - `CastRollSpriteIndex`: next sprite index
;
LoadCastRollSpritePointer:
	LDY CastRollSpriteIndex
	LDA CastRoll_SpritePointersLo, Y
	STA CastRollSpriteLo
	LDA CastRoll_SpritePointersHi, Y
	STA CastRollSpriteHi
	INC CastRollSpriteIndex
	RTS


;
; Cast Roll Setup
; ===============
;
; Loads the ending cast sprites and prepares the cast roll crawl.
;
; The technique used to crop the cast roll within the black border is clever;
; by using the first 16 OAM sprite slots to draw 8 sprites at the top and
; bottom, the sprite limit ensures that the cast sprites won't be drawn in that
; part of the screen.
;
; If you disable the sprite limit in an emulator, you'll be able to see the
; sprites pop in and out as they scroll beyond the intended display area.
;
MarioDream_CastRollSetup:
	LDY #CHRBank_EndingCast1
	STY SpriteCHR1
	INY
	STY SpriteCHR2
	INY
	STY SpriteCHR3
	INY
	STY SpriteCHR4

	; Top cropping sprites
	LDX #$07
	LDA #$20
	STA CastRollSpriteSetupTemp
	LDY #$00
MarioDream_CastRollSetup_TopCrop_Loop:
	LDA #$0F
	STA SpriteDMAArea, Y
	INY
	LDA #$3E
	STA SpriteDMAArea, Y
	INY
	LDA #$00
	STA SpriteDMAArea, Y
	INY
	LDA CastRollSpriteSetupTemp
	STA SpriteDMAArea, Y
	INY
	CLC
	ADC #$08
	STA CastRollSpriteSetupTemp
	DEX
	BPL MarioDream_CastRollSetup_TopCrop_Loop

	; Bottom cropping sprites
	LDX #$07
	LDA #$20
	STA CastRollSpriteSetupTemp
MarioDream_CastRollSetup_BottomCrop_Loop:
	LDA #$D0
	STA SpriteDMAArea, Y
	INY
	LDA #$3E
	STA SpriteDMAArea, Y
	INY
	LDA #$00
	STA SpriteDMAArea, Y
	INY
	LDA CastRollSpriteSetupTemp
	STA SpriteDMAArea, Y
	INY
	CLC
	ADC #$08
	STA CastRollSpriteSetupTemp
	DEX
	BPL MarioDream_CastRollSetup_BottomCrop_Loop

	; Draw "CAST" sprite
	LDX #$0F
MarioDream_CastRollSetup_CAST_Loop:
	LDA CastRoll_CASTText, X
	STA SpriteDMAArea + $40, X
	DEX
	BPL MarioDream_CastRollSetup_CAST_Loop

	LDA #$3F
	STA PPUBuffer_301
	LDA #$11
	STA PPUBuffer_301 + 1
	LDA #$01
	STA PPUBuffer_301 + 2
	LDA #$12
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4
	LDA #$10
	STA CastRollTimer
	LDA #$00
	STA CastRollSequenceIndex
	STA CastRollFadePaletteIndex

	; Set delays to space out the cast sprites
	LDY #$40
MarioDream_CastRollSetup_SpriteDelay_Loop:
	LDA #$27
	STA CastRollSpriteOffset, Y
	DEY
	BPL MarioDream_CastRollSetup_SpriteDelay_Loop

	RTS


;
; Fade in the word "CAST"
;
CastRoll_FadeIn:
	DEC CastRollTimer
	BPL CastRoll_FadeIn_Exit

	LDA #$10
	STA CastRollTimer
	LDA #$3F
	STA PPUBuffer_301
	LDA #$11
	STA PPUBuffer_301 + 1
	LDA #$01
	STA PPUBuffer_301 + 2
	LDY CastRollFadePaletteIndex
	LDA CastRoll_PaletteFadeIn, Y
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4

	INC CastRollFadePaletteIndex
	LDA CastRollFadePaletteIndex
	CMP #$03
	BNE CastRoll_FadeIn_Exit

	INC CastRollSequenceIndex
	LDA #$80
	STA CastRollTimer
	LDA #$60
	STA CastRollSprite1A
	LDA #$01
	STA CastRollSpriteActive1
	STA CastRollSpriteActive4
	LDA #$00
	STA CastRollSpriteActive2
	STA CastRollSpriteActive3

CastRoll_FadeIn_Exit:
	RTS


;
; Pause before starting the crawl, then initialize the first sprite
;
CastRoll_CrawlDelay:
	DEC CastRollTimer
	BPL CastRoll_CrawlDelay_Exit

	INC CastRollSequenceIndex
	LDA #$00
	STA CastRollSpriteIndex
	STA CastRollLastSprite
	LDA #$01
	STA CastRollSpriteCounter2

CastRoll_CrawlDelay_Exit:
	RTS


;
; Starts the cast roll crawl
;
CastRoll_CrawlStart:
	LDA CastRollThrottle
	AND #$01
	BEQ CastRollSprite1

	LDA CastRollSprite1A
	SEC
	SBC #$01
	STA CastRollSprite1A
	STA SpriteDMAArea + $40
	STA SpriteDMAArea + $44
	STA SpriteDMAArea + $48
	STA SpriteDMAArea + $4C
	LDA CastRollSprite1A
	CMP #$10
	BNE CastRollSprite1

	LDA #$F8
	STA SpriteDMAArea + $40
	STA SpriteDMAArea + $44
	STA SpriteDMAArea + $48
	STA SpriteDMAArea + $4A
	INC CastRollSequenceIndex
	LDA #$00
	STA CastRollSpriteActive4
	STA CastRollSpriteActive1

;
; Runs the cast roll crawl without the initial setup
;
CastRoll_CrawlContinue:
CastRollSprite1:
	LDA CastRollSpriteActive1
	BNE CastRollSprite2

	LDA CastRollSpriteCounter1
	BNE CastRollSprite2

	JSR LoadCastRollSpritePointer

	LDY #$3F
CastRollSprite1_Loop:
	LDA (CastRollSpriteLo), Y
	STA SpriteDMAArea + $40, Y
	DEY
	BPL CastRollSprite1_Loop

	; Activate sprite and move to the bottom of the screen
	LDA #$01
	STA CastRollSpriteActive1
	LDA #$D0
	STA CastRollSprite1A
	LDA #$E0
	STA CastRollSprite1B
	LDA #$F8
	STA CastRollSprite1C

CastRollSprite2:
	LDA CastRollSpriteActive2
	BNE CastRollSprite3

	LDA CastRollSpriteCounter2
	BNE CastRollSprite3

	JSR LoadCastRollSpritePointer

	LDY #$3F
CastRollSprite2_Loop:
	LDA (CastRollSpriteLo), Y
	STA SpriteDMAArea + $80, Y
	DEY
	BPL CastRollSprite2_Loop

	; Activate sprite and move to the bottom of the screen
	LDA #$01
	STA CastRollSpriteActive2
	LDA #$D0
	STA CastRollSprite2A
	LDA #$E0
	STA CastRollSprite2B
	LDA #$F8
	STA CastRollSprite2C

CastRollSprite3:
	LDA CastRollSpriteActive3
	BNE CastRoll_CrawlContinue_UpdateSprite4

	LDA CastRollSpriteCounter3
	BNE CastRoll_CrawlContinue_UpdateSprite4

	JSR LoadCastRollSpritePointer

	LDY #$3F
CastRollSprite3_Loop:
	LDA (CastRollSpriteLo), Y
	STA SpriteDMAArea + $C0, Y
	DEY
	BPL CastRollSprite3_Loop

	; Activate sprite and move to the bottom of the screen
	LDA #$01
	STA CastRollSpriteActive3
	LDA #$D0
	STA CastRollSprite3A
	LDA #$E0
	STA CastRollSprite3B
	LDY #$F8
	; Is this Tryclyde?
	LDA CastRollSpriteIndex
	CMP #(CastRoll_SpritePointersLo - CastRoll_SpritePointersHi)
	BNE CastRollSprite3_SetLastRowOffset
	; Tryclyde's third row is his body, not label, hence the smaller offset
	LDY #$F0
CastRollSprite3_SetLastRowOffset:
	STY CastRollSprite3C

CastRoll_CrawlContinue_UpdateSprite4:
	LDA CastRollSpriteActive4
	BEQ CastRoll_CrawlContinue_UpdateSprite1

	JMP CastRoll_CrawlContinue_UpdateSprite2


CastRoll_CrawlContinue_UpdateSprite1:
	LDA CastRollThrottle
	AND #$01
	BNE CastRoll_CrawlContinue_Sprite1Row1

	JMP CastRoll_CrawlContinue_UpdateSprite2


CastRoll_CrawlContinue_Sprite1Row1:
	LDA SpriteDMAArea + $40
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite1Row2

	LDA CastRollSprite1A
	SEC
	SBC #$01
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite1Row1_Update

	LDA #$F8

CastRoll_CrawlContinue_Sprite1Row1_Update:
	STA CastRollSprite1A
	STA SpriteDMAArea + $40
	STA SpriteDMAArea + $44
	STA SpriteDMAArea + $48
	STA SpriteDMAArea + $4C

CastRoll_CrawlContinue_Sprite1Row2:
	LDA SpriteDMAArea + $50
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite1Row3

	DEC CastRollSprite1B
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite1Row2_Update

	LDA CastRollSprite1B
	CMP #$D0
	BNE CastRoll_CrawlContinue_Sprite1Row3

CastRoll_CrawlContinue_Sprite1Row2_Update:
	LDA CastRollSprite1B
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite1Row2_Hide

	LDA CastRollSpriteIndex
	CMP #$FF
	BNE CastRoll_CrawlContinue_Sprite1Row2_CheckEnd

	INC CastRollSequenceIndex

CastRoll_CrawlContinue_Sprite1Row2_CheckEnd:
	LDA #$F8

CastRoll_CrawlContinue_Sprite1Row2_Hide:
	STA SpriteDMAArea + $50
	STA SpriteDMAArea + $54
	STA SpriteDMAArea + $58
	STA SpriteDMAArea + $5C

CastRoll_CrawlContinue_Sprite1Row3:
	LDA SpriteDMAArea + $60
	CMP #$F8
	BEQ CastRoll_CrawlContinue_UpdateSprite2

	DEC CastRollSprite1C
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite1Row3_Update

	LDA CastRollSprite1C
	CMP #$D0
	BNE CastRoll_CrawlContinue_UpdateSprite2

	LDY CastRollSpriteIndex
	LDA CastRollSpriteOffset, Y
	STA CastRollSpriteCounter2

CastRoll_CrawlContinue_Sprite1Row3_Update:
	LDA CastRollSprite1C
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite1Row3_Hide

	LDA #$00
	STA CastRollSpriteActive1
	LDA CastRollSpriteIndex
	CMP #$FF
	BNE CastRoll_CrawlContinue_Sprite1Row3_Deactivate

	LDA #$FF
	STA CastRollSpriteActive1

CastRoll_CrawlContinue_Sprite1Row3_Deactivate:
	LDA #$F8

CastRoll_CrawlContinue_Sprite1Row3_Hide:
	STA SpriteDMAArea + $60
	STA SpriteDMAArea + $64
	STA SpriteDMAArea + $68
	STA SpriteDMAArea + $6C
	STA SpriteDMAArea + $70
	STA SpriteDMAArea + $74
	STA SpriteDMAArea + $78
	STA SpriteDMAArea + $7C

CastRoll_CrawlContinue_UpdateSprite2:
	LDA CastRollThrottle
	AND #$01
	BNE CastRoll_CrawlContinue_Sprite2Row1

	JMP CastRoll_CrawlContinue_UpdateSprite3


CastRoll_CrawlContinue_Sprite2Row1:
	LDA SpriteDMAArea + $80
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite2Row2

	LDA CastRollSprite2A
	SEC
	SBC #$01
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite2Row1_Update

	LDA #$F8

CastRoll_CrawlContinue_Sprite2Row1_Update:
	STA CastRollSprite2A
	STA SpriteDMAArea + $80
	STA SpriteDMAArea + $84
	STA SpriteDMAArea + $88
	STA SpriteDMAArea + $8C

CastRoll_CrawlContinue_Sprite2Row2:
	LDA SpriteDMAArea + $90
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite2Row3

	DEC CastRollSprite2B
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite2Row2_Update

	LDA CastRollSprite2B
	CMP #$D0
	BNE CastRoll_CrawlContinue_Sprite2Row3

CastRoll_CrawlContinue_Sprite2Row2_Update:
	LDA CastRollSprite2B
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite2Row2_Hide

	LDA #$F8

CastRoll_CrawlContinue_Sprite2Row2_Hide:
	STA SpriteDMAArea + $90
	STA SpriteDMAArea + $94
	STA SpriteDMAArea + $98
	STA SpriteDMAArea + $9C

CastRoll_CrawlContinue_Sprite2Row3:
	LDA SpriteDMAArea + $A0
	CMP #$F8
	BEQ CastRoll_CrawlContinue_UpdateSprite3

	DEC CastRollSprite2C
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite2Row3_Update

	LDA CastRollSprite2C
	CMP #$D0
	BNE CastRoll_CrawlContinue_UpdateSprite3

	LDY CastRollSpriteIndex
	LDA CastRollSpriteOffset, Y
	STA CastRollSpriteCounter3

CastRoll_CrawlContinue_Sprite2Row3_Update:
	LDA CastRollSprite2C
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite2Row3_Hide

	LDA #$00
	STA CastRollSpriteActive2
	LDA CastRollSpriteIndex
	CMP #$FF
	BNE CastRoll_CrawlContinue_Sprite2Row3_Deactivate

	LDA #$FF
	STA CastRollSpriteActive2

CastRoll_CrawlContinue_Sprite2Row3_Deactivate:
	LDA #$F8

CastRoll_CrawlContinue_Sprite2Row3_Hide:
	STA SpriteDMAArea + $A0
	STA SpriteDMAArea + $A4
	STA SpriteDMAArea + $A8
	STA SpriteDMAArea + $AC
	STA SpriteDMAArea + $B0
	STA SpriteDMAArea + $B4
	STA SpriteDMAArea + $B8
	STA SpriteDMAArea + $BC

CastRoll_CrawlContinue_UpdateSprite3:
	LDA CastRollThrottle
	AND #$01
	BNE CastRoll_CrawlContinue_Sprite3Row1

	JMP CastRoll_CrawlContinue_Exit


CastRoll_CrawlContinue_Sprite3Row1:
	LDA SpriteDMAArea + $C0
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite3Row2

	LDA CastRollSprite3A
	SEC
	SBC #$01
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite3Row1_Update

	LDA #$F8

CastRoll_CrawlContinue_Sprite3Row1_Update:
	STA CastRollSprite3A
	STA SpriteDMAArea + $C0
	STA SpriteDMAArea + $C4
	STA SpriteDMAArea + $C8
	STA SpriteDMAArea + $CC

CastRoll_CrawlContinue_Sprite3Row2:
	LDA SpriteDMAArea + $D0
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Sprite3Row3

	DEC CastRollSprite3B
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite3Row2_Update

	LDA CastRollSprite3B
	CMP #$D0
	BNE CastRoll_CrawlContinue_Sprite3Row3

CastRoll_CrawlContinue_Sprite3Row2_Update:
	LDA CastRollSprite3B
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite3Row2_Hide

	LDA #$F8

CastRoll_CrawlContinue_Sprite3Row2_Hide:
	STA SpriteDMAArea + $D0
	STA SpriteDMAArea + $D4
	STA SpriteDMAArea + $D8
	STA SpriteDMAArea + $DC

CastRoll_CrawlContinue_Sprite3Row3:
	LDA SpriteDMAArea + $E0
	CMP #$F8
	BEQ CastRoll_CrawlContinue_Exit

	DEC CastRollSprite3C
	CMP #$F9
	BNE CastRoll_CrawlContinue_Sprite3Row3_Update

	LDA CastRollSprite3C
	CMP #$D0
	BNE CastRoll_CrawlContinue_Exit

	LDY CastRollSpriteIndex
	LDA CastRollSpriteOffset, Y
	STA CastRollSpriteCounter1

CastRoll_CrawlContinue_Sprite3Row3_Update:
	; Is this Tryclyde?
	LDA CastRollSpriteIndex
	CMP #(CastRoll_SpritePointersLo - CastRoll_SpritePointersHi)
	BNE CastRoll_CrawlContinue_Sprite3Row3_CheckEnd
	; And is the last row at the right spot?
	LDA CastRollSprite3C
	CMP #$B8
	BNE CastRoll_CrawlContinue_Sprite3Row3_CheckEnd
	; Add "TRICLYDE" to the crawl
	LDA #$01
	STA CastRollLastSprite

CastRoll_CrawlContinue_Sprite3Row3_CheckEnd:
	LDA CastRollSprite3C
	CMP #$10
	BNE CastRoll_CrawlContinue_Sprite3Row3_Hide

	LDA #$00
	STA CastRollSpriteActive3
	LDA CastRollSpriteIndex
	CMP #$FF
	BNE CastRoll_CrawlContinue_Sprite3Row3_Deactivate

	LDA #$FF
	STA CastRollSpriteActive3

CastRoll_CrawlContinue_Sprite3Row3_Deactivate:
	LDA #$F8

CastRoll_CrawlContinue_Sprite3Row3_Hide:
	STA SpriteDMAArea + $E0
	STA SpriteDMAArea + $E4
	STA SpriteDMAArea + $E8
	STA SpriteDMAArea + $EC
	STA SpriteDMAArea + $F0
	STA SpriteDMAArea + $F4
	STA SpriteDMAArea + $F8
	STA SpriteDMAArea + $FC
	LDA CastRollLastSprite
	BEQ CastRoll_CrawlContinue_Exit

	; Other sprites include their own text label, but since Tryclyde is taller
	; than the rest, his label is drawn separately
	LDY #(CastRoll_Wart - CastRoll_TriclydeText - 1)
CastRoll_TriclydeTextLoop:
	LDA CastRoll_TriclydeText, Y
	STA SpriteDMAArea + $40, Y
	DEY
	BPL CastRoll_TriclydeTextLoop

	LDA #$D0
	STA CastRollSprite1A
	STA CastRollSprite1B
	LDA #$00
	STA CastRollLastSprite
	LDA #$FF
	STA CastRollSpriteIndex

CastRoll_CrawlContinue_Exit:
	RTS


;
; Loads Wart's CHR data and sets up the initial sprite positions
;
CastRoll_WartSetup:
	LDY #$48
	STY SpriteCHR1
	INY
	STY SpriteCHR2
	INY
	STY SpriteCHR3
	INY
	STY SpriteCHR4

	LDY #$5B
CastRoll_WartSetup_CopyWartSprite_Loop:
	LDA CastRoll_Wart, Y
	STA SpriteDMAArea + $40, Y
	DEY
	BPL CastRoll_WartSetup_CopyWartSprite_Loop

	INC CastRollSequenceIndex

	LDY #$00
	LDX #$0F
	LDA #$C0
CastRoll_WartSetup_SetSpriteY_Loop:
	STA SpriteDMAArea + 1, Y
	INY
	INY
	INY
	INY
	DEX
	BPL CastRoll_WartSetup_SetSpriteY_Loop

	LDA #$D0
	STA CastRollSprite1A
	LDA #$E0
	STA CastRollSprite1B
	LDA #$F0
	STA CastRollSprite1C
	LDA #$08
	STA CastRollSprite2A

	RTS


;
; Scrolls Wart's sprites up the screen
;
CastRoll_WartScroll:
	LDA CastRollThrottle
	AND #$01
	BNE CastRoll_WartScroll_UpdateSprites

	JMP CastRoll_WartScroll_Exit


CastRoll_WartScroll_UpdateSprites:
	LDA SpriteDMAArea + $40
	CMP #$F8
	BEQ CastRoll_WartScroll_CheckRow2

	LDA CastRollSprite1A
	SEC
	SBC #$01
	CMP #$50
	BNE CastRoll_WartScroll_UpdateRow1

	INC CastRollSequenceIndex
	JMP CastRoll_WartScroll_Exit


CastRoll_WartScroll_UpdateRow1:
	STA CastRollSprite1A
	STA SpriteDMAArea + $40
	STA SpriteDMAArea + $44
	STA SpriteDMAArea + $48
	STA SpriteDMAArea + $4C
	STA SpriteDMAArea + $50

CastRoll_WartScroll_CheckRow2:
	LDA SpriteDMAArea + $54
	CMP #$F8
	BEQ CastRoll_WartScroll_CheckRow3

	DEC CastRollSprite1B
	CMP #$F9
	BNE CastRoll_WartScroll_UpdateRow2

	LDA CastRollSprite1B
	CMP #$D0
	BNE CastRoll_WartScroll_CheckRow3

CastRoll_WartScroll_UpdateRow2:
	LDA CastRollSprite1B
	CMP #$10
	BNE CastRoll_WartScroll_HideRow2

	LDA #$F8

CastRoll_WartScroll_HideRow2:
	STA SpriteDMAArea + $54
	STA SpriteDMAArea + $58
	STA SpriteDMAArea + $5C
	STA SpriteDMAArea + $60
	STA SpriteDMAArea + $64

CastRoll_WartScroll_CheckRow3:
	LDA SpriteDMAArea + $68
	CMP #$F8
	BEQ CastRoll_WartScroll_CheckRow4

	DEC CastRollSprite1C
	CMP #$F9
	BNE CastRoll_WartScroll_UpdateRow3

	LDA CastRollSprite1C
	CMP #$D0
	BNE CastRoll_WartScroll_CheckRow4

CastRoll_WartScroll_UpdateRow3:
	LDA CastRollSprite1C
	CMP #$10
	BNE CastRoll_WartScroll_HideRow3

	LDA #$F8

CastRoll_WartScroll_HideRow3:
	STA SpriteDMAArea + $68
	STA SpriteDMAArea + $6C
	STA SpriteDMAArea + $70
	STA SpriteDMAArea + $74
	STA SpriteDMAArea + $78

CastRoll_WartScroll_CheckRow4:
	LDA SpriteDMAArea + $7C
	CMP #$F8
	BEQ CastRoll_WartScroll_Exit

	DEC CastRollSprite2A
	CMP #$F9
	BNE CastRoll_WartScroll_UpdateRow4

	LDA CastRollSprite2A
	CMP #$D0
	BNE CastRoll_WartScroll_Exit

CastRoll_WartScroll_UpdateRow4:
	LDA CastRollSprite2A
	CMP #$10
	BNE CastRoll_WartScroll_HideRow4

	LDA #$F8

CastRoll_WartScroll_HideRow4:
	STA SpriteDMAArea + $7C
	STA SpriteDMAArea + $80
	STA SpriteDMAArea + $84
	STA SpriteDMAArea + $88
	STA SpriteDMAArea + $8C
	STA SpriteDMAArea + $90
	STA SpriteDMAArea + $94
	STA SpriteDMAArea + $98

CastRoll_WartScroll_Exit:
	LDA #$00
	STA CastRoll_TempA
	STA CastRoll_Temp9
	LDA #$0C
	STA CastRoll_TempA1
	RTS


WartLaugh_Frame1:
	.db $9E
	.db $A0
	.db $A2
	.db $A4
	.db $88
	.db $A6
	.db $A8
	.db $AA
	.db $AC
	.db $92
	.db $94
	.db $96
	.db $98
	.db $9A
	.db $9C
WartLaugh_Frame2:
	.db $AE
	.db $B0
	.db $B2
	.db $B4
	.db $BE
	.db $B6
	.db $B8
	.db $BA
	.db $BC
	.db $92
	.db $94
	.db $96
	.db $98
	.db $9A
	.db $9C


CastRoll_WartLaugh:
	DEC CastRoll_Temp9
	BPL CastRoll_WartLaugh_Exit

	LDA #$08
	STA CastRoll_Temp9
	DEC CastRoll_TempA1
	BPL CastRoll_WartLaugh_CheckFrame

	INC CastRollSequenceIndex
	LDA #$00
	STA CastRollTimer
	STA CastRollFadePaletteIndex
	JMP CastRoll_WartLaugh_Exit


CastRoll_WartLaugh_CheckFrame:
	LDA CastRoll_TempA
	AND #$01
	BNE CastRoll_WartLaugh_Frame2

	LDY #$00
	LDX #$00
CastRoll_WartLaugh_Frame1_Loop:
	INC CastRoll_TempA
	LDA WartLaugh_Frame1, X
	STA SpriteDMAArea + $41, Y
	INY
	INY
	INY
	INY
	INX
	CPX #$0F
	BNE CastRoll_WartLaugh_Frame1_Loop

	JMP CastRoll_WartLaugh_Exit


CastRoll_WartLaugh_Frame2:
	INC CastRoll_TempA
	LDX #$00
	LDY #$00

CastRoll_WartLaugh_Frame2_Loop:
	LDA WartLaugh_Frame2, X
	STA SpriteDMAArea + $41, Y
	INY
	INY
	INY
	INY
	INX
	CPX #$F
	BNE CastRoll_WartLaugh_Frame2_Loop

CastRoll_WartLaugh_Exit:
	RTS


CastRoll_PaletteFadeOut:
	.db $32
	.db $22
	.db $12


;
; Fades the palette to make Wart disappear
;
CastRoll_DoPaletteFadeOut:
	DEC CastRollTimer
	BPL CastRoll_DoPaletteFadeOut_Exit

	LDA #$10
	STA CastRollTimer
	LDA #$3F
	STA PPUBuffer_301
	LDA #$11
	STA PPUBuffer_301 + 1
	LDA #$01
	STA PPUBuffer_301 + 2
	LDY CastRollFadePaletteIndex
	LDA CastRoll_PaletteFadeOut, Y
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4
	INC CastRollFadePaletteIndex
	LDA CastRollFadePaletteIndex
	CMP #$03
	BNE CastRoll_DoPaletteFadeOut_Exit

	INC CastRollSequenceIndex
	LDA #$16
	STA CastRollTimer

CastRoll_DoPaletteFadeOut_Exit:
	RTS


;
; Hides the cast roll sprites to prepare for the "The End" animation
;
CastRoll_HideSprites:
	DEC CastRollTimer
	BPL CastRoll_HideSprites_Exit

	LDX #$16
	LDY #$00
	LDA #$F8

CastRoll_HideSprites_Loop:
	STA SpriteDMAArea + $40, Y
	INY
	INY
	INY
	INY
	DEX
	BPL CastRoll_HideSprites_Loop

	LDA #$30
	STA CastRollTimer

CastRoll_HideSprites_NextSequence:
	INC CastRollSequenceIndex

CastRoll_HideSprites_Exit:
	RTS


;
; Pauses before starting the "The End" animation
;
CastRoll_TheEndDelay:
	DEC CastRollTimer
	BPL CastRoll_TheEndDelay_Exit

	LDA #$00
	STA TheEndScriptWordCopyIndex
	STA TheEndScriptCounter
	STA TheEndScriptWordTileIndex
	LDA #$05
	STA TheEndScriptHoldFrameCounter
	LDA #((TheEndScript_End - TheEndScript_The) / 8 - 1)
	STA TheEndScriptWordFrameIndex

	LDA #$3F
	STA PPUBuffer_301
	LDA #$11
	STA PPUBuffer_301 + 1
	LDA #$01
	STA PPUBuffer_301 + 2
	LDA #$30
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4
	INC CastRollSequenceIndex

CastRoll_TheEndDelay_Exit:
	RTS


;
; Plays the "The End" animation
;
CastRoll_TheEndAnimation:
CastRoll_TheEndAnimation_The:
	LDA TheEndScriptCounter
	AND #$80
	BNE CastRoll_TheEndAnimation_The_Exit

	LDA TheEndScriptCounter
	BNE CastRoll_TheEndAnimation_End

	DEC TheEndScriptHoldFrameCounter
	BPL CastRoll_TheEndAnimation_The_Exit

	LDA #$05
	STA TheEndScriptHoldFrameCounter

	LDA #$03
	STA TheEndScriptWordTileIndex
	LDX #$00
	LDY TheEndScriptWordCopyIndex
CastRoll_TheEndAnimation_The_Loop:
	LDA #$40
	STA SpriteDMAArea, X
	INX
	LDA TheEndScript_The, Y
	STA SpriteDMAArea, X
	INY
	INX
	LDA #$00
	STA SpriteDMAArea, X
	INX
	LDA TheEndScript_The, Y
	STA SpriteDMAArea, X
	INY
	INX
	DEC TheEndScriptWordTileIndex
	BPL CastRoll_TheEndAnimation_The_Loop

	STY TheEndScriptWordCopyIndex
	DEC TheEndScriptWordFrameIndex
	BPL CastRoll_TheEndAnimation_The_Exit

	INC TheEndScriptCounter
	LDA #((TheEnd_RTS - TheEndScript_End) / 8 - 1)
	STA TheEndScriptWordFrameIndex
	LDA #$00
	STA TheEndScriptWordCopyIndex

CastRoll_TheEndAnimation_The_Exit:
	RTS


CastRoll_TheEndAnimation_End:
	DEC TheEndScriptHoldFrameCounter
	BPL CastRoll_TheEndAnimation_End_Exit

	LDA #$05
	STA TheEndScriptHoldFrameCounter
	LDA #$03
	STA TheEndScriptWordTileIndex
	LDX #$00
	LDY TheEndScriptWordCopyIndex
CastRoll_TheEndAnimation_End_Loop:
	LDA #$40
	STA SpriteDMAArea + $10, X
	INX
	LDA TheEndScript_End, Y
	STA SpriteDMAArea + $10, X
	INY
	INX
	LDA #$00
	STA SpriteDMAArea + $10, X
	INX
	LDA TheEndScript_End, Y
	STA SpriteDMAArea + $10, X
	INY
	INX
	DEC TheEndScriptWordTileIndex
	BPL CastRoll_TheEndAnimation_End_Loop

	STY TheEndScriptWordCopyIndex
	DEC TheEndScriptWordFrameIndex
	BPL CastRoll_TheEndAnimation_End_Exit

	LDA #$FF
	STA TheEndScriptCounter

CastRoll_TheEndAnimation_End_Exit:
	RTS


CastRoll_SpritePointersHi:
	.db >CastRoll_Mario
	.db >CastRoll_Luigi
	.db >CastRoll_Princess
	.db >CastRoll_Toad
	.db >CastRoll_Shyguy
	.db >CastRoll_Snifit
	.db >CastRoll_Ninji
	.db >CastRoll_Beezo
	.db >CastRoll_Porcupo
	.db >CastRoll_Tweeter
	.db >CastRoll_BobOmb
	.db >CastRoll_Hoopstar
	.db >CastRoll_Trouter
	.db >CastRoll_Pidgit
	.db >CastRoll_Panser
	.db >CastRoll_Flurry
	.db >CastRoll_Albatoss
	.db >CastRoll_Phanto
	.db >CastRoll_Spark
	.db >CastRoll_Subcon
	.db >CastRoll_Pokey
	.db >CastRoll_Birdo
	.db >CastRoll_Ostro
	.db >CastRoll_Autobomb
	.db >CastRoll_Cobrat
	.db >CastRoll_Mouser
	.db >CastRoll_Fryguy
	.db >CastRoll_Clawglip
	.db >CastRoll_Triclyde

CastRoll_SpritePointersLo:
	.db <CastRoll_Mario
	.db <CastRoll_Luigi
	.db <CastRoll_Princess
	.db <CastRoll_Toad
	.db <CastRoll_Shyguy
	.db <CastRoll_Snifit
	.db <CastRoll_Ninji
	.db <CastRoll_Beezo
	.db <CastRoll_Porcupo
	.db <CastRoll_Tweeter
	.db <CastRoll_BobOmb
	.db <CastRoll_Hoopstar
	.db <CastRoll_Trouter
	.db <CastRoll_Pidgit
	.db <CastRoll_Panser
	.db <CastRoll_Flurry
	.db <CastRoll_Albatoss
	.db <CastRoll_Phanto
	.db <CastRoll_Spark
	.db <CastRoll_Subcon
	.db <CastRoll_Pokey
	.db <CastRoll_Birdo
	.db <CastRoll_Ostro
	.db <CastRoll_Autobomb
	.db <CastRoll_Cobrat
	.db <CastRoll_Mouser
	.db <CastRoll_Fryguy
	.db <CastRoll_Clawglip
	.db <CastRoll_Triclyde


CastRoll_Mario:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $00, $00, $38 ; $04
	.db $D0, $02, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $04, $00, $38 ; $14
	.db $F9, $06, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $E8, $00, $2C ; $24
	.db $F9, $D0, $00, $34 ; $28
	.db $F9, $F2, $00, $3C ; $2C
	.db $F9, $E0, $00, $44 ; $30
	.db $F9, $EC, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Luigi:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $08, $00, $38 ; $04
	.db $D0, $0A, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $0C, $00, $38 ; $14
	.db $F9, $0E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $E6, $00, $2C ; $24
	.db $F9, $F8, $00, $34 ; $28
	.db $F9, $E0, $00, $3C ; $2C
	.db $F9, $DC, $00, $44 ; $30
	.db $F9, $E0, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Princess:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $10, $00, $38 ; $04
	.db $D0, $12, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $14, $00, $38 ; $14
	.db $F9, $16, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $EE, $00, $20 ; $20
	.db $F9, $F2, $00, $28 ; $24
	.db $F9, $E0, $00, $30 ; $28
	.db $F9, $EA, $00, $38 ; $2C
	.db $F9, $D4, $00, $40 ; $30
	.db $F9, $D8, $00, $48 ; $34
	.db $F9, $F4, $00, $50 ; $38
	.db $F9, $F4, $00, $58 ; $3C
CastRoll_Toad:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $18, $00, $38 ; $04
	.db $D0, $1A, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $1C, $00, $38 ; $14
	.db $F9, $1E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $3E, $00, $28 ; $24
	.db $F9, $F6, $00, $30 ; $28
	.db $F9, $EC, $00, $38 ; $2C
	.db $F9, $D0, $00, $40 ; $30
	.db $F9, $D6, $00, $48 ; $34
	.db $F9, $3E, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Shyguy:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $3E, $00, $38 ; $04
	.db $D0, $3E, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $20, $00, $38 ; $14
	.db $F9, $22, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $F4, $00, $28 ; $24
	.db $F9, $DE, $00, $30 ; $28
	.db $F9, $CC, $00, $38 ; $2C
	.db $F9, $DC, $00, $40 ; $30
	.db $F9, $F8, $00, $48 ; $34
	.db $F9, $CC, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Snifit:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $3E, $00, $38 ; $04
	.db $D0, $3E, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $24, $00, $38 ; $14
	.db $F9, $26, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $F4, $00, $28 ; $24
	.db $F9, $EA, $00, $30 ; $28
	.db $F9, $E0, $00, $38 ; $2C
	.db $F9, $DA, $00, $40 ; $30
	.db $F9, $E0, $00, $48 ; $34
	.db $F9, $F6, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Ninji:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $3E, $00, $38 ; $04
	.db $D0, $3E, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $28, $00, $38 ; $14
	.db $F9, $2A, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $EA, $00, $2C ; $24
	.db $F9, $E0, $00, $34 ; $28
	.db $F9, $EA, $00, $3C ; $2C
	.db $F9, $E2, $00, $44 ; $30
	.db $F9, $E0, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Beezo:
	.db $D0, $3E, $00, $30 ; $00
	.db $D0, $3E, $00, $38 ; $04
	.db $D0, $3E, $00, $40 ; $08
	.db $D0, $3E, $00, $48 ; $0C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $2C, $00, $38 ; $14
	.db $F9, $2E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $D2, $00, $2C ; $24
	.db $F9, $D8, $00, $34 ; $28
	.db $F9, $D8, $00, $3C ; $2C
	.db $F9, $CE, $00, $44 ; $30
	.db $F9, $EC, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Porcupo:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $30, $00, $38 ; $14
	.db $F9, $32, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $EE, $00, $24 ; $20
	.db $F9, $EC, $00, $2C ; $24
	.db $F9, $F2, $00, $34 ; $28
	.db $F9, $D4, $00, $3C ; $2C
	.db $F9, $F8, $00, $44 ; $30
	.db $F9, $EE, $00, $4C ; $34
	.db $F9, $EC, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Tweeter:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $34, $00, $38 ; $14
	.db $F9, $36, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $F6, $00, $24 ; $20
	.db $F9, $FC, $00, $2C ; $24
	.db $F9, $D8, $00, $34 ; $28
	.db $F9, $D8, $00, $3C ; $2C
	.db $F9, $F6, $00, $44 ; $30
	.db $F9, $D8, $00, $4C ; $34
	.db $F9, $F2, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_BobOmb:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $38, $00, $38 ; $14
	.db $F9, $3A, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $D2, $00, $24 ; $20
	.db $F9, $EC, $00, $2C ; $24
	.db $F9, $D2, $00, $34 ; $28
	.db $F9, $3E, $00, $3C ; $2C
	.db $F9, $EC, $00, $44 ; $30
	.db $F9, $E8, $00, $4C ; $34
	.db $F9, $D2, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Hoopstar:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $3C, $00, $38 ; $14
	.db $F9, $3C, $40, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $DE, $00, $20 ; $20
	.db $F9, $EC, $00, $28 ; $24
	.db $F9, $EC, $00, $30 ; $28
	.db $F9, $EE, $00, $38 ; $2C
	.db $F9, $F4, $00, $40 ; $30
	.db $F9, $F6, $00, $48 ; $34
	.db $F9, $D0, $00, $50 ; $38
	.db $F9, $F2, $00, $58 ; $3C
CastRoll_Trouter:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $40, $00, $38 ; $14
	.db $F9, $42, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $F6, $00, $24 ; $20
	.db $F9, $F2, $00, $2C ; $24
	.db $F9, $EC, $00, $34 ; $28
	.db $F9, $F8, $00, $3C ; $2C
	.db $F9, $F6, $00, $44 ; $30
	.db $F9, $D8, $00, $4C ; $34
	.db $F9, $F2, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Pidgit:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $44, $00, $38 ; $14
	.db $F9, $46, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $EE, $00, $28 ; $24
	.db $F9, $E0, $00, $30 ; $28
	.db $F9, $D6, $00, $38 ; $2C
	.db $F9, $DC, $00, $40 ; $30
	.db $F9, $E0, $00, $48 ; $34
	.db $F9, $F6, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Panser:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $48, $00, $38 ; $14
	.db $F9, $4A, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $EE, $00, $28 ; $24
	.db $F9, $D0, $00, $30 ; $28
	.db $F9, $EA, $00, $38 ; $2C
	.db $F9, $F4, $00, $40 ; $30
	.db $F9, $D8, $00, $48 ; $34
	.db $F9, $F2, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Flurry:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $4C, $00, $38 ; $14
	.db $F9, $4E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $DA, $00, $28 ; $24
	.db $F9, $E6, $00, $30 ; $28
	.db $F9, $F8, $00, $38 ; $2C
	.db $F9, $F2, $00, $40 ; $30
	.db $F9, $F2, $00, $48 ; $34
	.db $F9, $CC, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Albatoss:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $50, $00, $30 ; $10
	.db $F9, $52, $00, $38 ; $14
	.db $F9, $54, $00, $40 ; $18
	.db $F9, $56, $00, $48 ; $1C
	.db $F9, $D0, $00, $20 ; $20
	.db $F9, $E6, $00, $28 ; $24
	.db $F9, $D2, $00, $30 ; $28
	.db $F9, $D0, $00, $38 ; $2C
	.db $F9, $F6, $00, $40 ; $30
	.db $F9, $EC, $00, $48 ; $34
	.db $F9, $F4, $00, $50 ; $38
	.db $F9, $F4, $00, $58 ; $3C
CastRoll_Phanto:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $68, $00, $38 ; $14
	.db $F9, $68, $40, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $EE, $00, $28 ; $24
	.db $F9, $DE, $00, $30 ; $28
	.db $F9, $D0, $00, $38 ; $2C
	.db $F9, $EA, $00, $40 ; $30
	.db $F9, $F6, $00, $48 ; $34
	.db $F9, $EC, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Spark:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $6A, $00, $38 ; $14
	.db $F9, $6A, $40, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $F4, $00, $2C ; $24
	.db $F9, $EE, $00, $34 ; $28
	.db $F9, $D0, $00, $3C ; $2C
	.db $F9, $F2, $00, $44 ; $30
	.db $F9, $E4, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Subcon:
	.db $D0, $3E, $00, $30
	.db $D0, $3E, $00, $38 ; 4
	.db $D0, $3E, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $6C, $00, $38 ; $14
	.db $F9, $6E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $F4, $00, $2C ; $24
	.db $F9, $F8, $00, $34 ; $28
	.db $F9, $D2, $00, $3C ; $2C
	.db $F9, $D4, $00, $44 ; $30
	.db $F9, $EC, $00, $4C ; $34
	.db $F9, $EA, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Pokey:
	.db $D0, $3E, $00, $30
	.db $D0, $60, $00, $38 ; 4
	.db $D0, $62, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $64, $00, $38 ; $14
	.db $F9, $66, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $EE, $00, $2C ; $24
	.db $F9, $EC, $00, $34 ; $28
	.db $F9, $E4, $00, $3C ; $2C
	.db $F9, $D8, $00, $44 ; $30
	.db $F9, $CC, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Birdo:
	.db $D0, $3E, $00, $30
	.db $D0, $70, $00, $38 ; 4
	.db $D0, $72, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $74, $00, $38 ; $14
	.db $F9, $76, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $D2, $00, $2C ; $24
	.db $F9, $E0, $00, $34 ; $28
	.db $F9, $F2, $00, $3C ; $2C
	.db $F9, $D6, $00, $44 ; $30
	.db $F9, $EC, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Ostro:
	.db $D0, $3E, $00, $30
	.db $D0, $78, $00, $38 ; 4
	.db $D0, $7A, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $7C, $00, $38 ; $14
	.db $F9, $7E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $24 ; $20
	.db $F9, $EC, $00, $2C ; $24
	.db $F9, $F4, $00, $34 ; $28
	.db $F9, $F6, $00, $3C ; $2C
	.db $F9, $F2, $00, $44 ; $30
	.db $F9, $EC, $00, $4C ; $34
	.db $F9, $3E, $00, $54 ; $38
	.db $F9, $3E, $00, $5C ; $3C
CastRoll_Autobomb:
	.db $D0, $3E, $00, $30
	.db $D0, $80, $00, $38 ; 4
	.db $D0, $82, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $84, $00, $38 ; $14
	.db $F9, $86, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $D0, $00, $20 ; $20
	.db $F9, $F8, $00, $28 ; $24
	.db $F9, $F6, $00, $30 ; $28
	.db $F9, $EC, $00, $38 ; $2C
	.db $F9, $D2, $00, $40 ; $30
	.db $F9, $EC, $00, $48 ; $34
	.db $F9, $E8, $00, $50 ; $38
	.db $F9, $D2, $00, $58 ; $3C
CastRoll_Cobrat:
	.db $D0, $3E, $00, $30
	.db $D0, $58, $00, $38 ; 4
	.db $D0, $5A, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $3E, $00, $30 ; $10
	.db $F9, $5C, $00, $38 ; $14
	.db $F9, $5E, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $D4, $00, $28 ; $24
	.db $F9, $EC, $00, $30 ; $28
	.db $F9, $D2, $00, $38 ; $2C
	.db $F9, $F2, $00, $40 ; $30
	.db $F9, $D0, $00, $48 ; $34
	.db $F9, $F6, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Mouser:
	.db $D0, $88, $00, $30
	.db $D0, $8A, $00, $38 ; 4
	.db $D0, $8C, $00, $40 ; 8
	.db $D0, $3E, $00, $48 ; $C
	.db $F9, $8E, $00, $30 ; $10
	.db $F9, $90, $00, $38 ; $14
	.db $F9, $92, $00, $40 ; $18
	.db $F9, $3E, $00, $48 ; $1C
	.db $F9, $3E, $00, $1C ; $20
	.db $F9, $E8, $00, $24 ; $24
	.db $F9, $EC, $00, $2C ; $28
	.db $F9, $F8, $00, $34 ; $2C
	.db $F9, $F4, $00, $3C ; $30
	.db $F9, $D8, $00, $44 ; $34
	.db $F9, $F2, $00, $4C ; $38
	.db $F9, $3E, $00, $54 ; $3C
CastRoll_Fryguy:
	.db $D0, $AA, $00, $30
	.db $D0, $AC, $00, $38 ; 4
	.db $D0, $AE, $00, $40 ; 8
	.db $D0, $B0, $00, $48 ; $C
	.db $F9, $B2, $00, $30 ; $10
	.db $F9, $B4, $00, $38 ; $14
	.db $F9, $B6, $00, $40 ; $18
	.db $F9, $B8, $00, $48 ; $1C
	.db $F9, $3E, $00, $20 ; $20
	.db $F9, $DA, $00, $28 ; $24
	.db $F9, $F2, $00, $30 ; $28
	.db $F9, $CC, $00, $38 ; $2C
	.db $F9, $DC, $00, $40 ; $30
	.db $F9, $F8, $00, $48 ; $34
	.db $F9, $CC, $00, $50 ; $38
	.db $F9, $3E, $00, $58 ; $3C
CastRoll_Clawglip:
	.db $D0, $BA, $00, $30
	.db $D0, $BC, $00, $38 ; 4
	.db $D0, $BE, $00, $40 ; 8
	.db $D0, $C0, $00, $48 ; $C
	.db $F9, $C2, $00, $30 ; $10
	.db $F9, $C4, $00, $38 ; $14
	.db $F9, $C6, $00, $40 ; $18
	.db $F9, $C8, $00, $48 ; $1C
	.db $F9, $D4, $00, $20 ; $20
	.db $F9, $E6, $00, $28 ; $24
	.db $F9, $D0, $00, $30 ; $28
	.db $F9, $FC, $00, $38 ; $2C
	.db $F9, $DC, $00, $40 ; $30
	.db $F9, $E6, $00, $48 ; $34
	.db $F9, $E0, $00, $50 ; $38
	.db $F9, $EE, $00, $58 ; $3C
CastRoll_Triclyde:
	.db $D0, $94, $00, $30
	.db $D0, $96, $00, $38 ; 4
	.db $D0, $98, $00, $40 ; 8
	.db $D0, $9A, $00, $48 ; $C
	.db $F9, $9C, $00, $30 ; $10
	.db $F9, $9E, $00, $38 ; $14
	.db $F9, $A0, $00, $40 ; $18
	.db $F9, $A2, $00, $48 ; $1C
	.db $F9, $3E, $00, $30 ; $20
	.db $F9, $A4, $00, $38 ; $24
	.db $F9, $A6, $00, $40 ; $28
	.db $F9, $A8, $00, $48 ; $2C
	.db $F9, $3E, $00, $50 ; $30
	.db $F9, $3E, $00, $58 ; $34
	.db $F9, $3E, $00, $60 ; $38
	.db $F9, $3E, $00, $68 ; $3C
CastRoll_TriclydeText:
	.db $D0, $F6, $00, $20
	.db $D0, $F2, $00, $28 ; 4
	.db $D0, $E0, $00, $30 ; 8
	.db $D0, $D4, $00, $38 ; $C
	.db $D0, $E6, $00, $40 ; $10
	.db $D0, $CC, $00, $48 ; $14
	.db $D0, $D6, $00, $50 ; $18
	.db $D0, $D8, $00, $58 ; $1C
CastRoll_Wart:
	.db $D0, $80, $00, $28
	.db $D0, $82, $00, $30 ; 4
	.db $D0, $84, $00, $38 ; 8
	.db $D0, $86, $00, $40 ; $C
	.db $D0, $88, $00, $48 ; $10
	.db $F9, $8A, $00, $28 ; $14
	.db $F9, $8C, $00, $30 ; $18
	.db $F9, $8E, $00, $38 ; $1C
	.db $F9, $90, $00, $40 ; $20
	.db $F9, $92, $00, $48 ; $24
	.db $F9, $94, $00, $28 ; $28
	.db $F9, $96, $00, $30 ; $2C
	.db $F9, $98, $00, $38 ; $30
	.db $F9, $9A, $00, $40 ; $34
	.db $F9, $9C, $00, $48 ; $38
	.db $F9, $C0, $00, $20 ; $3C
	.db $F9, $C0, $00, $20 ; $40
	.db $F9, $FC, $00, $2C ; $44
	.db $F9, $D0, $00, $34 ; $48
	.db $F9, $F2, $00, $3C ; $4C
	.db $F9, $F6, $00, $44 ; $50
	.db $F9, $C0, $00, $50 ; $54
	.db $F9, $C0, $00, $58 ; $58

TheEndScript_The:
	.db $10, $90, $7C, $98, $7C, $A0, $7C, $A8
	.db $12, $90, $7C, $98, $7C, $A0, $7C, $A8
	.db $14, $90, $7C, $98, $7C, $A0, $7C, $A8
	.db $16, $90, $7C, $98, $7C, $A0, $7C, $A8
	.db $16, $90, $18, $98, $7C, $A0, $7C, $A8
	.db $16, $90, $1A, $98, $7C, $A0, $7C, $A8
	.db $16, $90, $1C, $98, $7C, $A0, $7C, $A8
	.db $16, $90, $1E, $98, $7C, $A0, $7C, $A8
	.db $20, $90, $1E, $98, $7C, $A0, $7C, $A8
	.db $24, $90, $1E, $98, $7C, $A0, $7C, $A8
	.db $24, $90, $28, $98, $7C, $A0, $7C, $A8
	.db $24, $90, $2A, $98, $7C, $A0, $7C, $A8
	.db $24, $90, $2A, $98, $2C, $A0, $7C, $A8
	.db $24, $90, $2A, $98, $2E, $A0, $7C, $A8
	.db $24, $90, $30, $98, $32, $A0, $7C, $A8
	.db $24, $90, $30, $98, $34, $A0, $7C, $A8
	.db $24, $90, $30, $98, $36, $A0, $7C, $A8
	.db $24, $90, $30, $98, $36, $A0, $38, $A8
	.db $24, $90, $30, $98, $3A, $A0, $3C, $A8
	.db $24, $90, $30, $98, $3E, $A0, $40, $A8
	.db $24, $90, $30, $98, $3E, $A0, $42, $A8

TheEndScript_End:
	.db $44, $B0, $46, $B8, $7C, $C0, $7C, $C8
	.db $48, $B0, $4A, $B8, $7C, $C0, $7C, $C8
	.db $4C, $B0, $4E, $B8, $7C, $C0, $7C, $C8
	.db $50, $B0, $52, $B8, $7C, $C0, $7C, $C8
	.db $54, $B0, $56, $B8, $7C, $C0, $7C, $C8
	.db $58, $B0, $5A, $B8, $7C, $C0, $7C, $C8
	.db $5C, $B0, $5E, $B8, $7C, $C0, $7C, $C8
	.db $5C, $B0, $60, $B8, $7C, $C0, $7C, $C8
	.db $5C, $B0, $62, $B8, $7C, $C0, $7C, $C8
	.db $5C, $B0, $64, $B8, $66, $C0, $7C, $C8
	.db $5C, $B0, $64, $B8, $68, $C0, $7C, $C8
	.db $5C, $B0, $64, $B8, $6A, $C0, $7C, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $6E, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $70, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $72, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $74, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $76, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $78, $C8
	.db $5C, $B0, $64, $B8, $6C, $C0, $7A, $C8

; Not actually used
TheEnd_RTS:
	RTS
