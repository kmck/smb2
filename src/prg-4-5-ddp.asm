loc_D100:
FDSNoteFrequencyData:
.db $00, $A2
.db $00, $AC
.db $00, $F3
.db $03, $96
.db $04, $07
.db $04, $44
.db $04, $85
.db $04, $CA
.db $05, $13
.db $05, $60
.db $05, $B2
.db $06, $08
.db $06, $64
.db $07, $2D
.db $08, $0E
.db $09, $0A
.db $09, $95
.db $0A, $C0
.db $0C, $11
.db $0C, $C9
.db $0E, $5A
.db $00
loc_D12B:
.db $00 ; $00
loc_D12C:
.db $40 ; $01
.db $30 ; $02
.db $10 ; $03
.db $23 ; $04
.db $51 ; $05
.db $2D ; $06
.db $46 ; $07
.db $20 ; $08

.db $34 ; $09
.db $3A ; $0A
.db $30 ; $0B
.db $40 ; $0C
.db $43 ; $0D
.db $2D ; $0E
.db $16 ; $0F
.db $30 ; $10

.db $87, $1A, $80, $22, $24, $00, $87, $16
.db $2A, $2A, $0E, $12, $2A, $2A, $06, $00
.db $85, $14, $00, $80, $1C, $1E, $20, $22
.db $24, $26, $82, $28, $00, $82, $06, $00
.db $80, $04, $04, $04, $80, $04, $2A, $83
.db $04, $00, $80, $02, $2A, $88, $04, $00
.db $82, $10, $00, $80, $08, $00, $87, $08
.db $0A, $80, $0C, $87, $16, $14, $80, $12
.db $00, $83, $0E, $00

loc_D180:
ModEnvelope_D180:
.db $80, $02, $80, $00
.db $00, $60

loc_D186:
VolumeEnvelope_D186:
.db $90, $01, $43, $08, $A0, $10
.db $1F, $18

loc_D18E:
ModEnvelope_D18E:
.db $A0, $01, $43, $08, $01, $04
.db $3F, $40, $00, $18
loc_D198:
.db $03, $06, $0C, $18, $08, $12, $24, $04
.db $80, $04, $09, $12, $24, $48, $1B, $36
.db $06, $06, $0C, $18, $30, $60, $24, $48
.db $08

;----------------
;--------sub start--------
StartProcessingSoundQueue:
  JSR SoundInitialize
sub_D1B1:
  LDA $0100
  CMP #$41
  BNE loc_D1BC
  LDA #$0C
  BNE loc_D1BE
loc_D1BC:
  LDA #$0F
loc_D1BE:
  STA $4015
  LDA #$FF
  STA $4017
  JSR sub_D2A5 ; sfx
  JSR sub_D46B ; music 2
  JSR sub_D20C ; sfx priority based
  LDA #$00
  STA $0604
  STA $0603
  STA $0602
  STA $0601
  STA $0600
  RTS
;----------------
loc_D1E1:
  STY $0605
  LDA #$24
  LDX #$82
  LDY #$A8
  JSR sub_DE61
  LDA #$22
  STA $0618
;----------------
loc_D1F2:
  LDA $0618
  CMP #$20
  BNE loc_D1FF
  LDX #$DF
  LDY #$F6
  BNE loc_D207
loc_D1FF:
  CMP #$1A
  BNE loc_D258
  LDX #$C1
  LDY #$BC
loc_D207:
  JSR sub_DE5A
  BNE loc_D258
;----------------
;--------sub_D20C()--------
sub_D20C:
  LDA $0605 ; SFXPlaying3
  LDY $0604 ; SFXQueue3
  LSR $0604
  BCS loc_D1E1
  LSR A
  BCS loc_D1F2
  LSR A
  BCS loc_D274
  LSR $0604
  BCS loc_D263
  LSR $0604
  BCS loc_D23B
  LSR A
  BCS loc_D24C
  LSR $0604
  BCS loc_D289
  LSR A
  BCS loc_D291
  LSR $0604
  BCS loc_D25A
  LSR A
  BCS loc_D274
  RTS
;----------------
loc_D23B:
  STY $0605
  LDA #$35
  LDX #$8D
  STA $0618
  LDY #$7F
  LDA #$3E
  JSR sub_DE61
loc_D24C:
  LDA $0618
  CMP #$30
  BNE loc_D258
  LDA #$54
  STA $4002
loc_D258:
  BNE loc_D274
loc_D25A:
  STY $0605
  LDA #$60
  LDY #$A5
  BNE loc_D26A
loc_D263:
  STY $0605
  LDA #$05
  LDY #$9C
loc_D26A:
  LDX #$9E
  STA $0618
  LDA #$46
  JSR sub_DE61
loc_D274:
  DEC $0618
  BNE loc_D288
  LDX #$06
  STX $4015
  LDX #$0F
  STX $4015
  LDX #$00
  STX $0605
loc_D288:
  RTS
;----------------
loc_D289:
  STY $0605
  LDA #$02
  STA $0618
loc_D291:
  LDA #$1A
  STA $400C
  LDA #$04
  STA $400E
  STA $400F
  LDA #$0E
  STA $4015
  BNE loc_D274
;--------sub_D2A5()--------
sub_D2A5:
  LDA $0607
  AND #%10110000
  BNE loc_D2EB
  LDA $0602; SFXQueue2
  BNE loc_D2CD
  LDA $0601 ; SFXQueue1
  BNE loc_D2C1
  LDA $0607 ; SFXPlaying2
  BNE loc_D2EB
  LDA $060E ; SFXPlaying1
  BNE loc_D2F7
  RTS
;----------------
loc_D2C1:
  STA $060E
  LDY #$00
  STY $0607
  LDY #$08
  BNE loc_D2D5
loc_D2CD:
  STA $0607
  LDY #$00
  STY $060E
loc_D2D5:
  INY
  LSR A
  BCC loc_D2D5
  STY $C5
  JSR sub_D3E5
  LDY $C5
  LDA loc_D12B,Y
  STA $061F
  LDA #$01
  STA $05F1
;----------------
loc_D2EB:
  LDA $05F1
  CMP #$02
  BNE loc_D2F7
  LDA #$00
  ; STA $4080 ;;;
  JSR SetVolumeEnvelope
loc_D2F7:
  DEC $05F1
  BNE loc_D367
  LDY $061F
  INC $061F
  LDA loc_D12C,Y
  BEQ loc_D30B
  BPL loc_D328
  BNE loc_D319
loc_D30B:
  LDA #$80
  ; STA $4080 ;;;
  JSR SetVolumeEnvelope
  LDA #$00
  STA $0607
  STA $060E
  RTS
;----------------
loc_D319:
  JSR sub_DFED
  STA $05F2
  LDY $061F
  INC $061F
  LDA loc_D12C,Y
