Process, Priority,, High ; 우선순위 높이기
#NoEnv ; 환경변수 사용 안함
#MaxHotkeysPerInterval 99000000 ; 핫키 반복 횟수 늘리기
#HotkeyInterval 99000000 ; 핫키 반복 횟수 늘리기
#KeyHistory 0 ; 키 히스토리 끄기
#WinActivateForce ; 윈도우 강제 활성화
#Persistent ; 종료되지 않도록
#SingleInstance off ; 한 번에 하나의 인스턴스만 실행
ListLines, off ; 명령어 실행 시간 줄이기

SetBatchLines, -1 ; 명령어 실행 시간 줄이기
SetKeyDelay, -1 ; 키 딜레이 줄이기
SetMouseDelay, -1 ; 마우스 딜레이 줄이기
SetDefaultMouseSpeed, 0 ; 마우스 속도 최대로
SetWinDelay, -1 ; 윈도우 딜레이 줄이기
SetControlDelay, -1 ; 컨트롤 딜레이 줄이기

nums := 0 ; 모드 선택 변수
xMin := ""
yMin := ""
xMax := ""
yMax := ""


checkboxClk(){ ; 체크박스 클릭
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\checkbox1.bmp ; 체크박스 이미지 검색
    If (ErrorLevel == 0){ ; 체크박스 이미지가 있으면
        MouseClick, Left, vx, vy ; 체크박스 클릭
    }
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\checkbox2.bmp ; 체크박스 이미지 검색
    If (ErrorLevel == 0){ ; 체크박스 이미지가 있으면
        MouseClick, Left, vx, vy ; 체크박스 클릭
    }
}

grdClk(){ ; 그리드 클릭
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\grd.bmp ; 그리드 이미지 검색
    If (ErrorLevel == 0){ ; 그리드 이미지가 있으면
        MouseClick, Left, vx, vy ; 그리드 클릭
    }
}

GetMessage(){ ; 메시지 가져오기
    Send, {Tab 2} ; 탭 2번
    Sleep, 10 ; 10ms 대기
    Send, ^c ; 복사
    Run, temp\temp.txt ; temp.txt 파일 열기
    Sleep, 100 ; 100ms 대기
    Send, ^a^v{Enter} ; 전체 선택 후 붙여넣기
    Send, {AltDown}{Tab}{AltUp} ; Alt + Tab
    Sleep, 100 ; 100ms 대기
    Send, {Tab}^c{AltDown}{Tab}{AltUp} ; 탭 후 복사
    Sleep, 100  ; 100ms 대기
    Send, ^v^s^w ; 붙여넣기 후 저장 후 닫기
    Sleep, 100 ; 100ms 대기
    Send, {Tab} ; 탭
    FileReadLine, val1, temp.txt, 1 ; temp.txt 파일의 첫 번째 줄 읽기
    FileReadLine, val2, temp.txt, 2 ; temp.txt 파일의 두 번째 줄 읽기
    result := val2 - val1 > 500 ? 0.35 : (val2 - val1 > 250 ? 0.3 : (val2 - val1 > 50 ? 0.28 : 0.25)) ; 결과값 계산
    Send, %result%{Tab 4}%result% ; 결과값 입력
    Sleep, 100 ; 100ms 대기
    grdClk() ; 그리드 클릭
    FileReadLine, nums, mod.txt, 1 ; mod.txt 파일의 첫 번째 줄 읽기
    send, % (nums == 1) ? "_AZ" : (nums == 2) ? "_RZ" : (nums == 3) ? "_EC" : (nums == 4) ? "_AMP_10" : "_AMP_F" ; 모드에 따라 입력
    Sleep, 100 ; 100ms 대기
    checkboxClk() ; 체크박스 클릭
    Sleep, 100 ;
    Send, {Tab 3}
    Sleep, 100
    Send, {Enter}
    Sleep, 100
    Send, {Enter}
    Return
}

skipImageClick(){
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\skip.bmp
    If (ErrorLevel == 0){
        MouseClick, Left, vx, vy
    }
    Sleep, 100
}

