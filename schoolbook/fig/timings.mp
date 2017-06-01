verbatimtex
%&latex
\documentclass{article}
\usepackage[cp1251]{inputenc}
\usepackage[english,russian]{babel}
\begin{document}
etex

prologues:=0;

u:=17pt;

utick  := u;
utock  := u;
uclock := utick + utock;
ulevel := u;

signalScale := 1bp;

def Tick(expr sigId, clock) = 
  tickX := clock * uclock;
  tickY := sigId * 2ulevel + ulevel;
  
  draw (tickX,tickY)--
       (tickX+utick,tickY)--
       (tickX+utick,tickY-ulevel) withpen pencircle scaled signalScale;
enddef;

def Tock(expr sigId, clock) = 
  tockX := clock * uclock + utick;
  tockY := sigId * 2ulevel;
  
  draw (tockX,tockY)--
       (tockX+utock,tockY)--
       (tockX+utock,tockY+ulevel) withpen pencircle scaled signalScale;
enddef;

def Clock(expr sigId, clock) = 
    Tick(sigId, clock);
    Tock(sigId, clock);
enddef;

def Clocks(expr sigId, clockStart, clockEnd) = 
    for i=clockStart step 1 until clockEnd:
        Clock(sigId, i);
    endfor;
enddef;

def Up(expr sigId, clock) = 
    upX := clock * uclock;
    upY := sigId * 2ulevel + ulevel;
  
    draw (upX,upY)--
         (upX+uclock,upY) withpen pencircle scaled signalScale;
enddef;

def Ups(expr sigId, clockStart, clockEnd) = 
    for i=clockStart step 1 until clockEnd:
        Up(sigId, i);
    endfor;
enddef;

def Dn(expr sigId, clock) = 
    dnX := clock * uclock;
    dnY := sigId * 2ulevel;
  
    draw (dnX,dnY)--
         (dnX+uclock,dnY) withpen pencircle scaled signalScale;
enddef;

def Dns(expr sigId, clockStart, clockEnd) = 
    for i=clockStart step 1 until clockEnd:
        Dn(sigId, i);
    endfor;
enddef;

def Edge(expr sigId, clock) = 
    edgeX := clock * uclock;
    edgeY := sigId * 2ulevel + ulevel;
  
    draw (edgeX,edgeY)--
         (edgeX,edgeY-ulevel) withpen pencircle scaled signalScale;
enddef;

def Und(expr sigId, clock) = 
    undX := clock * uclock;
    undY := sigId * 2ulevel + 1/2ulevel;
  
    draw (undX,undY)--
         (undX+uclock,undY) withpen pencircle scaled signalScale;
enddef;

def Unds(expr sigId, clockStart, clockEnd) = 
    for i=clockStart step 1 until clockEnd:
        Und(sigId, i);
    endfor;
enddef;

def Data(expr sigId, clockStart, clockEnd) = 
    dataX := clockStart * uclock;
    dataY := sigId * 2ulevel + 1/2ulevel;
    
    deltaX := 1/10uclock;
    
    clockCount := (clockEnd - clockStart) + 1;

    draw (dataX,dataY)--
         (dataX+deltaX,dataY+1/2ulevel)--
         (dataX+clockCount*uclock-deltaX,dataY+1/2ulevel)--
         (dataX+clockCount*uclock,dataY) withpen pencircle scaled signalScale;
    draw (dataX,dataY)--
         (dataX+deltaX,dataY-1/2ulevel)--
         (dataX+clockCount*uclock-deltaX,dataY-1/2ulevel)--
         (dataX+clockCount*uclock,dataY) withpen pencircle scaled signalScale;
enddef;

def SigLabel(expr labelTex, sigId) =
    dnX := 0;
    dnY := sigId * 2ulevel;
    label.ulft(labelTex, (dnX,dnY));
enddef;

def DataLabel(expr labelTex, sigId, clock) =
    dnX := clock * uclock + 1/2uclock;
    dnY := sigId * 2ulevel;
    label.top(labelTex, (dnX,dnY));
enddef;

def ClkLabel(expr text, clockId, clock) =
    x := 1/2uclock;
    y := clockId * 2ulevel;
    
    label.bot(text, (x + uclock*clock, y));
enddef;

def ClkLabels(expr clockId, clockStart, clockEnd) =
    x := 1/2uclock;
    y := clockId * 2ulevel;
    
    for i=clockStart step 1 until clockEnd:
        label.bot(decimal i, (x,y));
        x := x + uclock;
    endfor;
enddef;