loc_D328:
  JSR sub_DE8A
  TAY
  BNE loc_D335
  LDX #$80
  ; STX $4080 ;;;
  JSR SetVolumeEnvelopeX
  BNE loc_D33B
loc_D335:
  JSR sub_D43E
  LDY $05F7
loc_D33B:
  STY $05F3
  LDY #$00
  STY $05F9
  STY $05FB
  LDA ($BF),Y
  ; STA $4080 ;;;
  JSR SetVolumeEnvelope
  LDA ($C1),Y
  ; STA $4084 ;;;
  JSR SetModEnvelope
  INY
  LDA ($BF),Y
  STA $05F8
  LDA ($C1),Y
  STA $05FA
  STY $05F9
  STY $05FB
  LDA $05F2
  STA $05F1
loc_D367:
  LDA $05F3
  BEQ loc_D3B4
  DEC $05F3
  DEC $05F8
  BNE loc_D38F
loc_D374:
  INC $05F9
  LDY $05F9
  LDA ($BF),Y
  BPL loc_D383
  ; STA $4080 ;;;
  JSR SetVolumeEnvelope
  BNE loc_D374
loc_D383:
  ; STA $4080 ;;;
  JSR SetVolumeEnvelope
  INY
  LDA ($BF),Y
  STA $05F8
  STY $05F9
loc_D38F:
  DEC $05FA
  BNE loc_D3B4
  INC $05FB
  LDY $05FB
  LDA ($C1),Y
  ; STA $4084 ;;;
  JSR SetModEnvelope
  INY
  LDA ($C1),Y
  ; STA $4086 ;;;
  JSR SetModFrequencyLo
  INY
  LDA ($C1),Y
  ; STA $4087 ;;;
  JSR SetModFrequencyHi
  INY
  LDA ($C1),Y
  STA $05FA
  STY $05FB
loc_D3B4:
  RTS
;----------------
;--------loc_D3B5--------
loc_D3B5:
.db $07, $07, $07, $07, $01, $01, $01, $01
.db $01, $01, $01, $01, $07, $07, $07, $07
.db $33, $22, $21, $10, $07, $76, $66, $55
.db $55, $66, $67, $70, $01, $12, $22, $33
.db $33, $33, $33, $33, $33, $33, $33, $33
.db $55, $55, $55, $55, $55, $55, $55, $55
;----------------
;--------sub_D3E5()--------
sub_D3E5:
  LDY $C5
  BEQ loc_D3B4
  LDA ExpansionSFXOffset-1,Y
  ; LDA loc_DE9C,Y
  TAY

  LDA ExpansionSFX-16,Y
  ; LDA loc_DE9D,Y
  STA $BD
  LDA ExpansionSFX-15,Y
  ; LDA loc_DE9E,Y
  STA $BE
  LDA ExpansionSFX-14,Y
  ; LDA loc_DE9F,Y
  STA $05F7
  LDA ExpansionSFX-13,Y
  ; LDA loc_DEA0,Y
  STA $BF
  LDA ExpansionSFX-12,Y
  ; LDA loc_DEA1,Y
  STA $C0
  LDA ExpansionSFX-11,Y
  ; LDA loc_DEA2,Y
  STA $C1
  LDA ExpansionSFX-10,Y
  ; LDA loc_DEA3,Y
  STA $C2
  LDA ExpansionSFX-09,Y
  ; LDA loc_DEA4,Y
  STA $05FC
  LDA ExpansionSFX-08,Y
  ; LDA loc_DEA5,Y
  STA $05FD
  LDA #$80
  ; STA $4089 ;;;
  JSR SetWaveWrite
  ASL A
  ; STA $4040 ;;;
  JSR SetWavetableRAM
  TAY
  LDX #$3F
loc_D429:
  LDA ($BD),Y
  ; STA $4041,Y ;;;
  JSR SetWavetableRAMOffsetY
  INY
  CPY #$20
  BEQ loc_D439
  ; STA $4040,X ;;;
  JSR SetWavetableRAMOffsetX
  DEX
  BNE loc_D429
loc_D439:
  LDA #$00
  ; STA $4089 ;;;
  JSR SetWaveWrite
;--------sub_D43E()--------
sub_D43E:
  LDA #$80
  ; STA $4087 ;;;
  JSR SetModFrequencyHi
  LDA $05FC
  ; STA $4085 ;;;
  JSR SetModCounter
  LDX #$20
  LDY $05FD
  STY $C6
loc_D450:
  LDA $C6
  LSR A
  TAY
  LDA loc_D3B5,Y
  BCS loc_D45D
  LSR A
  LSR A
  LSR A
  LSR A
loc_D45D:
  AND #$0F
  ; STA $4088 ;;;
  JSR SetModTableWrite
  INC $C6
  DEX
  BNE loc_D450
  RTS
;----------------
loc_D468:
  JMP loc_D511
;--------sub_D46B()--------
sub_D46B:
  LDA $0603 ; MusicQueue2
  BNE loc_D47E
  LDA $0600 ; MusicQueue1
  BNE loc_D48E
  LDA $0606 ; MusicPlaying2
  ORA $0608 ; MusicPlaying1
  BNE loc_D468
  RTS
;----------------
loc_D47E:
  STA $0606
  LDX $0608
  STX $061A
  LDY #$00
  STY $0608
  BEQ loc_D4CC
loc_D48E:
  LDX #$00
  STX $0606
  CMP #$01 ; song 1
  BNE loc_D49B
  LDY #$13
  BNE loc_D49D
loc_D49B:
  LDY #$10
loc_D49D:
  STY $061D
loc_D4A0:
  STA $0608
  CMP #$02 ; song 2
  BNE loc_D4B5
  INC $061D
  LDY $061D
  CPY #$14
  BNE loc_D4D0
  LDY #$11
  BNE loc_D49D
loc_D4B5:
  CMP #$01
  BNE loc_D4C7
  INC $061D
  LDY $061D
  CPY #$1A
  BNE loc_D4D0
  LDY #$14
  BNE loc_D49D
loc_D4C7:
  LDY #$08
  STY $060A
loc_D4CC:
  INY
  LSR A
  BCC loc_D4CC
loc_D4D0:
  LDA loc_D6BE,Y
  TAY
  LDA loc_D6BE+1,Y
  STA $0609
  LDA loc_D6BE+2,Y
  STA $BB
  LDA loc_D6BE+3,Y
  STA $BC
  LDA loc_D6BE+4,Y
  STA $060C
  LDA loc_D6BE+5,Y
  STA $060B
  LDA loc_D6BE+7,Y
  STA $05F4
  LDA loc_D6BE+6,Y
  STA $060D
  STA $061B
  LDA #$01
  STA $0611
  STA $0613
  STA $0616
  STA $0617
  LSR A
  STA $060A
loc_D511:
  DEC $0611
  BNE loc_D570
  LDY $060A
  INC $060A
  LDA ($BB),Y
  BEQ loc_D524
  BPL loc_D55C
  BNE loc_D54E
