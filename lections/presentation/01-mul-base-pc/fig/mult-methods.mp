verbatimtex
%&latex
\documentclass{article}
\usepackage[cp1251]{inputenc}
\usepackage[english,russian]{babel}
\begin{document}
etex

prologues:=0;

u:=17pt;

linedist = 2/8u;
radius = 3/8u;
inlength = 6/8u;


beginfig(1);
    pair p[];
    p1:=(2.5u,0); p2:=(3.5u,0); p3:=(3.5u,u); p4:=(2.5u,u);

    path summator; 
    summator := p1--p2--p3--p4--cycle;
    label(btex $+$ etex, center(summator));
    draw summator;

    p5=.5[p3,p4];

    p6=(xpart p5, 2u-linedist);
    drawarrow p6--p5;

    %счп
    label.ulft("2n",(u+8u,3u));
    label.rt(btex \texttt{СЧП} etex,(u,2.5u));
    draw (u,2u)--(u+8u,2u)--(u+8u,3u)--(u,3u)--cycle;
    drawarrow (4u,2.5u)--(6u,2.5u);

    label.lrt("1",(u,2u-linedist));
    label.llft("n+1",(u+4u,2u-linedist));
    draw (u,2u-linedist)--(u+4u,2u-linedist);
    draw (u,2u-linedist+.5linedist)--(u,2u-linedist-.5linedist);
    draw (u+4u,2u-linedist+.5linedist)--(u+4u,2u-linedist-.5linedist);

    label.urt("1",(u,3u+linedist));
    label.ulft("n+1",(u+4u,3u+linedist));
    draw (u,3u+linedist)--(u+4u,3u+linedist);
    draw (u,3u+linedist+.5linedist)--(u,3u+linedist-.5linedist);
    draw (u+4u,3u+linedist+.5linedist)--(u+4u,3u+linedist-.5linedist);

    drawarrow((2.5u,.5u)--(0+radius,.5u){left}..{up}(0,.5u+radius)
        --(0,4.5u-radius){up}..(0+radius,4.5u)
        --(3u-radius,4.5u){right}..(3u,4.5u-radius)
        --(3u,3u+linedist));

    %множитель
    label.top(btex \texttt{множитель} etex,(2u,7u+inlength));
    drawarrow (2u,7u+inlength)--(2u,7u);
    label.urt("1",(0,7u));
    label.ulft("n",(4u,7u));
    draw (0,7u)--(4u,7u)--(4u,6u)--(0,6u)--cycle;
    drawarrow (u,6.5u)--(3u,6.5u);

    draw (4u-2linedist,6u-linedist)--(4u,6u-linedist);
    draw (4u-2linedist,6u-linedist+.5linedist)--(4u-2linedist,6u-linedist-.5linedist);
    draw (4u,6u-linedist+.5linedist)--(4u,6u-linedist-.5linedist);
    drawarrow (4u-linedist,6u-linedist)--(4u-linedist,6u-linedist-.5u);

    %множимое
    label.top(btex \texttt{множимое} etex, (6u+2u,7u+inlength));
    drawarrow (6u+2u,7u+inlength)--(6u+2u,7u);
    label.urt("1",(6u,7u));
    label.ulft("n",(6u+4u,7u));
    draw (6u,7u)--(6u+4u,7u)--(6u+4u,6u)--(6u,6u)--cycle;
    
    drawarrow (6u+2u,6u)--(6u+2u,6u-2linedist);
    
    draw (6u-2linedist,6u-2linedist)--(6u+4u,6u-2linedist);
    draw (6u-2linedist,6u-2linedist+.5linedist)--(6u-2linedist,6u-2linedist-.5linedist);
    draw (6u,6u-2linedist+.5linedist)--(6u,6u-2linedist-.5linedist);
    draw (6u+4u,6u-2linedist+.5linedist)--(6u+4u,6u-2linedist-.5linedist);

    draw (6u-2linedist,6u-4linedist)--(6u+4u,6u-4linedist);
    draw (6u-2linedist,6u-4linedist+.5linedist)--(6u-2linedist,6u-4linedist-.5linedist);
    draw (6u+4u,6u-4linedist+.5linedist)--(6u+4u,6u-4linedist-.5linedist);

    label.top("0",(6u-linedist,6u+linedist));
    drawarrow (6u-linedist,6u+linedist)--(6u-linedist,6u-2linedist);
    
    label.lrt("1",(6u-2linedist,6u-4linedist));
    label.llft("n+1",(6u+4u,6u-4linedist));

    drawarrow (6u+2u,6u-4linedist)--(6u+2u,4u+radius){down}..(6u+2u+radius,4u)
      --(6u+4u-radius,4u){right}..(6u+4u,4u-radius)
      --(6u+4u,.5u+radius){down}..(6u+4u-radius,.5u)--(3.5u,.5u);
      
    path methodNo;
    methodNo = (fullcircle scaled u) shifted (15u,8u);
    draw methodNo;
    label("I", center(methodNo));
