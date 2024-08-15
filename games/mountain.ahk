#Warn All

KEY_DELAY := 120
ENABLE_GAP := false
GAME_TITLE := "ahk_exe Mountain.exe"
; GroupAdd("GameWindow", "ahk_exe Mountain.exe")

playingSong := ""
playingCursor := 0
isPlaying := false
isThinking := false

SetKeyDelay(KEY_DELAY, 50)

^r:: {
    Reload
    return
}

#HotIf WinActive(GAME_TITLE)

playPhrase(phrase) {
    upperPhrase := StrUpper(phrase)
    if (ENABLE_GAP) {
        upperPhrase := StrReplace(upperPhrase, A_Space, "") ; 禁用停顿
    }
    if RegExMatch(upperPhrase, "[^ ZXCVBNM,ASDFGHJKQWERTYUI]") {
        MsgBox(Format("The phrase string `"{1}`" is invaild.", upperPhrase))
        return false
    }
    Loop Parse upperPhrase, " " {
        ControlSend(A_LoopField, , GAME_TITLE)
        Sleep(Floor(KEY_DELAY / 2))
    }
    return true
}

playChapter() {
    ; 持续执行指定的按键队列 可以随时终止
    global playingCursor
    key := SubStr(playingSong, playingCursor, 1)
    WinWaitActive(GAME_TITLE)
    if (key == " ") {
        Sleep(30)
    } else {
        ControlSend(key, , GAME_TITLE)
    }
    playingCursor := Mod(playingCursor + 1, StrLen(playingSong)) ; 移动当前弹奏进度的指针 自动重播无限单曲循环
    return
}

getThought() {
    ; 产生想法
    ; playPhrase("M,KJ")
    ControlSend("{sc034}", , GAME_TITLE) ; 发送按键 .
    return
}

F1:: {
    playPhrase("MMM MMM ,MN AB") ; BLOOD 血
    return
}

F2:: {
    playPhrase("BB AA SS A ,, MM NN B") ; FROGS 青蛙
    return
}

F3:: {
    playPhrase("CXZX CCC XXX CBB") ; FISH 鱼
    return
}

F4:: {
    playPhrase("CCC CCC CBZX C") ; COINS 金币
    return
}

F5:: {
    playPhrase("SSF SSF SFJH GGF") ; HEARTS 爱心
    return
}

F6:: {
    playPhrase("CVBN MBM") ; FLAMES 火流星
    return
}

F7:: {
    playPhrase("BBBB BCB") ; SNOWGLOBE 雪景球
    return
}

F8:: {
    playPhrase("VMVM AMAM ADAD ADGN ANAD") ; ARTEFACTS 人造物品
    return
}

F9:: {
    playPhrase("SSS,AAAM") ; REGEN 再生
    return
}

F12:: {
    playPhrase("SBN,ASSSS") ; LOAD 重开
    return
}

sc029:: { ; 即 ` / ~
    playPhrase("FS,N,SFS,N,S,") ; 解锁隐藏菜单 (O)
    return
}

sc00F:: { ; 即 Tab
    playPhrase("ASA,MNBVCVV") ; 解锁 3RD ROW 第三排键盘
    return
}

sc01A:: { ; 即 [
    global playingSong
    global playingCursor
    global isPlaying
    playingSong := Trim(SONG_LIST[Random(1, SONG_LIST.Length)]) ; 随机抽取一支曲子
    if (ENABLE_GAP) {
        playingSong := StrReplace(playingSong, "`n", " ")
    } else { ; 禁用停顿
        playingSong := StrReplace(playingSong, "`n", "")
        playingSong := StrReplace(playingSong, A_Space, "")
    }
    playingCursor := 1 ; 每次弹奏从头开始
    isPlaying := !isPlaying
    if (isPlaying) {
        ; MsgBox("Now playing:`n[" playingSong "]") ; debug
        SetTimer(playChapter, 50) ; 持续弹奏 维持蓝色大气层护盾
    } else {
        SetTimer(playChapter, 0)
    }
    return
}

sc01B:: { ; 即 ]
    playPhrase("AS,ZB") ; 召唤陨石
    return
}

sc035:: { ; 即 /
    global isThinking
    isThinking := !isThinking
    if (isThinking) {
        SetTimer(getThought, 50) ; 持续产生想法
    } else {
        SetTimer(getThought, 0)
    }
    return
}

#HotIf

SONG_LIST := [
    "
(
SAF FG GH FA SAF FG GHG
SAF FG GH FA SAF FGF
SAF FG GH FA SAF FG GHG
SAF FG GH FA SAF FGF
SAFFGGHFA SAFFGGHG
SAFFGGHFA SAFFGF
SAFFGGHFA SAFFGGHG
SAFFGGHFA SAFFGF
JHFSFGSF ASFJHFSFGSF
JHFSFGSF ASFNABB
AFGGFS FGHKGH FSFGGFS GFKH
AFGGFS FGHKGH FDS SDFDF
AFGGFS FGHKGH FSFGGFS GFKH
AFGGFS FGHKGH FDS SDFDF
SAF FG GH FA SAF FG GHG
SAF FG GH FA SAF FGF
SAF FG GH FA SAF FG GHG
SAF FG GH FA SAF FGF
)", ; だんご大家族
    "
(
QQGFGFH HGFGGFG GFGHKGH
QQGFGHKH HGFGGFG GFHGSAS
QQGFGFH HGFGGFG GFGHKGH
QQGFGHKH HGFGGFG GFHGSAS
FDS SASAS SASASASA SFGHG HGGH
MASAH GFGHKQH HGFGHS HGFGHKGFSF
GFH GFGHKQH HGFGFG GFG GFGHGFSS
GFH GFGHKQH HGFGHS HGFGHKGFSF
GFH GFGHKQH HGFGFG GFG GFGHGFFAS
)", ; 九九八十一
    "
(
CVBNM SAMCMNBV
CVBNM NBVCVBVCXV
CVBNM SAMCMNBV
CVBNM NBVBNM
ASMNM NMASMNM NMNBVXC XCVBNMC
MAASMNM NMASMNM NMNBVXC XCVBNMC
MAASMNM NMASMNM NMNBVXC XCVBNMC
MAASMNM NMASMNM SDFDSAM NMNBVXC
)", ; Bad Apple!!
    "
(
KQEW KQER KQEU YTT
KQEW KQER HKWQ
SDFKHHGH GHKGDFDDSM
SDFKHHGH GHKHKEWQH GHKQW
HHGH GHKGDFDDSM
SDFKHHGH GHKHKEWQ QWQ
QQQQQQKK QWEWQHHGF
QQQQQQKK HKQWE
QQQQQQKK QWEWQHHGF
GGGGGGHKHKQ EWQ
KHHHGH HJKGDD DFG
HHHAH GFGGFGKK
HHHGH HJKGDD DFG
JJHJ GFGGFGHH
SDFKHHGH GHKGDFDDSM
SDFKHHGH GHKHKEWQH GHKQW
HHGH GHKGDFDDSM
SDFKHHGH GHKHKEWQ QWQ
)", ; 鳥の詩
]