loc_D524:
  LDA $0608
  AND #$7F
  BNE loc_D548
  LDA $0606
  AND #$25
  BEQ loc_D53C
  LDA #$00
  STA $0606
  LDA $061A
  BNE loc_D54B
loc_D53C:
  LDA #$00
  STA $0608
  STA $0606
  STA $4015
  RTS
;----------------
loc_D548:
  JMP loc_D4A0
;--------loc_D54B--------
loc_D54B:
  JMP loc_D48E
;----------------
loc_D54E:
  JSR sub_DFE2
  STA $0610
  LDY $060A
  INC $060A
  LDA ($BB),Y
loc_D55C:
  JSR sub_DE82
  BEQ loc_D564
  JSR sub_D64F
loc_D564:
  STA $0612
  JSR sub_DE78
  LDA $0610
  STA $0611
loc_D570:
  LDY $0612
  BEQ loc_D578
  DEC $0612
loc_D578:
  JSR sub_D661
  STA $4004
  LDX #$7F
  STX $4005
  LDY $060B
  BEQ loc_D5D0
  DEC $0613
  BNE loc_D5B8
loc_D58D:
  LDY $060B
  INC $060B
  LDA ($BB),Y
  BNE loc_D59C
  LDY #$80
  JMP loc_D58D
loc_D59C:
  JSR sub_DFDC
  STA $0613
  LDY $0605
  BNE loc_D5D0
  TXA
  AND #$3E
  JSR sub_DE64
  BEQ loc_D5B2
  JSR sub_D64F
loc_D5B2:
  STA $0614
  JSR sub_DE5A
loc_D5B8:
  LDA $0605
  BNE loc_D5D0
  LDY $0614
  BEQ loc_D5C5
  DEC $0614
loc_D5C5:
  JSR sub_D661
  STA $4000
  LDA #$7F
  STA $4001
loc_D5D0:
  LDA $060C
  BEQ loc_D612
  DEC $0616
  BNE loc_D612
  LDY $060C
  INC $060C
  LDA ($BB),Y
  BPL loc_D5F4
  JSR sub_DFE2
  STA $0615
  LDY $060C
  INC $060C
  LDA ($BB),Y
  BEQ loc_D60F
loc_D5F4:
  JSR sub_DE86
  LDX $0615
  STX $0616
  LDA $0606
  AND #$09
  BNE loc_D60D
  TXA
  CMP #$1C
  BCS loc_D60D
  LDA #$18
  BNE loc_D60F
loc_D60D:
  LDA #$7F
loc_D60F:
  STA $4008
loc_D612:
  LDA $060D
  BEQ loc_D64E
  DEC $0617
  BNE loc_D64E
loc_D61C:
  LDY $060D
  INC $060D
  LDA ($BB),Y
  BNE loc_D62E
  LDA $061B
  STA $060D
  BNE loc_D61C
loc_D62E:
  JSR sub_DFDC
  STA $0617
  TXA
  AND #$3E
  LSR A
L8538:
  LSR A
  LSR A
  LSR A
L853B:
  TAY
  LDA loc_DFD0,Y
  STA $400C
  LDA loc_DFD4,Y
  STA $400E
  LDA loc_DFD8,Y
  STA $400F
;----------------
loc_D64E:
  RTS
;----------------
;--------sub_D64F()--------
sub_D64F:
  LDA $0610
  CMP #$17
  BCS loc_D65A
  LDA #$0F
  BNE loc_D65C
loc_D65A:
  LDA #$27
loc_D65C:
  LDX #$82
  LDY #$7F
  RTS
;----------------
;--------sub_D661()--------
sub_D661:
  LDA $0610
  CMP #$17
  BCS loc_D66D
  LDA loc_D679,Y
  BNE loc_D670
loc_D66D:
  LDA loc_D689,Y
loc_D670:
  LDX $05F4
  BMI loc_D676
  RTS
;----------------
loc_D676:
  ORA #$D0
  RTS
;----------------
;--------loc_D679--------
loc_D679:
.db $90, $94, $94, $94, $95, $95, $95, $95
.db $96, $96, $96, $96, $96, $97, $97, $98
loc_D689:
.db $90, $91, $91, $91, $92, $92, $92, $93
.db $93, $93, $93, $93, $93, $94, $94, $94
.db $94, $94, $94, $94, $94, $95, $95, $95
.db $95, $95, $95, $96, $96, $96, $96, $96
.db $96, $96, $96, $96, $97, $97, $97, $97
.db $68, $DE, $AE, $F4, $05, $30, $01, $60
.db $09, $D0, $60, $09, $D0
; @TODO: These are probably like...jump tables?
loc_D6BE: ; song pointers
.db $60 ; $00
loc_D6BF: ; channel offsets relative to this address
.db $8C ; $01 (from loc_D6BE)
.db $31 ; $02 (from loc_D6BE)
.db $69 ; $03 (from loc_D6BE)
.db $38 ; $04 (from loc_D6BE)
.db $70 ; $05 (from loc_D6BE)
.db $69 ; $06 (from loc_D6BE)
.db $8C ; $07 (from loc_D6BE)
.db $19 ; $08 (from loc_D6BE)
.db $23 ; $09 (from loc_D6BE)
.db $2A ; $0a (from loc_D6BE)
.db $62 ; $0b (from loc_D6BE)
.db $7E ; $0c (from loc_D6BE)
.db $77 ; $0d (from loc_D6BE)
.db $85 ; $0e (from loc_D6BE)
.db $93 ; $0f (from loc_D6BE)

.db (loc_D6D8 - loc_D6BF) ; $0f (from loc_D6BF)
.db (loc_D6DB - loc_D6BF) ; $10 (from loc_D6BF)
.db (loc_D6E2 - loc_D6BF) ; $11 (from loc_D6BF)
.db (loc_D6E9 - loc_D6BF) ; $12 (from loc_D6BF)
.db (loc_D6FE - loc_D6BF) ; $13 (from loc_D6BF)
.db (loc_D705 - loc_D6BF) ; $14 (from loc_D6BF)
.db (loc_D70C - loc_D6BF) ; $15 (from loc_D6BF)
.db (loc_D713 - loc_D6BF) ; $16 (from loc_D6BF)
.db (loc_D70C - loc_D6BF) ; $17 (from loc_D6BF)
.db (loc_D71A - loc_D6BF) ; $18 (from loc_D6BF)