def Grid(expr sigIdStart, sigIdEnd, clockStart, clockEnd) = 
    x   := clockStart * uclock;
    upY := sigIdEnd * 2ulevel + ulevel;
    dnY := sigIdStart * 2ulevel;
    
    for i=clockStart step 1 until (clockEnd + 1):
        draw (x,upY)--
             (x,dnY) withpen pencircle scaled signalScale dashed withdots;
        x := x + uclock;
    endfor;
enddef;

%Договоримся о следующих осведомительных и управляющих сигналах
%P0(TASK)  – «Задание на шине» от ЦУУ
%P1(BUS)  – «Шина твоя» от ЦУУ
%Y0(READY) – «Свободен» в ЦУУ
%Y1(RESULT)  – «Результат готов» в ЦУУ
%X(DATA)

%постановка задачи
beginfig(1)
    DataId  :=  2;
    TaskId  :=  1;
    ClkId   :=  0;
    ReadyId := -1;

    Grid(-1,2,0,8);
    
    SigLabel(btex \texttt{X(DATA)} etex,        DataId);
    SigLabel(btex $p_0\texttt{(TASK)}$ etex,    TaskId);
    SigLabel(btex \texttt{CLC} etex,            ClkId);
    SigLabel(btex $y_0\texttt{(READY)}$ etex,   ReadyId);
    
    %DATA timing
    Unds(DataId,0,3); Data(DataId,4,4); Data(DataId,5,5); Data(DataId,7,7); Unds(DataId,8,8);
    DataLabel(btex $\texttt{D}_1$ etex, DataId, 4);
    DataLabel(btex $\texttt{D}_2$ etex, DataId, 5);
    DataLabel(btex $\cdots$ etex,       DataId, 6);
    DataLabel(btex $\texttt{D}_n$ etex, DataId, 7);
    
    %TASK timing
    Dns(TaskId,0,2); Edge(TaskId,3); Ups(TaskId,3,3); Edge(TaskId,4); Dns(TaskId,4,5); Dns(TaskId,7,8);
    DataLabel(btex $\cdots$ etex, TaskId, 6);
    
    %clocks
    Clocks(ClkId,0,5);   Clocks(ClkId,7,8);
    ClkLabels(ClkId,0,5); 
    ClkLabel(btex $(n+3)$ etex,     ClkId, 7);
    ClkLabel(btex $(n+4)$ etex,     ClkId, 8);
    
    DataLabel(btex $\cdots$ etex,   ClkId, 6);

    
    %READY timing
    Dns(ReadyId,0,0); Edge(ReadyId,1); Ups(ReadyId,1,3); Edge(ReadyId,4); Dns(ReadyId,4,5); Dns(ReadyId,7,8);
    DataLabel(btex $\cdots$ etex, ReadyId, 6);
endfig;

%выдача результата
beginfig(2)
    DataId      :=  2;
    BusId       :=  1;
    ClkId       :=  0;
    ReadyId     := -1;
    ResultId    := -2;

    Grid(-2,2,0,8);
    
    SigLabel(btex \texttt{X(DATA)} etex,        DataId);
    SigLabel(btex $p_1\texttt{(BUS)}$ etex,     BusId);
    SigLabel(btex \texttt{CLC} etex,            ClkId);
    SigLabel(btex $y_0\texttt{(READY)}$ etex,   ReadyId);
    SigLabel(btex $y_1\texttt{(RESULT)}$ etex,  ResultId);
    
    %DATA timing
    Unds(DataId,0,3); Data(DataId,4,4); Data(DataId,6,6); Data(DataId,7,7); Unds(DataId,8,8);
    DataLabel(btex $\texttt{D}_1$ etex,     DataId, 4);
    DataLabel(btex $\cdots$ etex,           DataId, 5);
    DataLabel(btex $\texttt{D}_{n-1}$ etex, DataId, 6);
    DataLabel(btex $\texttt{D}_n$ etex,     DataId, 7);
    
    %BUS timing
    Dns(BusId,0,2); Edge(BusId,3); Ups(BusId,3,3); Edge(BusId,4); Dns(BusId,4,4); Dns(BusId,6,8);
    DataLabel(btex $\cdots$ etex, BusId, 5);
    
    %clocks
    Clocks(ClkId,0,4);   Clocks(ClkId,6,8);
    ClkLabels(ClkId,0,4); 
    ClkLabel(btex $(n+2)$ etex, ClkId, 6);
    ClkLabel(btex $(n+3)$ etex, ClkId, 7);
    ClkLabel(btex $(n+4)$ etex, ClkId, 8);
    
    DataLabel(btex $\cdots$ etex, ClkId, 5);
    
    %RESULT timing
    Dns(ResultId,0,0); Edge(ResultId,1); Ups(ResultId,1,3); Edge(ResultId,4); Dns(ResultId,4,4); Dns(ResultId,6,8);
    DataLabel(btex $\cdots$ etex, ResultId, 5);
    
    %READY timing
    Dns(ReadyId,0,4); Dns(ReadyId,6,6); Edge(ReadyId,7); Ups(ReadyId,7,8);
    DataLabel(btex $\cdots$ etex, ReadyId, 5);
