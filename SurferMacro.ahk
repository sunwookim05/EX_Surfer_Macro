Process, Priority,, High ; �켱���� ���̱�
#NoEnv ; ȯ�溯�� ��� ����
#MaxHotkeysPerInterval 99000000 ; ��Ű �ݺ� Ƚ�� �ø���
#HotkeyInterval 99000000 ; ��Ű �ݺ� Ƚ�� �ø���
#KeyHistory 0 ; Ű �����丮 ����
#WinActivateForce ; ������ ���� Ȱ��ȭ
#Persistent ; ������� �ʵ���
#SingleInstance off ; �� ���� �ϳ��� �ν��Ͻ��� ����
ListLines, off ; ��ɾ� ���� �ð� ���̱�

SetBatchLines, -1 ; ��ɾ� ���� �ð� ���̱�
SetKeyDelay, -1 ; Ű ������ ���̱�
SetMouseDelay, -1 ; ���콺 ������ ���̱�
SetDefaultMouseSpeed, 0 ; ���콺 �ӵ� �ִ��
SetWinDelay, -1 ; ������ ������ ���̱�
SetControlDelay, -1 ; ��Ʈ�� ������ ���̱�

nums := 0 ; ��� ���� ����
xMin := ""
yMin := ""
xMax := ""
yMax := ""


checkboxClk(){ ; üũ�ڽ� Ŭ��
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\checkbox1.bmp ; üũ�ڽ� �̹��� �˻�
    If (ErrorLevel == 0){ ; üũ�ڽ� �̹����� ������
        MouseClick, Left, vx, vy ; üũ�ڽ� Ŭ��
    }
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\checkbox2.bmp ; üũ�ڽ� �̹��� �˻�
    If (ErrorLevel == 0){ ; üũ�ڽ� �̹����� ������
        MouseClick, Left, vx, vy ; üũ�ڽ� Ŭ��
    }
}

grdClk(){ ; �׸��� Ŭ��
    ImageSearch, vx, vy, 0, 0, 5000, 1080, *30 imgs\grd.bmp ; �׸��� �̹��� �˻�
    If (ErrorLevel == 0){ ; �׸��� �̹����� ������
        MouseClick, Left, vx, vy ; �׸��� Ŭ��
    }
}

GetMessage(){ ; �޽��� ��������
    Send, {Tab 2} ; �� 2��
    Sleep, 10 ; 10ms ���
    Send, ^c ; ����
    Run, temp\temp.txt ; temp.txt ���� ����
    Sleep, 100 ; 100ms ���
    Send, ^a^v{Enter} ; ��ü ���� �� �ٿ��ֱ�
    Send, {AltDown}{Tab}{AltUp} ; Alt + Tab
    Sleep, 100 ; 100ms ���
    Send, {Tab}^c{AltDown}{Tab}{AltUp} ; �� �� ����
    Sleep, 100  ; 100ms ���
    Send, ^v^s^w ; �ٿ��ֱ� �� ���� �� �ݱ�
    Sleep, 100 ; 100ms ���
    Send, {Tab} ; ��
    FileReadLine, val1, temp.txt, 1 ; temp.txt ������ ù ��° �� �б�
    FileReadLine, val2, temp.txt, 2 ; temp.txt ������ �� ��° �� �б�
    result := val2 - val1 > 500 ? 0.35 : (val2 - val1 > 250 ? 0.3 : (val2 - val1 > 50 ? 0.28 : 0.25)) ; ����� ���
    Send, %result%{Tab 4}%result% ; ����� �Է�
    Sleep, 100 ; 100ms ���
    grdClk() ; �׸��� Ŭ��
    FileReadLine, nums, mod.txt, 1 ; mod.txt ������ ù ��° �� �б�
    send, % (nums == 1) ? "_AZ" : (nums == 2) ? "_RZ" : (nums == 3) ? "_EC" : (nums == 4) ? "_AMP_10" : "_AMP_F" ; ��忡 ���� �Է�
    Sleep, 100 ; 100ms ���
    checkboxClk() ; üũ�ڽ� Ŭ��
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
    InputBox, mode, What Mode, �ʱ����� = 0 `n�ι�° = 1
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