loc_D6D8:
.db $09, <loc_D78E, >loc_D78E ; $19
loc_D6DB:
.db $00, <loc_D759, >loc_D759, $52, $36, $87, $80 ; $1c
loc_D6E2:
.db $00, <loc_D7EE, >loc_D7EE, $66, $42, $88, $80 ; $23
loc_D6E9:
.db $00, <loc_D82C, >loc_D82C, $47, $26, $4D, $80 ; $2a
loc_D6F0:
.db $00, <loc_DCBE, >loc_DCBE, $3B, $27, $00, $01 ; $31
loc_D6F7:
.db $09, <loc_D884, >loc_D884, $14, $0C, $00, $01 ; $38
loc_D6FE:
.db $09, <loc_D89F, >loc_D89F, $23, $13, $35, $01 ; $3f
loc_D705:
.db $09, <loc_D8E0, >loc_D8E0, $96, $54, $B7, $01 ; $46
loc_D70C:
.db $09, <loc_D9A4, >loc_D9A4, $C5, $6C, $EF, $01 ; $4d
loc_D713:
.db $09, <loc_D9EA, >loc_D9EA, $9A, $5F, $A9, $01 ; $54
loc_D71A:
.db $09, <loc_DA98, >loc_DA98, $2B, $1A, $39, $01 ; $5b
loc_D721:
.db $11, <loc_DAD6, >loc_DAD6, $3A, $28, $00, $80 ; $62
loc_D728:
.db $00, <loc_DB41, >loc_DB41, $14, $0D, $00, $80 ; $69
loc_D72F:
.db $00, <loc_DB72, >loc_DB72, $16, $0E, $00, $01 ; $70
loc_D736:
.db $09, <loc_DB91, >loc_DB91, $41, $25, $00, $01 ; $77
loc_D73D:
.db $09, <loc_DBF3, >loc_DBF3, $82, $42, $00, $80 ; $7e
loc_D744:
.db $09, <loc_DC9D, >loc_DC9D, $00, $12, $00, $01 ; $85
loc_D74B:
.db $11, <loc_DB61, >loc_DB61, $00, $0A, $00, $01 ; $8c
loc_D752:
.db $09, <loc_DD0E, >loc_DD0E, $83, $4B, $00, $01 ; $8c

; .db $00, $59, $D7, $52, $36, $87, $80 ; $1c
; .db $00, $EE, $D7, $66, $42, $88, $80 ; $23
; .db $00, $2C, $D8, $47, $26, $4D, $80 ; $2a
; .db $00, $BE, $DC, $3B, $27, $00, $01 ; $31
; .db $09, $84, $D8, $14, $0C, $00, $01 ; $38
; .db $09, $9F, $D8, $23, $13, $35, $01 ; $3f
; .db $09, $E0, $D8, $96, $54, $B7, $01 ; $46
; .db $09, $A4, $D9, $C5, $6C, $EF, $01 ; $4d
; .db $09, $EA, $D9, $9A, $5F, $A9, $01 ; $54
; .db $09, $98, $DA, $2B, $1A, $39, $01 ; $5b
; .db $11, $D6, $DA, $3A, $28, $00, $80 ; $62
; .db $00, $41, $DB, $14, $0D, $00, $80 ; $69
; .db $00, $72, $DB, $16, $0E, $00, $01 ; $70
; .db $09, $91, $DB, $41, $25, $00, $01 ; $77
; .db $09, $F3, $DB, $82, $42, $00, $80 ; $7e
; .db $09, $9D, $DC, $00, $12, $00, $01 ; $85
; .db $11, $61, $DB, $00, $0A, $00, $01 ; $8c
; .db $09, $0E, $DD, $83, $4B, $00, $01 ; $8c

loc_D759:
.db $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A
.db $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A
.db $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A
.db $82, $32, $06, $2E, $06
loc_D78E:
.db $00, $21, $E1, $07, $E1, $07, $E1, $07, $E1, $1F, $DF
.db $07, $DF, $07, $DF, $07, $DF, $1D, $DD, $07, $DD, $07, $DD, $07, $DD, $A8, $86
.db $9C, $86, $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06
.db $87, $2A, $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06
.db $87, $2A, $84, $2A, $87, $2A, $84, $06, $87, $2A, $84, $06, $87, $2A, $84, $06
.db $87, $2A, $82, $20, $06, $28, $06, $E0, $C6, $00, $84, $06, $87, $2A, $84, $06
.db $87, $24, $82, $32, $32