init(Mode){
    sendValue := 1 + Mode
    Send, {Tab 2}{Down %sendValue%}{Tab}{Down %sendValue%}{Tab}
    select:
    InputBox, num, Select Menu, AZ = 1 `nRZ = 2 `nEC = 3 `nAMP_10 = 4 `nAMP_F = 5
    Run, temp\mod.txt
    Sleep, 100
    Send, ^a
    Send, %num%{Enter} 
    Send, ^s^w
    Sleep, 250
    sendValue := (num == 1 ? 3 : num == 2 ? 9 : num == 3 ? 8 : num == 4 ? 11 : num == 5 ? 12 : Goto, select)
    If (Mode == 1)
        sendValue += 1
    Send, {Down %sendValue%}
    Sleep, 500
}

Iinit(Mode){
    num := 1
    sendValue := 1 + Mode
    Send, {Tab 2}{Down %sendValue%}{Tab}{Down %sendValue%}{Tab}
    Run, temp\mod.txt
    Sleep, 100
    Send, ^a
    Send, %num%{Enter} 
    Send, ^s^w
    Sleep, 250
    sendValue := (num == 1 ? 3 : num == 2 ? 9 : num == 3 ? 8 : num == 4 ? 11 : num == 5 ? 12 : Goto, select)
    If (Mode == 1)
        sendValue += 1
    Send, {Down %sendValue%}
    Sleep, 500
    skipImageClick()
    GetMessage()
    Sleep, 1000
    Send, {Enter}
    Sleep, 5000
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\cont.bmp
    If (ErrorLevel == 0){
        Sleep, 100
        Send, {c}
    }
    Sleep, 5000
    Send, {Enter}
    Sleep, 1000
    loop, 4{
        sendValue := 1 + Mode
        num += 1
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\data.bmp
        If (ErrorLevel == 0){
            MouseClick, Left, vx, vy
        }
        Sleep, 200
        Send, {Tab}{Down}
        Sleep, 5000
        Send, {Tab 2}{Down %sendValue%}{Tab}{Down %sendValue%}{Tab}
        Run, temp\mod.txt
        Sleep, 100
        Send, ^a
        Send, %num%{Enter} 
        Send, ^s^w
        Sleep, 250
        sendValue := (num == 1 ? 3 : num == 2 ? 9 : num == 3 ? 8 : num == 4 ? 11 : num == 5 ? 12 : Goto, select)
        If (Mode == 1)
            sendValue += 1
        Send, {Down %sendValue%}
        Sleep, 500
        skipImageClick()
        Sleep, 500
        skipImageClick()
        Sleep, 500
        GetMessage()   
        Sleep, 1000
        Send, {Enter}
        Sleep, 5000
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\cont.bmp
        If (ErrorLevel == 0){
            Sleep, 100
            Send, {c}
        }
        Sleep, 5000
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\cont.bmp
        If (ErrorLevel == 0){
            Sleep, 100
            Send, {c}
        }
        Sleep, 5000
        Send, {Enter}
        Sleep, 1000
    }
}

IMGClk(mode){
    If(mode == 0){
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\map.bmp
    }Else If(mode == 1){
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\limit.bmp
    }Else If(mode == 2){
        ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\spatial.bmp
    }
    If (ErrorLevel == 0){
        MouseClick, Left, vx, vy
    }
    Sleep, 100
}

^Numpad3::
    IMGClk(0)
    IMGClk(1)
    IMGClk(2)
    Return

^Numpad0::
    InputBox, mode, What Mode, 초기파일 = 0 `n두번째 = 1
    Iinit(mode)
    MsgBox, Done!
    Return

^Numpad1::
    init(0)
    skipImageClick()
    GetMessage() 
    MsgBox, Done!   
    Return  

^Numpad2::
    init(1)
    skipImageClick()
    GetMessage()
    MsgBox, Done!
    Return

^+r::
    Reload
    return

^+e::
    Edit
    Return