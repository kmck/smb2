DebugHook_Exit:
	JMP NMI_Exit

DoSoundProcessingAndCheckDebug:
	JSR DoSoundProcessing

	; Are you pressing select?
	LDA Player1JoypadPress
	CMP #ControllerInput_Select
	BNE DebugHook_Exit

	; And you're not holding start?
	LDA Player1JoypadHeld
	AND #ControllerInput_Start
	BNE DebugHook_Exit

	JSR DebugHook_CheckEligibility
	BCS DebugHook_Exit

	; Hijack the NMI and show the debug menu
	LDA #>DebugHook_Hijack
	PHA
	LDA #<DebugHook_Hijack
	PHA
	PHP
	RTI


DebugHook_Hijack:
	; Stash the current bank
	LDA MMC3PRGBankTemp
	PHA

	; Enable the debug menu flag
	LDA #$01
	STA Debug_InMenu

	; Stash a bunch of stuff
	JSR DebugHook_BackupScroll
	JSR DebugHook_BackupRAM

	; Swap to the debug/credits bank
	LDA #PRGBank_A_B
	JSR ChangeMappedPRGBank

	; And off we go
	JMP DebugMenu_Init


;
; Similar idea to JumpToTableAfterJump
;
DebugHook_ExitToAddressAfterJump:
	STA Debug_StashA
	STX Debug_StashX
	STY Debug_StashY
	PHP
	PLA
	STA Debug_StashP

	; Save the source address
	PLA
	STA byte_RAM_A
	PLA
	STA byte_RAM_B

	; Determine the jump address
	LDY #$01
	LDA (byte_RAM_A), Y
	STA Debug_JumpAddressLo
	INY
	LDA (byte_RAM_A), Y
	STA Debug_JumpAddressHi

DebugHook_ExitToJumpAddress:
	LDA #$00
	STA Debug_InMenu

	JSR DebugHook_RestoreRAM

	; Restore the previous bank
	PLA
	; JSR ChangeMappedPRGBank

	; Forget about all those registers and processor flags
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP

	; Forget that RTI
	PLA
	PLA
	PLA

	; And forget whatever this address was
	PLA
	PLA

	; Restore the registers and processor flags
	LDA Debug_StashP
	PHP
	LDA Debug_StashA
	LDX Debug_StashX
	LDY Debug_StashY
	PLP

IF INES_MAPPER == MAPPER_MMC5
	CLI
ENDIF

	; Jump to the destination
	JMP (Debug_JumpAddressLo)


;
; Check if the game conditions are good for entering the debug menu.
; If the menu can be accessed, carry will be clear.
;
DebugHook_CheckEligibility:
	; Not already in debug menu
	LDA Debug_InMenu
	BNE +f

	; Require current mode to be normal gameplay
	LDA StackArea
	CMP #Stack100_Gameplay
	BNE +f

	; Disable while scrolling
	LDA NeedsScroll
	AND #%00000100
	BNE +f

	; Disable the background is drawing
	LDA byte_RAM_537
	BEQ +f

	; Disable while in subspace/jar
	LDA InSubspaceOrJar
	BNE +f

	; Disable while player is busy
	LDA PlayerState
	CMP #PlayerState_ClimbingAreaTransition
	BCS +f

	CLC
	RTS

+f
	SEC
	RTS


;
; Stash the scroll information so that unpause can restore it later.
;
; Similar to StashScreenScrollPosition in Bank 0 except that it doesn't change
; the current PPU scroll position.
;
DebugHook_BackupScroll:
	LDA PPUScrollYMirror
	STA PPUScrollYMirror_Backup
	LDA PPUScrollXMirror
	STA PPUScrollXMirror_Backup
	LDA PPUScrollYHiMirror
	STA PPUScrollYHiMirror_Backup
	LDA PPUScrollXHiMirror
	STA PPUScrollXHiMirror_Backup
	LDA ScreenYHi
	STA ScreenYHi_Backup
	LDA ScreenYLo
	STA ScreenYLo_Backup
	LDA ScreenBoundaryLeftHi
	STA ScreenBoundaryLeftHi_Backup
	LDA byte_RAM_E1
	STA byte_RAM_517
	RTS


;
; The table below contains a bunch of RAM addresses to save/restore when
; entering and exiting the debug menu.
;
DebugPreserveAddresses:
	.dw MMC3PRGBankTemp
	; .dw MusicPlaying1
DebugPreserveAddresses_End:


DebugHook_BackupRAM:
	LDX #$00