loc_D7EE:
.db $82, $32, $06, $32, $84, $06, $87, $32, $84, $06, $87, $2A, $84, $06, $87, $24
.db $83, $20, $82, $2A, $06, $2A, $84, $06, $87, $2A, $84, $06, $87, $24, $84, $06
.db $87, $1E, $83, $1A, $82, $32, $06, $32, $84, $06, $87, $32, $84, $06, $87, $2A
.db $84, $06, $87, $24, $82, $32, $32, $81, $2A, $85, $06, $83, $06, $00
loc_D82C:
.db $83, $06, $06, $00, $A0, $86, $A0, $07, $E1, $07, $DB, $07, $DB, $D2, $9E, $86
.db $9E, $07, $DF, $07, $D7, $07, $D7, $D2, $9C, $86, $9C, $07, $DD, $07, $D7, $07
.db $C3, $A0, $A0, $5A, $47, $C6, $C6, $C6, $82, $12, $06, $12, $06, $12, $06, $12
.db $06, $16, $06, $16, $06, $16, $06, $16, $06, $20, $06, $20, $06, $20, $06, $20
.db $06, $12, $06, $83, $06, $06, $06, $83, $06, $06, $90, $A0, $00, $E1, $E1, $E1
.db $21, $E1, $E1, $C7, $E1, $E1, $C7, $E1
loc_D884:
.db $81, $06, $87, $30, $06, $28, $20, $06, $1C, $83, $1A, $00, $46, $E1, $C7, $D7
.db $C3, $C7, $CF, $CA, $81, $06, $82, $28, $20, $83, $12
loc_D89F:
.db $87, $06, $06, $36, $04, $06, $34, $2E, $06, $28, $24, $06, $22, $82, $20, $36
.db $20, $06, $00, $C7, $C7, $E9, $E7, $C7, $E5, $DD, $C7, $D7, $D3, $C7, $C3, $82
.db $A8, $9C, $86, $87, $06, $06, $2E, $2C, $06, $2A, $28, $06, $20, $1C, $06, $1A
.db $82, $16, $2E, $16, $20, $C6, $C6, $90, $D1, $D1, $D1, $D1, $C7, $D1, $D1, $D1
.db $D1
loc_D8E0:
.db $87, $36, $06, $2A, $32, $06, $82, $36, $87, $2A, $32, $06, $36, $28, $30, $36
.db $3E, $06, $83, $3C, $87, $06, $36, $06, $26, $2E, $06, $82, $36, $87, $26, $2E
.db $06, $36, $2C, $32, $36, $3E, $06, $83, $3C, $87, $3E, $46, $06, $3E, $46, $06
.db $82, $3C, $87, $46, $3E, $06, $3C, $36, $06, $04, $36, $06, $82, $32, $87, $2C
.db $2E, $06, $32, $34, $06, $32, $34, $06, $82, $28, $87, $32, $2E, $06, $83, $2A
.db $06, $87, $06, $00, $EB, $C7, $DB, $E1, $C7, $AA, $DB, $E1, $C7, $EB, $D9, $E1
.db $E9, $F1, $C7, $E8, $C7, $E7, $C7, $D7, $E1, $C7, $A6, $D7, $E1, $C7, $E7, $DB
.db $E5, $ED, $F3, $C7, $EC, $F3, $FD, $C7, $F7, $FD, $C7, $B4, $FD, $F7, $C7, $C5
.db $F3, $C7, $F1, $F3, $C7, $AA, $E5, $E9, $C7, $ED, $EF, $C7, $EB, $EF, $C7, $A0
.db $EB, $E9, $C7, $E0, $C6, $C7, $82, $12, $20, $12, $20, $02, $20, $02, $20, $10
.db $20, $10, $20, $0E, $20, $0E, $20, $08, $1C, $44, $1E, $0A, $20, $0E, $24, $16
.db $1C, $0A, $16, $12, $0A, $12, $06, $86, $90, $86, $90, $86, $90, $D1, $D1, $D1
.db $D1, $C7, $D1, $00
loc_D9A4:
.db $87, $06, $06, $82, $32, $87, $06, $36, $06, $06, $3C, $06, $83, $46, $87, $06
.db $3C, $06, $36, $32, $06, $2A, $2E, $06, $32, $2E, $06, $32, $2E, $06, $24, $06
.db $06, $82, $2E, $80, $24, $2E, $24, $2E, $24, $2E, $24, $2E, $24, $2E, $24, $2E
.db $87, $06, $82, $2E, $87, $32, $2E, $06, $32, $2E, $06, $32, $06, $06, $82, $3C
.db $87, $36, $3C, $06, $36, $00
loc_D9EA:
.db $87, $32, $06, $2E, $2A, $06, $82, $32, $80, $20, $32, $20, $32, $20, $32, $20
.db $32, $20, $32, $20, $32, $87, $06, $06, $87, $06, $06, $36, $06, $30, $06, $28
.db $06, $24, $06, $20, $06, $00, $C7, $C7, $A0, $C7, $EB, $C7, $C7, $F3, $C7, $F6
.db $C7, $F3, $C7, $EB, $E5, $C7, $E1, $DF, $C7, $E1, $DF, $C7, $E1, $DF, $C7, $D7
.db $C7, $C7, $9E, $16, $1E, $16, $16, $1E, $16, $1E, $16, $1E, $16, $1E, $16, $C7
.db $9C, $E1, $DD, $C7, $E1, $DD, $C7, $E1, $C7, $C7, $AA, $E9, $EB, $C7, $E9, $E1
.db $C7, $DD, $DB, $C7, $AA, $1A, $2A, $1A, $2A, $1A, $2A, $1A, $2A, $1A, $2A, $1A
.db $2A, $C7, $C7, $C7, $C7, $E9, $C7, $E5, $C7, $E1, $C7, $DD, $C7, $D9, $C7, $82
.db $12, $16, $1A, $20, $24, $20, $1A, $12, $16, $1A, $1E, $0E, $87, $16, $06, $1A
.db $82, $12, $02, $0E, $0A, $20, $1C, $16, $02, $0A, $82, $0E, $02, $12, $14, $16
.db $18, $87, $1A, $06, $02, $82, $0E, $0A, $02, $B0, $D1, $C7, $D1, $00
loc_DA98:
.db $87, $3C, $06, $36, $32, $06, $83, $2A, $87, $1E, $20, $06, $22, $24, $06, $2A
.db $06, $06, $82, $06, $87, $2A, $82, $06, $06, $00, $EB, $C7, $E9, $E1, $C7, $DA
.db $86, $C7, $DD, $C7, $DB, $C7, $C7, $86, $DB, $86, $86, $0E, $02, $12, $0A, $0E
.db $02, $12, $87, $06, $06, $12, $82, $06, $06, $B0, $D1, $C7, $D1, $00
loc_DAD6:
.db $81, $52, $58, $08, $22, $06, $85, $24, $81, $52, $58, $08, $22, $06, $85, $20
.db $82, $06, $85, $2A, $26, $82, $1C, $85, $22, $82, $26, $81, $18, $82, $1C, $85
.db $12, $85, $16, $86, $18, $82, $06, $00, $47, $98, $5B, $47, $98, $57, $86, $5D
.db $59, $92, $59, $9C, $50, $92, $49, $4B, $8D, $86, $81, $08, $12, $1C, $24, $06
.db $26, $1C, $12, $08, $12, $1C, $24, $06, $22, $1C, $12, $08, $12, $1C, $12, $06
.db $22, $1C, $12, $08, $12, $1C, $12, $06, $22, $1C, $12, $08, $12, $1C, $12, $06
.db $22, $1C, $12, $08, $12, $1C, $12, $06, $22, $1C, $12
loc_DB41:
.db $85, $22, $81, $22, $82, $22, $82, $36, $36, $34, $86, $32, $00, $59, $58, $98
.db $A6, $A6, $A2, $A1, $85, $22, $81, $22, $82, $22, $82, $30, $30, $2C, $86, $2A
loc_DB61:
.db $87, $28, $2A, $2C, $2E, $06, $36, $82, $34, $00, $E1, $E5, $E7, $E9, $C7, $F3
.db $AE
loc_DB72:
.db $81, $36, $3C, $46, $20, $24, $2A, $0A, $0E, $82, $12, $0A, $12, $00, $86, $52
.db $86, $52, $86, $92, $9C, $9A, $82, $06, $85, $46, $2A, $82, $12, $20, $12
loc_DB91:
.db $82, $04, $81, $3C, $06, $82, $04, $81, $3C, $06, $36, $3C, $3A, $3A, $06, $3C
.db $3A, $06, $82, $04, $81, $3C, $06, $82, $48, $81, $3C, $06, $4E, $4C, $4A, $3A
.db $06, $3C, $36, $06, $00, $A4, $6E, $46, $A4, $6E, $46, $58, $5C, $60, $60, $46
.db $5C, $60, $46, $A4, $6E, $46, $84, $6E, $46, $7A, $7C, $76, $70, $46, $6E, $70
.db $46, $81, $16, $24, $16, $24, $16, $24, $16, $24, $18, $26, $18, $26, $18, $26
.db $18, $26, $16, $24, $16, $24, $16, $24, $16, $24, $18, $26, $18, $26, $18, $26
.db $18, $26
loc_DBF3:
.db $81, $16, $18, $18, $16, $18, $18, $16, $18, $16, $18, $18, $16, $18, $18, $16
.db $18, $16, $18, $18, $16, $18, $18, $16, $18, $16, $18, $18, $16, $18, $18, $16
.db $18, $1A, $1C, $1C, $1A, $1C, $1C, $1A, $1C, $1A, $1C, $1C, $1A, $1C, $1C, $1A
.db $1C, $1A, $1C, $1C, $1A, $1C, $1C, $1A, $1C, $1A, $1C, $1C, $1A, $1C, $1C, $1A
.db $1C, $00, $46, $64, $64, $46, $64, $64, $46, $64, $46, $64, $64, $46, $64, $64
.db $46, $64, $46, $62, $62, $46, $62, $62, $46, $62, $46, $62, $62, $46, $62, $62
.db $46, $62, $46, $68, $68, $46, $68, $68, $46, $68, $46, $68, $68, $46, $68, $68
.db $46, $68, $46, $66, $66, $46, $66, $66, $46, $66, $46, $66, $66, $46, $66, $66
.db $46, $66, $85, $1E, $1E, $82, $1E, $85, $1E, $1E, $82, $1E, $85, $1C, $1C, $82
.db $1C, $85, $1C, $1C, $82, $1C, $85, $22, $22, $82, $22, $85, $22, $22, $82, $22
.db $85, $20, $20, $82, $20, $85, $20, $20, $82, $20
loc_DC9D:
.db $81, $32, $38, $3C, $3E, $06, $3C, $38, $34, $32, $34, $30, $34, $06, $32, $2A
.db $30, $00, $06, $72, $78, $7C, $BE, $7C, $78, $74, $72, $74, $70, $B4, $72, $6A
.db $70
loc_DCBE:
.db $81, $24, $2A, $2E, $24, $2A, $2E, $20, $24, $32, $20, $24, $34, $32, $2A, $24
.db $06, $1C, $24, $2A, $32, $2E, $20, $24, $06, $12, $06, $0A, $0E, $06, $0A, $42
.db $06, $82, $58, $0A, $12, $06, $00, $86, $92, $86, $92, $86, $96, $86, $9A, $86
.db $A4, $86, $A8, $AA, $60, $A4, $60, $9A, $92, $86, $EA, $82, $1C, $34, $1E, $04
.db $20, $36, $24, $3C, $2E, $1C, $20, $2E, $2A, $06, $06, $06, $2A, $20, $12, $06
loc_DD0E:
.db $85, $36, $04, $82, $2E, $85, $04, $34, $82, $2C, $85, $34, $32, $82, $2A, $81
.db $30, $86, $2E, $81, $06, $85, $3C, $38, $82, $32, $85, $38, $36, $82, $30, $85
.db $36, $04, $82, $2E, $81, $34, $86, $32, $81, $06, $30, $2E, $30, $2E, $30, $2E
.db $30, $2E, $32, $30, $32, $30, $32, $30, $32, $30, $34, $32, $34, $32, $34, $32
.db $34, $32, $04, $34, $04, $34, $04, $34, $04, $34, $00, $67, $65, $9C, $65, $63
.db $9A, $63, $61, $98, $5E, $9D, $46, $6B, $69, $A0, $69, $67, $9E, $67, $65, $9C
.db $64, $A3, $46, $64, $62, $64, $62, $64, $62, $64, $62, $66, $64, $66, $64, $66
.db $64, $66, $64, $68, $66, $68, $66, $68, $66, $68, $66, $6A, $68, $6A, $68, $6A
.db $68, $6A, $68, $81, $20, $24, $26, $20, $24, $26, $20, $26, $20, $24, $26, $20
.db $24, $26, $20, $26, $20, $24, $26, $20, $24, $26, $20, $26, $20, $24, $26, $20
.db $24, $26, $20, $26, $1E, $22, $24, $1E, $22, $24, $1E, $24, $1E, $22, $24, $1E
.db $22, $24, $1E, $24, $1E, $22, $24, $1E, $22, $24, $1E, $24, $1E, $22, $24, $1E
.db $22, $24, $1E, $24, $81, $1C, $82, $1C, $1C, $1C, $81, $1C, $1E, $82, $1E, $1E
.db $1E, $81, $1E, $20, $82, $20, $20, $20, $81, $20, $22, $82, $22, $22, $22, $81
.db $22, $00, $02, $02, $02, $42, $02, $02, $00, $02, $02, $22, $00, $2E, $10, $02
.db $00
loc_DDFF: ; unused?
.db $42
loc_DE00:
.db $00
loc_DE01:
.db $88, $01, $C4, $00, $97, $00, $00, $02
.db $80, $02, $3A, $02, $1A, $01, $FC, $01
.db $DF, $01, $AB, $01, $93, $01, $7C, $01
.db $67, $01, $53, $01, $40, $01, $2E, $01
.db $1D, $01, $0D, $00, $FE, $00, $EF, $00
.db $E2, $00, $D5, $00, $C9, $00, $BE, $00
.db $B3, $00, $A9, $00, $A0, $00, $8E, $00
.db $86, $00, $77, $00, $7E, $00, $71, $03
.db $27, $02, $A6, $02, $5C, $00, $6A, $00
.db $5F, $00, $59, $00, $50, $00, $47, $05
.db $4D, $05, $01, $03, $F8, $03, $89, $03
.db $57
;----------------
;--------sub_DE5A()--------
sub_DE5A:
  STY $4001
  STX $4000
  RTS