endfig; %fig1 - первый способ умножения


beginfig(2)
    pair p[];
    p1:=(4.5u,0); p2:=(5.5u,0); p3:=(5.5u,u); p4:=(4.5u,u);

    path summator; 
    summator := p1--p2--p3--p4--cycle;
    label(btex $+$ etex, center(summator));
    draw summator;

    p5=.5[p3,p4];

    p6=(xpart p5, 2u);
    drawarrow p6--p5;

    %счп
    label.urt("1",(u,3u));
    label.ulft("2n",(u+8u,3u));
    label.rt(btex \texttt{СЧП} etex,(u,2.5u));
    draw (u,2u)--(u+8u,2u)--(u+8u,3u)--(u,3u)--cycle;

    drawarrow (4.5u,.5u)--(0+radius,.5u){left}..{up}(0,.5u+radius)--(0,4.5u-radius){up}..(0+radius,4.5u)--(5u-radius,4.5u){right}..(5u,4.5u-radius)--(5u,3u);


    %множитель
    label.top(btex \texttt{множитель} etex,(2u,7u+inlength));
    drawarrow (2u,7u+inlength)--(2u,7u);
    label.urt("1",(0,7u));
    label.ulft("n",(4u,7u));
    draw (0,7u)--(4u,7u)--(4u,6u)--(0,6u)--cycle;
    drawarrow (u,6.5u)--(3u,6.5u);

    draw (4u-2linedist,6u-linedist)--(4u,6u-linedist);
    draw (4u-2linedist,6u-linedist+.5linedist)--(4u-2linedist,6u-linedist-.5linedist);
    draw (4u,6u-linedist+.5linedist)--(4u,6u-linedist-.5linedist);
    drawarrow (4u-linedist,6u-linedist)--(4u-linedist,6u-linedist-.5u);

    %множимое
    label.top(btex \texttt{множимое} etex,(6u+6u,7u+inlength+linedist));
    drawarrow (6u+6u,7u+inlength+linedist)--(6u+6u,7u+linedist);
    label.urt("1",(6u,7u));
    label.urt("n+1",(6u+4u,7u+linedist));
    label.ulft("2n",(6u+8u,7u+linedist));
    draw (6u+4u,7u+linedist)--(6u+8u,7u+linedist);
    draw (6u+4u,7u+linedist-.5linedist)--(6u+4u,7u+linedist+.5linedist);
    draw (6u+8u,7u+linedist-.5linedist)--(6u+8u,7u+linedist+.5linedist);
    draw (6u,7u)--(6u+8u,7u)--(6u+8u,6u)--(6u,6u)--cycle;
    drawarrow (6u+4u+u,6.5u)--(6u+4u-u,6.5u);


    drawarrow (6u+4u,6u)--(6u+4u,.5u+radius){down}..(6u+4u-radius,.5u)--(5.5u,.5u);

    %номер метода
    path methodNo;
    methodNo = (fullcircle scaled u) shifted (15u,8u);
    draw methodNo;
    label("II", center(methodNo));
endfig; %fig2 второй способ умножения