-
	; Determine the RAM address
	TXA
	ASL
	TAY
	LDA DebugPreserveAddresses, Y
	STA byte_RAM_0
	LDA DebugPreserveAddresses + 1, Y
	STA byte_RAM_1
	; Stash the value
	LDY #$00
	LDA (byte_RAM_0), Y
	STA Debug_Stash, X
	; Next
	INX
	CPX #((DebugPreserveAddresses_End - DebugPreserveAddresses) / 2)
	BCC -
	RTS


DebugHook_RestoreRAM:
	LDX #$00
-
	; Determine the RAM address
	TXA
	ASL
	TAY
	LDA DebugPreserveAddresses, Y
	STA byte_RAM_0
	LDA DebugPreserveAddresses + 1, Y
	STA byte_RAM_1
	; Stash the value
	LDY #$00
	LDA Debug_Stash, X
	STA (byte_RAM_0), Y
	; Next
	INX
	CPX #((DebugPreserveAddresses_End - DebugPreserveAddresses) / 2)
	BCC -
	RTS


;
; Hook in to toggle status bar on select button
;
Debug_WaitForNMI_HandleSelect:
	JSR WaitForNMI

	LDA Player1JoypadPress
	AND #ControllerInput_Select
	BEQ Debug_WaitForNMI_HandleSelect_Exit

	DEC Debug_CurrentStatusBarOption
	BPL Debug_WaitForNMI_HandleSelect_Exit

	;	Wrap around
	LDA #Debug_StatusBarOptionCount
	STA Debug_CurrentStatusBarOption

Debug_WaitForNMI_HandleSelect_Exit:
	RTS

Debug_HandleStartSelect:

	LDA Player1JoypadPress
	AND #ControllerInput_Start

	RTS

;
; Execute based on the current status bar mode
;
Debug_HandleStartButton:
	LDA Debug_CurrentStatusBarOption
	JSR JumpToTableAfterJump

	.dw ShowPauseScreen
	.dw ShowPauseScreen
	.dw ShowPauseScreen
	.dw ShowPauseScreen
	.dw ShowPauseScreen


Debug_DrawStatusBar:
	LDY PPUSTATUS ; Reset PPU address latch
	LDY #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x16 | PPUCtrl_NMIDisabled
	STY PPUCTRL ; Turn off NMI

	LDY #$00
Debug_DrawStatusBar_CommandLoop:
	; Anything to draw?
	LDA DebugPPU_StatusBar, Y
	BEQ Debug_DrawStatusBar_Exit

	; Set PPU address
	STA PPUADDR
	INY
	LDA DebugPPU_StatusBar, Y
	STA PPUADDR
	INY

	; Load the number of bytes
	LDA DebugPPU_StatusBar, Y
	TAX

	INY

Debug_DrawStatusBar_TileLoop:
	LDA DebugPPU_StatusBar, Y
	STA PPUDATA
	INY
	DEX
	BNE Debug_DrawStatusBar_TileLoop

	BEQ Debug_DrawStatusBar_CommandLoop

Debug_DrawStatusBar_Exit:
	RTS


Debug_TitleScreen_Exit:
IF INES_MAPPER == MAPPER_MMC5
	; Enable status bar:
	LDA #$00
	STA Debug_CurrentStatusBarOption

	; Turn off PPU
	LDA #$00
	STA PPUMASK

	; Erase nametable D
	LDA #$2C
	JSR ClearNametableChunk

	; Swap to the debug/credits bank
	LDA #PRGBank_A_B
	JSR ChangeMappedPRGBankWithoutSaving

	; Set up the initial status bar
	JSR Debug_DrawStatusBar

	; Enable NMI and move on from the title screen
	JSR EnableNMI

	CLI
ENDIF

	JMP HideAllSprites


Debug_RequestScanlineIRQ:
	; Make sure we're in normal gameplay mode
	LDX StackArea
	CPX #Stack100_Gameplay
	BNE Debug_NoScanlineIRQ

	; Make sure we're not in the debug menu
	LDX Debug_InMenu
	BNE Debug_NoScanlineIRQ

	; Set IRQ scanline
	STA MMC5_IRQScanlineCompare
	; Enable IRQ
	LDA #$80
	STA MMC5_IRQStatus

	RTS

Debug_NoScanlineIRQ:
	LDA #$00
	STA MMC5_IRQScanlineCompare
	STA MMC5_IRQStatus

	RTS


; Upper two bits of coarse V scroll
Debug_StatusMenuScroll_11000000:
	.db ($06 & %11000000)
	.db ($26 & %11000000)
	.db (Debug_StatusBarStart & %11000000)