;----------------
;--------sub_DE61--------
sub_DE61:
  JSR sub_DE5A
;----------------
;--------sub_DE64()--------
sub_DE64:
  LDX #$00
loc_DE66:
  TAY
  LDA loc_DE01,Y
  BEQ loc_DE77
  STA $4002,X
  LDA loc_DE00,Y
  ORA #$08
  STA $4003,X
loc_DE77:
  RTS
;----------------
;--------sub_DE78()--------
sub_DE78:
  STX $4004
  STY $4005
  RTS
;----------------
;--------sub_DE7F()--------
sub_DE7F:
  JSR sub_DE78
;----------------
;--------sub_DE82()--------
sub_DE82:
  LDX #$04
  BNE loc_DE66
;--------sub_DE86()--------
sub_DE86:
  LDX #$08
  BNE loc_DE66
sub_DE8A:
  ; reset waveform
  LDX #$80
  ; STX $4083 ;;;
  JSR SetFrequencyHiX
  ; set frequency
  TAY
  ;;;
  JSR SetToneWithOffsetY
  ;;;
  ; LDA FDSNoteFrequencyData,Y
  ; STA $4083 ;;;
  ; JSR SetFrequencyHi
  ; LDA FDSNoteFrequencyData+1,Y
  ; STA $4082 ;;;
  ; JSR SetFrequencyLo
  ;;;
loc_DE9C:
  RTS
;----------------
;--------loc_DE9D--------
; @TODO: Are these pointer tables or what?
; 9 values
ExpansionSFXOffset:
loc_DE9D:
.db $46 ; spit
loc_DE9E:
.db $2B ; door
loc_DE9F:
.db $2B ; cherry
loc_DEA0:
.db $2B ; throw
loc_DEA1:
.db $22 ; birdo death
loc_DEA2:
.db $4F ; birdo hit
loc_DEA3:
.db $46 ; enemy hit
loc_DEA4:
.db $34 ; player death
loc_DEA5:
.db $10 ; bomb
.db $19 ; rocket
.db $10 ; alternate bomb?
.db $10 ; lift
.db $3D ; player hit
.db $46 ; alternate spit?
.db $2B ; stopwatch
.db $46 ; mask/wart