beginfig(3)
    pair p[];
    p1:=(4.5u,0); p2:=(5.5u,0); p3:=(5.5u,u); p4:=(4.5u,u);

    path summator; 
    summator := p1--p2--p3--p4--cycle;
    label(btex $+$ etex, center(summator));
    draw summator;

    p5=.5[p3,p4];

    p6=(xpart p5, 2u);
    drawarrow p6--p5;

    %счп
    label.urt("1",(u,3u));
    label.ulft("2n",(u+8u,3u));
    label.rt(btex \texttt{СЧП} etex,(u,2.5u));
    draw (u,2u)--(u+8u,2u)--(u+8u,3u)--(u,3u)--cycle;
    drawarrow (u+4u+u,2.5u)--(u+4u-u,2.5u);

    drawarrow (4.5u,.5u)--(0+radius,.5u){left}..{up}(0,.5u+radius)--(0,4.5u-radius){up}..(0+radius,4.5u)--(5u-radius,4.5u){right}..(5u,4.5u-radius)--(5u,3u);


    %множитель
    label.top(btex \texttt{множитель} etex,(2u,7u+inlength));
    drawarrow (2u,7u+inlength)--(2u,7u);
    label.urt("1",(0,7u));
    label.ulft("n",(4u,7u));
    draw (0,7u)--(4u,7u)--(4u,6u)--(0,6u)--cycle;
    drawarrow (3u,6.5u)--(u,6.5u);

    draw (0,6u-linedist)--(2linedist,6u-linedist);
    draw (0,6u-linedist+.5linedist)--(0,6u-linedist-.5linedist);
    draw (2linedist,6u-linedist+.5linedist)--(2linedist,6u-linedist-.5linedist);
    drawarrow (linedist,6u-linedist)--(linedist,6u-linedist-.5u);

    %множимое
    label.top(btex \texttt{множимое} etex,(6u+6u,7u+inlength));
    drawarrow (6u+6u,7u+inlength)--(6u+6u,7u);
    label.urt("1",(6u+4u,7u));
    label.ulft("n",(6u+8u,7u));
    draw (6u+4u,7u)--(6u+8u,7u)--(6u+8u,6u)--(6u+4u,6u)--cycle;

    drawarrow (6u+6u,6u)--(6u+6u,6u-inlength);

    label.urt("1",(6u,6u-inlength));
    label.ulft("n",(6u+4u,6u-inlength));

    draw (6u,6u-inlength)--(6u+8u,6u-inlength);

    draw (6u,6u-inlength-.5linedist)--(6u,6u-inlength+.5linedist);
    draw (6u+4u,6u-inlength-.5linedist)--(6u+4u,6u-inlength+.5linedist);
    draw (6u+8u,6u-inlength-.5linedist)--(6u+8u,6u-inlength+.5linedist);

    label.top("0",(6u+2u,6u));
    drawarrow (6u+2u,6u)--(6u+2u,6u-inlength);

    label.lrt("1",(6u,6u-inlength-2linedist));
    label.llft("2n",(6u+8u,6u-inlength-2linedist));
    draw (6u,6u-inlength-2linedist)--(6u+8u,6u-inlength-2linedist);
    draw (6u,6u-inlength-2linedist-.5linedist)--(6u,6u-inlength-2linedist+.5linedist);
    draw (6u+8u,6u-inlength-2linedist-.5linedist)--(6u+8u,6u-inlength-2linedist+.5linedist);

    drawarrow (6u+4u,6u-2linedist-inlength)--(6u+4u,.5u+radius){down}..(6u+4u-radius,.5u)--(5.5u,.5u);

    %номер метода
    path methodNo;
    methodNo = (fullcircle scaled u) shifted (15u,8u);
    draw methodNo;
    label("III", center(methodNo));
endfig; %fig3 третий способ умножения


