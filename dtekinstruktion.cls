\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dtekinstruktion}[2025/03/28 Instruktionsklass för DNollK]

% --------------------------------------------------------------------
%  1. Ladda article-klassen med 11pt
% --------------------------------------------------------------------
\LoadClass[11pt]{article}

% --------------------------------------------------------------------
%  2. Standardpaket
% --------------------------------------------------------------------
\RequirePackage[swedish]{babel}
\RequirePackage{fontspec}     % För TTF/OTF-fonter (kräver xelatex)
\RequirePackage{parskip}      % Mellanrum mellan stycken
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{csquotes}
\RequirePackage[unicode]{hyperref}
\RequirePackage{lastpage}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage[includeheadfoot,
  top=1.0cm, bottom=3.5cm, left=2.5cm, right=2.5cm]{geometry}

\RequirePackage{xcolor}

% --------------------------------------------------------------------
%  3. Typsnitt: PT Serif för löptext, Open Sans för rubriker
% --------------------------------------------------------------------
\defaultfontfeatures{Ligatures=TeX}
\setmainfont{PT Serif}
\newfontfamily\opensans{Open Sans}

\RequirePackage{sectsty}
\allsectionsfont{\opensans\bfseries}

% --------------------------------------------------------------------
%  4. Hyperref-inställningar
% --------------------------------------------------------------------
\AtBeginDocument{%
  \hypersetup{
    pdftitle  = {\@title},
    pdfauthor = {\@author},
    colorlinks = true,
    citecolor  = black,
    filecolor  = black,
    linkcolor  = black,
    urlcolor   = black,
    pdfborder={0 0 0}
  }
}

% --------------------------------------------------------------------
%  5. Underrubrik kommando
% --------------------------------------------------------------------
\DeclareDocumentCommand \subtitle {m} {%
  \DeclareDocumentCommand \@subtitle {}{#1}%
}

\DeclareDocumentCommand \maketitle {} {%
  {\centering\bfseries\Huge \@title\par}%
  \ifdef{\@subtitle}{\vspace{0.3em}{\centering\Large \@subtitle\par}}{}%
}

% --------------------------------------------------------------------
%  6. Fancyhdr för sidhuvud/sidfötter
% --------------------------------------------------------------------
\newif\ifincludeaddress
\includeaddressfalse
\DeclareOption{includeaddress}{\includeaddresstrue}
\ProcessOptions\relax

\DeclareDocumentCommand \makehf {} {%
  \pagestyle{fancy}
  \setlength{\headheight}{25mm}
  \setlength{\headsep}{15mm}
  \fancyhf{}
  
  % Vänster sidhuvud
  \newcommand{\headleft}{%
    \opensans
    \hspace{-2em}
    \raisebox{-2em}{\includegraphics[width=20mm]{dteklogo_orange}}%
    \hspace{1em}%
    \parbox[b]{0.5\textwidth}{%
      \bfseries Datateknologsektionen\\[-0.2em]
      Chalmers Studentkår
    }
  }
  
  % Höger sidhuvud
  \newcommand{\headright}{%
    \opensans
    \@title\\
    \@date
  }
  
  \lhead{\headleft}
  \rhead{\headright}
  
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{1pt}
  
  \cfoot{\opensans \thepage~av~\pageref{LastPage}}
  
  \ifincludeaddress
    \lfoot{%
      \opensans
      \raggedright
      Datateknologsektionen\\
      Rännvägen 8\\
      412\,58 Göteborg
    }
    \rfoot{%
      \opensans
      \raggedleft
      \href{mailto:styret@dtek.se}{styret@dtek.se}\\
      \href{http://dtek.se}{www.dtek.se}
    }
  \fi
}

\DeclareDocumentCommand \makeheadfoot {}{\makehf}

\RequirePackage{titlesec}
\titleformat{\section}[block]
  {\centering\Large\bfseries}
  {\thesection.}
  {1em}
  {\MakeUppercase}

\DeclareDocumentCommand \makesign {m} {%
  \parbox{0.47\textwidth}{%
    \vspace{2cm}
    \rule{0.47\textwidth}{0.5pt}\\
    #1
  }
}

\endinput