endfig;

%Мили, работа на примере преобразователя ПК->ДК
beginfig(3)
    DataId      := 11;
    TaskId      := 10;
    BrId        :=  9;
    p2          :=  8;
    ReadyId     :=  7;
    RrId        :=  6;
    y2          :=  5;
    y3          :=  4;
    y4          :=  3;
    y5          :=  2;
    y6          :=  1;
    ClkId       :=  0;
    StateId     :=  -1;

    LastClock   := 10;
    
    Grid(StateId,DataId,0,LastClock);
    
    SigLabel(btex \texttt{X(DATA)} etex,    DataId);
    SigLabel(btex $p_0\texttt{(TASK)}$ etex,  TaskId);
    SigLabel(btex $p_1\texttt{(BUS)}$ etex,  BrId);
    SigLabel(btex $p_2$ etex,               p2);
    SigLabel(btex $y_0\texttt{(READY)}$ etex, ReadyId);
    SigLabel(btex $y_1\texttt{(RESULT)}$ etex,  RrId);
    SigLabel(btex $y_2$ etex,               y2);
    SigLabel(btex $y_3$ etex,               y3);
    SigLabel(btex $y_4$ etex,               y4);
    SigLabel(btex $y_5$ etex,               y5);
    SigLabel(btex $y_6$ etex,               y6);
    SigLabel(btex \texttt{CLC} etex,        ClkId);
    SigLabel(btex $S$ etex,                 StateId);
    
    %DATA timing
    Unds(DataId,0,1); Data(DataId,2,2); Unds(DataId,3,8);
    DataLabel(btex $\texttt{8C}$ etex, DataId, 2);
    Data(DataId,9,9);
    DataLabel(btex $\texttt{F4}$ etex, DataId, 9); Und(DataId,LastClock);

    %TASK timing
    Dn(TaskId,0); Edge(TaskId,1); Ups(TaskId,1,1); Edge(TaskId,2); Dns(TaskId,2,LastClock);

    %BR timing
    Dns(BrId,0,7); Edge(BrId,8); Up(BrId,8); Edge(BrId,9); Dns(BrId,9,LastClock);
    
    %p2 timing
    Dns(p2,0,2); Edge(p2,3); Ups(p2,3,LastClock);
    
    %y0-READY timing
    Ups(ReadyId,0,1); Edge(ReadyId,2); Dns(ReadyId,2,8); Edge(ReadyId,9); Ups(ReadyId,9,LastClock)
    
    %y1-RESULT timing
    Dns(RrId,0,3); Edge(RrId,4); Ups(RrId,4,8); Edge(RrId,9); Dns(RrId,9,LastClock);
    
    %y2 timing
    Dn(y2,0); Edge(y2,1); Up(y2,1); Edge(y2,2); Dns(y2,2,LastClock);

    %y3 timing
    Dns(y3,0,2); Edge(y3,3); Up(y3,3); Edge(y3,4); Dns(y3,4,LastClock);

    %y4 timing
    Dns(y4,0,2); Edge(y4,3); Up(y4,3); Edge(y4,4); Dns(y4,4,LastClock);

    %y5 timing
    Dns(y5,0,3); Edge(y5,4); Up(y5,4); Edge(y5,5); Dns(y5,5,LastClock);

    %y6 timing
    Dns(y6,0,8); Edge(y6,9); Up(y6,9); Edge(y6,10); Dn(y6,LastClock);
    
    %clocks
    Clocks(ClkId,0,LastClock);
    ClkLabels(ClkId,0,LastClock);
    
    %States
    DataLabel(btex $s_0$ etex, StateId, 0);
    DataLabel(btex $s_0$ etex, StateId, 1);
    DataLabel(btex $s_1$ etex, StateId, 2);
    DataLabel(btex $s_2$ etex, StateId, 3);
    DataLabel(btex $s_3$ etex, StateId, 4);
    DataLabel(btex $s_4$ etex, StateId, 5);
    DataLabel(btex $s_4$ etex, StateId, 6);
    DataLabel(btex $s_4$ etex, StateId, 7);
    DataLabel(btex $s_4$ etex, StateId, 8);
    DataLabel(btex $s_5$ etex, StateId, 9);
    DataLabel(btex $s_0$ etex, StateId, 10);
