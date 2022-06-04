\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{klassenarbeit}
\LoadClass{article} 

\RequirePackage{einstellungen}
\RequirePackage{lastpage}

\newboolean{loesung}

\DeclareOption{loesung}{\setboolean{loesung}{true}}
\ProcessOptions\relax

\newcommand{\lerngruppe}[1]{\def\lerngruppe{#1}}
\newcommand{\datum}[1]{\def\datum{#1}}
\newcommand{\name}[1]{\def\name{#1}}
\newcommand{\titel}[1]{\def\titel{#1}}
\newcommand{\hinweise}[1]{\def\hinweise{#1}}
\newcommand{\hilfsmittel}[1]{\def\hilfsmittel{#1}}
\newcommand{\bearbeitungszeit}[1]{\def\bearbeitungszeit{#1}}

\newcommand{\hinweis}{
  \begin{tabularx}{\textwidth}{@{}Ol@{\hspace{6pt}}X}
    \hline
    \textbf{Hinweise:} & \hinweise\\
    \textbf{Hilfsmittel:} & \hilfsmittel\\
    \textbf{Bearbeitungszeit:} & \bearbeitungszeit\ Minuten \\
    \hline
  \end{tabularx}
}

%\newcommand{\logo}{\includegraphics[height=35pt]{logo}}

\geometry{a4paper,top=0.75cm, bottom=1cm,
  left=2cm,
  right=2cm,
  headheight=41pt,
  headsep=10pt,
  includehead,includefoot,
  heightrounded}

\setsansfont{MYRIADPRO}[
  Path=/Users/lukaskohl/Documents/Schule/TeX/TexStyle/MYRIADPRO/,
  Extension      = .OTF ,
  UprightFont    = *-REGULAR,
  BoldFont       = *-BOLD ,
  ItalicFont     = *-ITALIC,
  BoldItalicFont = *-BOLDIT ,
]


\DeclareExerciseProperty{title}
\DeclareExerciseEnvironmentTemplate{aufgabe-template}
{%
  \subsection*
  {%
    \GetExerciseProperty{counter}. \GetExerciseName:%
    \GetExercisePropertyT{title}{\hspace{.4em}\PropertyValue}  
    \vspace*{-0.15cm}
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

\ifthenelse{\boolean{loesung}}{
  \xsimsetup{
    loesung/print=true,
    loesung/begin-hook={\color{blue}},
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
  %\lhead{\logo}
  \lhead{}
  \rhead{\datum\ \\ \lerngruppe-KÖL}
  \chead{{\bfseries \Large \titel}\vspace{0cm}}
  {\large \bfseries Name: \name}\\[4mm]
  \hinweis  
}

\newcommand{\setfooter}{
  \fancyfoot{}
  \rfoot{\footnotesize Seite \thepage\ von \pageref{LastPage}}
  %\klassenarbeittable{\Hinweis}{\AnzahlAufgaben}
}

\AtBeginDocument{%
  \setheader
  \setfooter
}

\AtEndDocument{%
}