; 2 bytes for wavetable data
; 1 byte for $05F7 ?
; 2 bytes for volume envelope
; 2 bytes for mod envelope
; 1 byte for mod counter
; 1 byte for some mod table lookup yyyyyyyc
;   y = offset in $D3B5 table
;   c = 0 for upper nybble, 1 for lower nybble
loc_DEAD:
ExpansionSFX:
; $10
.dw WavetableData_DF55
.db $18
.dw VolumeEnvelope_DF03
.dw ModEnvelope_DF07
.db $00
.db $30

; $19
.dw WavetableData_DF55
.db $FF
.dw VolumeEnvelope_DEF5
.dw ModEnvelope_DEF9
.db $00
.db $40

; $22
.dw WavetableData_DF55
.db $50
.dw VolumeEnvelope_DF0D
.dw ModEnvelope_DF11
.db $20
.db $20

; $2B
.dw WavetableData_DF75
.db $60
.dw VolumeEnvelope_DEF5
.dw ModEnvelope_D180
.db $00
.db $00

; $34
.dw WavetableData_DF35
.db $60
.dw VolumeEnvelope_DF95
.dw ModEnvelope_DFA0
.db $20
.db $40

; $3D
.dw WavetableData_DFA6
.db $30
.dw VolumeEnvelope_DF1F
.dw ModEnvelope_DF25
.db $20
.db $40

; $46
.dw WavetableData_DFA6
.db $30
.dw VolumeEnvelope_D186
.dw ModEnvelope_D18E
.db $20
.db $20

; $4F
.dw WavetableData_DF55
.db $30
.dw VolumeEnvelope_DF2F
.dw ModEnvelope_DFC6
.db $20
.db $40


; .db $55, $DF, $18, $03, $DF, $07, $DF, $00, $30 ; $10
; .db $55, $DF, $FF, $F5, $DE, $F9, $DE, $00, $40 ; $19
; .db $55, $DF, $50, $0D, $DF, $11, $DF, $20, $20 ; $22
; .db $75, $DF, $60, $F5, $DE, $80, $D1, $00, $00 ; $2B
; .db $35, $DF, $60, $95, $DF, $A0, $DF, $20, $40 ; $34
; .db $A6, $DF, $30, $1F, $DF, $25, $DF, $20, $40 ; $3D
; .db $A6, $DF, $30, $86, $D1, $8E, $D1, $20, $20 ; $46
; .db $55, $DF, $30, $2F, $DF, $C6, $DF, $20, $40 ; $4F

loc_DEF5:
VolumeEnvelope_DEF5:
.db $A0, $03, $3F, $FF

loc_DEF9:
ModEnvelope_DEF9:
.db $A0, $01, $A0, $40
.db $00, $21, $3A, $30, $00, $FF

loc_DF03:
VolumeEnvelope_DF03:
.db $A0, $01, $0B, $20

loc_DF07:
ModEnvelope_DF07:
.db $A0, $01, $0A, $0A, $00, $18

loc_DF0D:
VolumeEnvelope_DF0D:
.db $A0, $1D, $03, $40

loc_DF11:
ModEnvelope_DF11:
.db $88, $01, $46, $35
.db $0F, $0C, $1F, $40, $01, $05, $18, $80
loc_DF1D: ;;;
.db $00, $18

loc_DF1F:
VolumeEnvelope_DF1F:
.db $A0, $01, $5A, $06, $1F, $2C

loc_DF25:
ModEnvelope_DF25:
.db $A0, $01, $03, $35, $0F, $0E, $1F, $30
.db $03, $30

loc_DF2F:
VolumeEnvelope_DF2F:
.db $90, $03, $43, $16, $0B, $40

loc_DF35:
WavetableData_DF35:
.db $00, $01, $02, $03, $04, $05, $07, $09, $0B, $0D, $10, $13, $16, $19, $1C, $1F
.db $22, $25, $28, $2B, $2E, $31, $33, $35, $37, $39, $3A, $3B, $3C, $3D, $3E, $3E

loc_DF55:
WavetableData_DF55:
.db $10, $1F, $3A, $3A, $2B, $2E, $3D, $3C, $3C, $3D, $3E, $2E, $25, $33, $37, $28
.db $10, $13, $28, $22, $05, $03, $3E, $16, $09, $00, $00, $0B, $0B, $00, $00, $02

loc_DF75:
WavetableData_DF75:
.db $10, $2C, $2E, $27, $29, $2B, $2A, $28, $25, $29, $2F, $2D, $2C, $2A, $22, $24
.db $34, $3F, $31, $2D, $3A, $3B, $27, $12, $0A, $1F, $2C, $27, $23, $28, $22, $1E

loc_DF95:
VolumeEnvelope_DF95:
.db $A0, $06, $1F, $0E, $4A, $08, $0A, $08, $4A, $04, $0A

loc_DFA0:
ModEnvelope_DFA0:
.db $82, $02, $52, $05, $00
.db $60 ; RTS?

loc_DFA6:
WavetableData_DFA6:
.db $00, $0C, $15, $1B, $24, $2D, $33, $38, $3C, $3D, $3B, $39, $37, $37, $38, $34
.db $34, $32, $31, $30, $2F, $34, $2F, $2D, $2D, $2B, $29, $26, $24, $20, $19, $19

loc_DFC6:
ModEnvelope_DFC6:
.db $96, $04, $44, $35, $0F, $08, $0F
.db $20, $00, $40

loc_DFD0:
.db $10, $1E, $1F, $16
loc_DFD4:
.db $00, $03, $0A, $02
loc_DFD8:
.db $00, $18, $18, $58
;----------------
;--------sub_DFDC()--------
sub_DFDC:
  TAX
  ROR A
  TXA
  ROL A
  ROL A
  ROL A
;--------sub_DFE2()--------
sub_DFE2:
  AND #$07
  CLC
  ADC $0609
  TAY
  LDA loc_D198,Y
  RTS
;----------------
;--------sub_DFED--------
sub_DFED: ;;;
  AND #$0F
  TAY
  LDA loc_D198,Y
  RTS

loc_DFF4:
.db $1C, $00

; FDS NMI vectors
; loc_DFF6:
; .db $5D, $7F, $42, $7F, $79, $7E, $25, $75, $41, $7F

; ;;; FDS AUDIO
; SoundInitialize:
;   LDA $70CF
;   BNE +
;   LDA #$00
;   STA $4023
;   LDA #$02
;   STA $4023
;   INC $70CF
;   + RTS