endfig;

%автомат Мура, работа на примере преобразователя ПК->ДК
beginfig(4)
    DataId  := 11;
    TaskId    := 10;
    BrId    :=  9;
    p2      :=  8;
    ReadyId   :=  7;
    RrId    :=  6;
    y2      :=  5;
    y3      :=  4;
    y4      :=  3;
    y5      :=  2;
    y6      :=  1;
    ClkId   :=  0;
    StateId :=  -1;

    LastClock := 11;
    
    Grid(StateId,DataId,0,LastClock);
    
    SigLabel(btex \texttt{X(DATA)} etex,    DataId);
    SigLabel(btex $p_0\texttt{(TASK)}$ etex,  TaskId);
    SigLabel(btex $p_1\texttt{(BUS)}$ etex,  BrId);
    SigLabel(btex $p_2$ etex,               p2);
    SigLabel(btex $y_0\texttt{(READY)}$ etex, ReadyId);
    SigLabel(btex $y_1\texttt{(RESULT)}$ etex,  RrId);
    SigLabel(btex $y_2$ etex,               y2);
    SigLabel(btex $y_3$ etex,               y3);
    SigLabel(btex $y_4$ etex,               y4);
    SigLabel(btex $y_5$ etex,               y5);
    SigLabel(btex $y_6$ etex,               y6);
    SigLabel(btex \texttt{CLC} etex,        ClkId);
    SigLabel(btex $S$ etex,                 StateId);
    
    %DATA timing
    Unds(DataId,0,1); Data(DataId,2,2); Unds(DataId,3,9);
    DataLabel(btex $\texttt{C8}$ etex, DataId, 2);
    Data(DataId,10,10);
    DataLabel(btex $\texttt{B8}$ etex,DataId,10); Und(DataId,LastClock);

    %TR timing
    Dn(TaskId,0); Edge(TaskId,1); Ups(TaskId,1,1); Edge(TaskId,2); Dns(TaskId,2,LastClock);

    %p1-BR timing
    Dns(BrId,0,8); Edge(BrId,9); Up(BrId,9); Edge(BrId,10); Dns(BrId,10,LastClock);
    
    %p2 timing
    Dns(p2,0,2); Edge(p2,3); Ups(p2,3,LastClock);
    
    %y0-READY timing
    Ups(ReadyId,0,1); Edge(ReadyId,2); Dns(ReadyId,2,9); Edge(ReadyId,10); Ups(ReadyId,10,LastClock);
    
    %y1-RR timing
    Dns(RrId,0,5); Edge(RrId,6); Ups(RrId,6,9); Edge(RrId,10); Dns(RrId,10,LastClock);
    
    %y2 timing
    Dns(y2,0,1); Edge(y2,2); Up(y2,2); Edge(y2,3); Dns(y2,3,LastClock);

    %y3 timing
    Dns(y3,0,3); Edge(y3,4); Up(y3,4); Edge(y3,5); Dns(y3,5,LastClock);

    %y4 timing
    Dns(y4,0,3); Edge(y4,4); Up(y4,4); Edge(y4,5); Dns(y4,5,LastClock);

    %y5 timing
    Dns(y5,0,4); Edge(y5,5); Up(y5,5); Edge(y5,6); Dns(y5,6,LastClock);

    %y6 timing
    Dns(y6,0,9); Edge(y6,10); Up(y6,10); Edge(y6,11); Dns(y6,11,LastClock);
    
    %clocks
    Clocks(ClkId,0,LastClock);
    ClkLabels(ClkId,0,LastClock);
    
    %States
    DataLabel(btex $s_0$ etex, StateId, 0);
    DataLabel(btex $s_0$ etex, StateId, 1);
    DataLabel(btex $s_1$ etex, StateId, 2);
    DataLabel(btex $s_2$ etex, StateId, 3);
    DataLabel(btex $s_3$ etex, StateId, 4);
    DataLabel(btex $s_4$ etex, StateId, 5);
    DataLabel(btex $s_6$ etex, StateId, 6);
    DataLabel(btex $s_6$ etex, StateId, 7);
    DataLabel(btex $s_6$ etex, StateId, 8);
    DataLabel(btex $s_6$ etex, StateId, 9);
    DataLabel(btex $s_7$ etex, StateId, 10);
    DataLabel(btex $s_0$ etex, StateId, 11);
endfig;

end;
