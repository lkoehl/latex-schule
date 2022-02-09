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
\newcommand{\hinweis}[3]{\def\hinweis{
	\par
	\begin{tabularx}{\textwidth}{@{}Sl@{\hspace*{0.2cm}}S{X}}
		\hline
		\textbf{Hinweise:} & #1 \\
		\textbf{Erlaubte Hilfsmittel:} & #2 \\
		\textbf{Bearbeitungszeit:} & #3 Minuten \\
		\hline
	\end{tabularx}
	\vspace{0.6cm}
}}

\newcommand{\logo}{\includegraphics[height=35pt]{logo}}

\geometry{a4paper,top=0.75cm, bottom=1cm,
  left=2cm,
  right=2cm,
  headheight=41pt,
  headsep=10pt,
  includehead,includefoot,
  heightrounded}

\setsansfont{MYRIADPRO}[
  Path=/Users/lukaskohl/Documents/Schule/TexStyle/MYRIADPRO/,
  Extension      = .OTF ,
  UprightFont    = *-REGULAR,
  BoldFont       = *-BOLD ,
  ItalicFont     = *-ITALIC,
  BoldItalicFont = *-BOLDIT ,
]

\DeclareExerciseProperty{title}
\DeclareExerciseEnvironmentTemplate{aufgabe-template}
{%
  %\subsection*
  \large \textbf
  {%
    \GetExerciseProperty{counter}. \GetExerciseName:%
    \GetExercisePropertyT{title}{\hspace{.4em}\PropertyValue}  
  }
  \normalsize
  \hfill
  \\
  % (\printtotalpoints)
  % \vspace{0.1cm}
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
      \GetExerciseName:%
      {\hspace{.4em}}
    }
  }{%
    \subsubsection*
    {%
      \GetExerciseName~\GetExerciseProperty{counter}: %
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
  \lhead{\logo}
  \rhead{\datum\ \\ \lerngruppe-Kö}
  \chead{{\bfseries \Large \titel}\vspace{0cm}}
  {\large \bfseries Name: \name}\\
  %\hinweis
  
}

\newcommand{\setfooter}{
  \fancyfoot{}
  \rfoot{\footnotesize Seite \thepage\ von \pageref{LastPage}}
  %
  %\klassenarbeittable{\Hinweis}{\AnzahlAufgaben}
}

\AtBeginDocument{%
  \setheader
  \setfooter
}

\AtEndDocument{%
}