beginfig(4)
    pair p[];
    p1:=(4.5u,0); p2:=(5.5u,0); p3:=(5.5u,u); p4:=(4.5u,u);

    path summator; 
    summator := p1--p2--p3--p4--cycle;
    label(btex $+$ etex, center(summator));
    draw summator;

    p5=.5[p3,p4];

    p6=(xpart p5, 2u);
    drawarrow p6--p5;

    %счп
    label.urt("1",(u,3u));
    label.ulft("2n",(u+8u,3u));
    label.rt(btex \texttt{СЧП} etex,(u,2.5u));
    draw (u,2u)--(u+8u,2u)--(u+8u,3u)--(u,3u)--cycle;

    drawarrow (4.5u,.5u)--(0+radius,.5u){left}..{up}(0,.5u+radius)--(0,4.5u-radius){up}..(0+radius,4.5u)--(5u-radius,4.5u){right}..(5u,4.5u-radius)--(5u,3u);


    %множитель
    label.top(btex \texttt{множитель} etex,(2u,7u+inlength));
    drawarrow (2u,7u+inlength)--(2u,7u);
    label.urt("1",(0,7u));
    label.ulft("n",(4u,7u));
    draw (0,7u)--(4u,7u)--(4u,6u)--(0,6u)--cycle;
    drawarrow (3u,6.5u)--(u,6.5u);

    draw (0,6u-linedist)--(2linedist,6u-linedist);
    draw (0,6u-linedist+.5linedist)--(0,6u-linedist-.5linedist);
    draw (2linedist,6u-linedist+.5linedist)--(2linedist,6u-linedist-.5linedist);
    drawarrow (linedist,6u-linedist)--(linedist,6u-linedist-.5u);

    %множимое
    label.top(btex \texttt{множимое} etex,(6u+2u,7u+inlength+linedist));
    drawarrow (6u+2u,7u+inlength+linedist)--(6u+2u,7u+linedist);
    label.urt("2",(6u+linedist,7u+linedist));
    label.ulft("n+1",(6u+4u,7u+linedist));
    label.ulft("2n",(6u+8u,7u));
    draw (6u+linedist,7u+linedist)--(6u+4u,7u+linedist);
    draw (6u+4u,7u+linedist-.5linedist)--(6u+4u,7u+linedist+.5linedist);
    draw (6u+linedist,7u+linedist-.5linedist)--(6u+linedist,7u+linedist+.5linedist);
    draw (6u,7u)--(6u+8u,7u)--(6u+8u,6u)--(6u,6u)--cycle;

    drawarrow (6u+4u-u,6.5u)--(6u+4u+u,6.5u);

    drawarrow (6u+4u,6u)--(6u+4u,.5u+radius){down}..(6u+4u-radius,.5u)--(5.5u,.5u);

    %номер метода
    path methodNo;
    methodNo = (fullcircle scaled u) shifted (15u,8u);
    draw methodNo;
    label("IV", center(methodNo));
endfig; %fig4 четвертый способ умножения

beginfig(5)
    path spm;
    spm := (0,0)--(4u,0)--(4u,-u)--(0,-u)--cycle;
    label.urt("1",(0,0));
    label.ulft("n",(4u,0));
    label.llft(btex \texttt{СЧП} etex,(4u,-u));
    drawarrow (u, -.5u)--(3u, -.5u);
    draw spm;

    path mplr;
    mplr := (6u,0)--(6u+4u,0)--(6u+4u,-u)--(6u,-u)--cycle;
    drawarrow (6u+1u, -.5u)--(6u+3u, -.5u);
    label.urt("1",(6u,0));
    label.ulft("n",(6u+4u,0));
    label.top(btex \texttt{множитель} etex,(6u+2u,inlength));
    drawarrow (6u+2u,inlength)--(6u+2u,0);
    draw (6u+4u-2linedist,-u-linedist)--(6u+4u,-u-linedist);
    draw (6u+4u-2linedist,-u-linedist-.5linedist)--(6u+4u-2linedist,-u-linedist+.5linedist);
    draw (6u+4u,-u-linedist-.5linedist)--(6u+4u,-u-linedist+.5linedist);
    drawarrow (6u+4u-linedist, -u-linedist)--(6u+4u-linedist, -u-linedist-.5u);
    draw mplr;

    path mplcnt;
    mplcnt := (12u,0)--(12u+4u,0)--(12u+4u,-u)--(12u,-u)--cycle;
    label.urt("1",(12u,0));
    label.ulft("n",(12u+4u,0));
    label.top(btex \texttt{множимое} etex,(12u+2u,inlength));
    drawarrow (12u+2u,inlength)--(12u+2u,0);
    draw mplcnt;

    path sum;
    sum := (1.5u,-3u)--(2.5u,-3u)--(2.5u,-4u)--(1.5u,-4u)--cycle;
    label("+", center sum);
    draw sum;

    drawarrow (12u+2u,-u)--(12u+2u,-3.5u+radius){down}..(12u+2u-radius,-3.5u)--(2.5u,-3.5u);
    drawarrow (2u,-u)--(2u,-3u);
    drawarrow 
    (1.5u,-3.5u)
    --(-u+radius,-3.5u){left}..(-u,-3.5u+radius)
    --(-u,2u-radius){up}..(-u+radius,2u)
    --(2u-radius,2u){right}..(2u,2u-radius)
    --(2u,0);

    drawarrow (4u,-.5u)--(6u,-.5u) dashed evenly;
endfig; %fig5 первый способ с n-разрядной счп (экономия регистров)

end;