; SetToneWithOffsetY:
;   LDA FDSNoteFrequencyData,Y
;   STA $4083
;   JSR SetFrequencyHi
;   LDA FDSNoteFrequencyData+1,Y
;   STA $4082
;   JSR SetFrequencyLo
;   RTS

; SetWavetableRAM:
;   STA $4040
;   RTS

; SetWavetableRAMOffsetX:
;   STA $4040,X
;   RTS

; SetWavetableRAMOffsetY:
;   STA $4041,Y
;   RTS

; SetVolumeEnvelope:
;   STA $4080
;   RTS

; SetVolumeEnvelopeX:
;   STX $4080
;   RTS

; SetFrequencyLo:
;   STA $4082
;   RTS

; SetFrequencyHi:
;   STA $4083
;   RTS

; SetFrequencyHiX:
;   STX $4083
;   RTS

; SetModEnvelope:
;   STA $4084
;   RTS

; SetModCounter:
;   STA $4085
;   RTS

; SetModFrequencyLo:
;   STA $4086
;   RTS

; SetModFrequencyHi:
;   STA $4087
;   RTS

; SetModTableWrite:
;   STA $4088
;   RTS

; SetWaveWrite:
;   STA $4089
;   RTS


;;; 5B AUDIO
SunsoftNotePeriodData:
.db $01, $59 ; $00
.db $01, $45 ; $02
.db $00, $e6 ; $04
.db $00, $3d ; $06
.db $00, $36 ; $08
.db $00, $33 ; $0a
.db $00, $30 ; $0c
.db $00, $2e ; $0e
.db $00, $2b ; $10
.db $00, $29 ; $12
.db $00, $26 ; $14
.db $00, $24 ; $16
.db $00, $22 ; $18
.db $00, $1e ; $1a
.db $00, $1b ; $1c
.db $00, $18 ; $1e
.db $00, $17 ; $20
.db $00, $14 ; $22
.db $00, $12 ; $24
.db $00, $11 ; $26
.db $00, $0f ; $28
.db $00

SoundInitialize:
  LDA $05D0
  BNE +
  LDA #$00
  STA $4023
  LDA #$02
  STA $4023
  INC $05D0

  ; Enable 5B channels
  LDA #$07
  STA $C000
  ; LDA #%00111110 ; Channel A only
  LDA #%00111000 ;;;
  STA $E000

  + RTS

SetToneWithOffsetY:
  LDA FDSNoteFrequencyData,Y
  STA $4083
  LDA (FDSNoteFrequencyData + 1),Y
  STA $4082
  ;;;

  LDA #$07
  STA $C000
  LDA #%00111110 ; Channel A only
  STA $E000

  LDA #$01
  STA $C000
  LDA SunsoftNotePeriodData,Y
  STA $E000

  LDA #$00
  STA $C000
  LDA SunsoftNotePeriodData+1,Y
  STA $E000

  ;;;
  LDA #$03
  STA $C000
  LDA SunsoftNotePeriodData,Y
  STA $E000

  LDA #$02
  STA $C000
  LDA SunsoftNotePeriodData+1,Y
  STA $E000

  LDA #$05
  STA $C000
  LDA SunsoftNotePeriodData,Y
  STA $E000

  LDA #$04
  STA $C000
  LDA SunsoftNotePeriodData+1,Y
  STA $E000

  RTS

SetWavetableRAM:
  STA $4040 ;;;

  ; PHA
  ; LDA #$00
  ; STA $C000
  ; PLA
  ; STA $E000
  RTS

SetWavetableRAMOffsetX:
  STA $4040,X ;;;

  RTS

SetWavetableRAMOffsetY:
  STA $4041,Y ;;;

  RTS

SetVolumeEnvelope:
  ; FDS behavior:
  ; 7  bit  0  (write; read through $4090)
  ; ---- ----
  ; MDVV VVVV
  ; |||| ||||
  ; ||++-++++- (M=0) Volume envelope speed
  ; ||         (M=1) Volume gain and envelope speed.
  ; |+-------- Volume change direction (0: decrease; 1: increase)
  ; +--------- Volume envelope mode (0: on; 1: off)
  STA $4080 ;;;

  BMI +
  ; (M=0) Volume envelope speed
  PHA
  LDA #$08
  STA $C000
  LDA $05D3
  ORA #%00010000
  BNE ++

  +
  ; (M=1) Volume gain and envelope speed
  PHA
  LDA #$08
  STA $C000
  PLA
  PHA
  AND #%00111111
  CMP #$20
  BCC +
  ; Clamp to $1F
  LDA #%00011111
  +
  ; too dang loud
  CMP #$06
  BCC +
  SEC
  SBC #$06
  +
  LSR A
  AND #%00001111

  ++
  STA $05D3 ; stash volume so we can maintain it when toggling envelope
  STA $E000

  PLA
  RTS

SetVolumeEnvelopeX:
  STX $4080 ;;;

  PHA
  TXA
  JSR SetVolumeEnvelope
  PLA
  RTS

SetFrequencyLo:
  ; 7  bit  0  (write)
  ; ---- ----
  ; FFFF FFFF
  ; |||| ||||
  ; ++++-++++- Bits 0-7 of frequency
  STA $4082 ;;;

  PHA
  LDA #$00
  STA $C000
  PLA
  STA $E000

  RTS

SetFrequencyHi:
  ; 7  bit  0  (write)
  ; ---- ----
  ; MExx FFFF
  ; ||   ||||
  ; ||   ++++- Bits 8-11 of frequency
  ; |+-------- Disable volume and sweep envelopes (but not modulation)
  ; +--------- When enabled, envelopes run 4x faster. Also stops the mod table accumulator.
  STA $4083 ;;;

  BPL +
  PHA
  LDA #$07
  STA $C000
  LDA #%00111111 ; Mute all
  STA $E000
  PLA
  RTS

  +
  PHA

  LDA #$07
  STA $C000
  LDA #%00111110 ; Channel A only
  STA $E000

  LDA #$01
  STA $C000
  PLA
  PHA
  AND #%00001111
  STA $E000

  PLA
  RTS

SetFrequencyHiX:
  STX $4083 ;;;

  PHA
  TXA
  JSR SetFrequencyHi
  PLA
  RTS

SetModEnvelope:
  STA $4084 ;;;

  RTS

SetModCounter:
  STA $4085 ;;;

  RTS

SetModFrequencyLo:
  STA $4086 ;;;

  RTS

SetModFrequencyHi:
  STA $4087 ;;;

  RTS

SetModTableWrite:
  STA $4088 ;;;

  RTS

SetWaveWrite:
  STA $4089 ;;;

  ; Master volume (0: full; 1: 2/3; 2: 2/4; 3: 2/5)
  PHA
  ; AND #%10000011
  AND #%00000011
  STA $05D1 ; master volume
  PLA
  PHA
  ROL
  ROL
  AND #%00000001
  STA $05D2 ; write enable and hold channel
  PLA

  ; @TODO: handle wavetable write flag
  RTS

