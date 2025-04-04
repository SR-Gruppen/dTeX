\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dtekmotion}[2025/03/10 Modernized Datateknologsektionen document class]

% --------------------------------------------------------------------
%  1. Load article base class, at 11pt
% --------------------------------------------------------------------
\LoadClass[11pt]{article}

% --------------------------------------------------------------------
%  2. Standard packages
% --------------------------------------------------------------------
\RequirePackage[swedish]{babel}
\RequirePackage{fontspec}     % For TTF/OTF fonts (needs xelatex)
\RequirePackage{parskip}      % or parfill if you like
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{csquotes}
\RequirePackage[unicode]{hyperref}
\RequirePackage{lastpage}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage[includeheadfoot,
  top=1.0cm, bottom=3.5cm, left=2.5cm, right=2.5cm]{geometry}

% If you want color macros (for \textcolor{gray}, etc.):
\RequirePackage{xcolor}

% --------------------------------------------------------------------
%  3. Font setup: PT Serif main, Open Sans for headings
% --------------------------------------------------------------------
\defaultfontfeatures{Ligatures=TeX}

\setmainfont{PT Serif}

\newfontfamily\opensans{Open Sans}

% Make sections in bold Open Sans:
\RequirePackage{sectsty}
\allsectionsfont{\opensans\bfseries}

% --------------------------------------------------------------------
%  4. Hyperref
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
%  5. Subtitle command
% --------------------------------------------------------------------
\DeclareDocumentCommand \subtitle {m} {%
  \DeclareDocumentCommand \@subtitle {}{#1}%
}

\DeclareDocumentCommand \maketitle {} {%
  {\centering\bfseries\Huge \@title\par}%
  \ifdef{\@subtitle}{\vspace{0.3em}{\centering\Large \@subtitle\par}}{}%
}

% --------------------------------------------------------------------
%  6. Fancyhdr for header/footers
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

  % Top-left content
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

  % Top-right content
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
}


\DeclareDocumentCommand \makesign {m} {%
  \parbox{0.47\textwidth}{%
    \vspace{2cm}
    \rule{0.47\textwidth}{0.5pt}\\
    #1
  }
}

% --------------------------------------------------------------------
\endinput
