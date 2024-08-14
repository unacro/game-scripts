#Warn All

global GAME_TITLE := "ahk_exe Mountain.exe"
global KEY_DELAY := 150

SetKeyDelay(KEY_DELAY, 50)

^r:: {
    Reload
    return
}

#HotIf WinActive(GAME_TITLE)

PlayPhrase(phrase) {
    upperPhrase := StrUpper(phrase)
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

global playingCursor := 0
global isPlaying := false

PlayChapter() {
    ; 可以随时终止的按键队列
    chapter := "SAFFG GHFA SAFFG GHG SAFFG GHFA SAFFGF SAFFG GHFA SAFFG GHGSAF FGGH FASAF FGF SAFFGGHFA SAFFGGHG SAFFGGHFA SAFFGF SAFFGGHFA SAFFGGHG SAFFGGHFA SAFFGF JHFSFGSF ASFJHFSFGSF JHFSFGSF ASFNABB AFGGFS FGHKGH FSFGGFS GFKH AFGGFS FGHKGH FDS SDFDF AFGGFS FGHKGH FSFGGFS GFKH AFGGFS FGHKGH FDS SDFDF SAF FG GH FA SAF FG GHG SAF FG GH FA SAF FGF SAF FG GH FA SAF FG GHG SAF FG GH FA SAF FGF"
    key := SubStr(chapter, playingCursor, 1)
    WinWaitActive(GAME_TITLE)
    if (key == " ") {
        Sleep(30)
    } else {
        ControlSend(key, , GAME_TITLE)
    }
    global playingCursor := Mod(playingCursor + 1, StrLen(chapter)) ; 移动当前演奏进度的指针
    return
}

F1:: {
    PlayPhrase("MMM MMM ,MN AB") ; BLOOD 血
    return
}

F2:: {
    PlayPhrase("BB AA SS A ,, MM NN B") ; FROGS 青蛙
    return
}

F3:: {
    PlayPhrase("CXZX CCC XXX CBB") ; FISH 鱼
    return
}

F4:: {
    PlayPhrase("CCC CCC CBZX C") ; COINS 金币
    return
}

F5:: {
    PlayPhrase("SSF SSF SFJH GGF") ; HEARTS 爱心
    return
}

F6:: {
    PlayPhrase("CVBN MBM") ; FLAMES 火流星
    return
}

F7:: {
    PlayPhrase("BBBB BCB") ; SNOWGLOBE 雪景球
    return
}

F8:: {
    PlayPhrase("VMVM AMAM ADAD ADGN ANAD") ; ARTEFACTS 人造物品
    return
}

F9:: {
    PlayPhrase("SSS,AAAM") ; REGEN 再生
    return
}

F12:: {
    PlayPhrase("SBN,ASSSS") ; LOAD 重开
    return
}

SC029:: { ; 即 ` / ~
    PlayPhrase("FS,N,SFS,N,S,") ; 解锁隐藏菜单 (O)
    return
}

SC00F:: { ; 即 Tab
    PlayPhrase("ASA,MNBVCVV") ; 解锁 3RD ROW 第三排键盘
    return
}

SC01A:: { ; 即 [
    global isPlaying := !isPlaying
    global playingCursor := 1
    if (isPlaying) {
        SetTimer(PlayChapter, 50) ; 持续演奏 维持蓝色大气层护盾
    } else {
        SetTimer(PlayChapter, 0)
    }
    return
}

SC01B:: { ; 即 ]
    PlayPhrase("AS,ZB") ; 召唤陨石
    return
}

#HotIf