; Lower three bits of coarse V scroll
Debug_StatusMenuScroll_00111000:
	.db (($06 & %00111000) << 2)
	.db (($26 & %00111000) << 2)
	.db ((Debug_StatusBarStart & %00111000) << 2)

; Lower three bits of fine V scroll
Debug_StatusMenuScroll_00000111:
	.db ($06 & %00000111)
	.db ($26 & %00000111)
	.db (Debug_StatusBarStart & %00000111)


Debug_SetStatusBar:
	; Update scroll position
	LDY Debug_CurrentStatusBarOption
	; See http://wiki.nesdev.com/w/index.php/PPU_scrolling#Split_X.2FY_scroll
	; and also https://forums.nesdev.com/viewtopic.php?f=2&t=7784#post_content78593
	LDA #%00001100
	STA PPUADDR
	LDA Debug_StatusMenuScroll_11000000, Y
	ORA Debug_StatusMenuScroll_00000111, Y
	STA PPUSCROLL
	LDA #$00
	STA PPUSCROLL
	LDA Debug_StatusMenuScroll_00111000, Y
	STA PPUADDR

	; Swap CHR Data
	LDA #CHRBank_CharacterSelectSprites + 1
	STA MMC5_CHRBankSwitch1
	STA MMC5_CHRBankSwitch2
	STA MMC5_CHRBankSwitch3
	STA MMC5_CHRBankSwitch4
	STA MMC5_CHRBankSwitch8
	STA MMC5_CHRBankSwitch9
	STA MMC5_CHRBankSwitch10
	STA MMC5_CHRBankSwitch11

	LDA #CHRBank_TitleScreenBG2 + 1
	STA MMC5_CHRBankSwitch12

	; Hide sprites
	LDA #%00001010
	STA PPUMASK

	RTS


Debug_SetAreaBackground:
	LDA PPUCtrlMirror
	STA PPUCTRL
	LDA PPUScrollXMirror
	STA PPUSCROLL
	LDA PPUScrollYMirror
	CLC
	ADC BackgroundYOffset
	STA PPUSCROLL
	LDA PPUMaskMirror
	STA PPUMASK

	RTS


Debug_NMI_PauseOrMenu:
	JMP NMI_PauseOrMenu
Debug_NMI_Transition:
	JMP NMI_Transition

Debug_NMI:
	PHP
	PHA
	TXA
	PHA
	TYA
	PHA

	; ; Disable IRQ
	; LDA #$00
	; STA MMC5_IRQStatus

	; JMP NMI_CheckStackArea

DebugNMI_CheckStackArea:
	; @TODO: Load this from a table
	LDA #(Debug_StatusBarStart - 1)
	JSR Debug_RequestScanlineIRQ

	BIT StackArea
	BPL Debug_NMI_PauseOrMenu ; branch if bit 7 was 0

	BVC Debug_NMI_Transition ; branch if bit 6 was 0

	LDA #$00
	STA PPUMASK
	STA OAMADDR
	LDA #$02
	STA OAM_DMA

	; Make sure we don't have background tiles to draw
	LDA HasScrollingPPUTilesUpdate
	BNE Debug_NMI_ChangeCHRBanks

	; Make sure we don't have background tiles to draw
	LDA PPUBuffer_301
	BNE Debug_NMI_ChangeCHRBanks

	; Update the status bar
	LDA #PRGBank_A_B
	JSR ChangeMappedPRGBankWithoutSaving

	JSR Debug_DrawStatusBarUpdates

Debug_NMI_ChangeCHRBanks:
	JSR ChangeCHRBanks

	LDA NMIWaitFlag
	BNE Debug_NMI_Waiting

	JMP NMI_CheckWaitFlag

Debug_NMI_Waiting:
	LDA PPUCtrlMirror
	STA PPUCTRL
	LDA PPUScrollXMirror
	STA PPUSCROLL
	LDA PPUScrollYMirror
	CLC
	ADC BackgroundYOffset
	STA PPUSCROLL

	JMP NMI_Waiting

Debug_IRQ:
	; Save all registers
	PHP
	PHA
	TXA
	PHA
	TYA
	PHA

	; Disable interrupts
	SEI

	; Acknowledge interrupt
	BIT MMC5_IRQStatus
	BPL Debug_IRQ_Exit ; No scanline is pending

	JSR Debug_SetStatusBar

Debug_IRQ_Exit:
	; Restore all registers
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP

	RTI
