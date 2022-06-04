\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arbeitsblatt}
\LoadClass{article} 

% Pakete
\RequirePackage{einstellungen}
\RequirePackage{pgfplots}

\newboolean{A5}
\newboolean{landscape}
\newboolean{loesung}

\DeclareOption{A5}{\setboolean{A5}{true}}
\DeclareOption{landscape}{\setboolean{landscape}{true}}
\DeclareOption{loesung}{\setboolean{loesung}{true}}
\ProcessOptions\relax

\newcommand{\thema}[1]{\def\thema{#1}}
\newcommand{\lerngruppe}[1]{\def\lerngruppe{#1}}

\pagenumbering{gobble} 

\ifthenelse{\boolean{landscape}}
{
	\geometry{a4paper,bottom=2.5cm,top=2.5cm,left=2.5cm,right=2.5cm,headheight=6pt,landscape}
}{
  \geometry{a4paper,bottom=2.5cm,top=2.5cm,left=2.5cm,right=2.5cm,headheight=6pt}
}

\ifthenelse{\boolean{A5}}{
  \ifthenelse{\boolean{landscape}}{
    \pgfpagesuselayout{2 on 1}[a4paper]
  }{
    \pgfpagesuselayout{2 on 1}[a4paper, landscape]
  }
  
  \AtBeginShipout{
    \pgfpagesshipoutlogicalpage{1}\copy\AtBeginShipoutBox
    \pgfpagesshipoutlogicalpage{2}\box\AtBeginShipoutBox
    \pgfshipoutphysicalpage
  }
}{}

\setsansfont{MYRIADPRO}[
 Path=/Users/lukaskohl/Documents/Schule/TeX/TexStyle/MYRIADPRO/,
 Extension      = .OTF ,
 UprightFont    = *-REGULAR,
 BoldFont       = *-BOLD ,
 ItalicFont     = *-ITALIC,
 BoldItalicFont = *-BOLDIT ,
]

%\newfontface\headerfont[Path=/Users/lukaskohl/Documents/Schule/TeX/TexStyle/]{CarterOne-Regular.ttf}
\newfontface\headerfont[Path=/Users/lukaskohl/Documents/Schule/TeX/TexStyle/]{Inter-SemiBold.ttf}

\DeclareExerciseProperty{title}
\DeclareExerciseProperty*{large}
\DeclareExerciseEnvironmentTemplate{aufgabe-template}
{%
  \IfExerciseBooleanPropertyTF{large}{%
    \subsection*
    {%
      \GetExerciseProperty{counter}. \GetExerciseName:%
      \GetExercisePropertyT{title}{\hspace{.4em}\PropertyValue}
      \vspace*{-0.15cm}
    }
  }{%
    \subsubsection*
    {%
      \GetExerciseName~\GetExerciseProperty{counter}:~%
      \GetExercisePropertyT{title}{\PropertyValue}
      \vspace*{-0.35cm}
    }\vspace*{1mm}
  }
}

\DeclareExerciseType{aufgabeExs}{exercise-env=aufgabe,
  solution-env=loesung,
  exercise-name=Aufgabe,
  exercises-name=Aufgaben,
  solution-name=Lösung,
  solutions-name=Lösungen,
  exercise-template=aufgabe-template,
  solution-template=aufgabe-template
}

\DeclareExerciseEnvironmentTemplate{bonus-template}
{%
  \IfExerciseBooleanPropertyTF{large}{%
    \subsection*
    {%
      \GetExerciseName~\GetExerciseProperty{counter}:%
      \vspace*{-0.15cm}
    }
  }{%
    \subsubsection*
    {%
      \GetExerciseName~\GetExerciseProperty{counter}: %
      \vspace*{-0.35cm}
    }\vspace*{1mm}
  }
}

\DeclareExerciseType{bonusExs}{exercise-env=bonus,
  solution-env=bonus-loesung,
  exercise-name=Bonusaufgabe,
  exercises-name=Bonusaufgaben,
  solution-name=Lösung,
  solutions-name=Lösungen,
  exercise-template=bonus-template,
  solution-template=bonus-template
}

\ifthenelse{\boolean{loesung}}{
  \xsimsetup{
    loesung/print=true,
    loesung/begin-hook={\color{blue}},
    bonus-loesung/print=true,
    bonus-loesung/begin-hook={\color{blue}}
  }
}{
  \xsimsetup{
	loesung/print=false,
    loesung/begin-hook={\color{blue}}
  }
}

\newcommand{\setheader}{
  \pagestyle{fancy}
  \xpretocmd\headrule{\color{lightgray}}{}{\PatchFailed}
  \lhead{\bfseries\large {\headerfont\thema}}
  \rhead{\color{gray}\large {\headerfont\lerngruppe}}
  \chead{}
}

\newcommand{\setfooter}{
  \fancyfoot{}
}

\AtBeginDocument{%
  \setheader
}

\AtEndDocument{%
  \setfooter
}