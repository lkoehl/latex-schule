\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arbeitsblatt}
\LoadClass{article}

% Pakete
\RequirePackage{einstellungen}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}

\newboolean{A5}
\newboolean{landscape}

\DeclareOption{A5}{\setboolean{A5}{true}}
\DeclareOption{landscape}{\setboolean{landscape}{true}}
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



\newcommand{\setheader}{
  \pagestyle{fancy}
  \xpretocmd\headrule{\color{lightgray}}{}{\PatchFailed}
  \lhead{\large {\headerfont\thema}}
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