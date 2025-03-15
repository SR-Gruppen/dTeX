\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dtek}[2025/03/10 Modernized Datateknologsektionen document class]

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

% Provide an alias for the old name (backwards compatibility):
\DeclareDocumentCommand \makeheadfoot {}{\makehf}

% --------------------------------------------------------------------
%  7. The "Stadga macros" from your example,
%     so any document that wants to use them (like stadga.tex) can.
% --------------------------------------------------------------------
%  - If you want them only sometimes, you could wrap them in a
%    \newif\ifuseStadgaFormat block. But presumably you always want them.
\RequirePackage{titlesec}
% 7A. Force new page BEFORE every \section
\pretocmd{\section}{%
  \ifdefined\currentsubsectionTitle \finishsubsection \fi
  \setcounter{paracnt}{0}%
  \clearpage
}{}{}

% 7B. Section layout
\titleformat{\section}[block]
  {\centering\Large\bfseries}
  {\thesection\ kap.}
  {1em}
  {\MakeUppercase}

% 7C. Paragraph counters, etc.
\newcounter{paracnt}
\newcounter{stycke}[paracnt]
\newcounter{currsubstart}
\newcounter{currsubend}
\let\currentsubsectionTitle\undefined

% Helper macro to finish a "subsection" for the TOC references
\newcommand{\finishsubsection}{%
  \setcounter{currsubend}{\value{paracnt}}%
  \ifnum\value{currsubend} < \value{currsubstart}%
    % No paragraphs written in this subsection:
    \addcontentsline{toc}{subsection}{\currentsubsectionTitle}%
  \else
    \ifnum\value{currsubstart}=\value{currsubend}%
      \addcontentsline{toc}{subsection}{\currentsubsectionTitle\ (\arabic{currsubend}\,§)}%
    \else
      \addcontentsline{toc}{subsection}{\currentsubsectionTitle\ (\arabic{currsubstart}--\arabic{currsubend}\,§§)}%
    \fi
  \fi
  \let\currentsubsectionTitle\undefined
}

\newcommand{\mysubsection}[1]{%
  \ifdefined\currentsubsectionTitle
    \finishsubsection
  \fi
  \def\currentsubsectionTitle{#1}%
  \setcounter{currsubstart}{\numexpr\value{paracnt}+1\relax}%
  \phantomsection
  \subsection*{#1}%
}

% The \para command
\newcommand{\para}{%
  \par\noindent
  \llap{\textcolor{gray}{\thesection\ kap.\quad}}%
  \stepcounter{paracnt}%
  \textbf{\arabic{paracnt}\,§}\quad
}

% If you want the optional argument version:
\makeatletter
\renewcommand{\para}[1][]{%
  \ifblank{#1}{%
    % If no optional argument is provided
    \par\noindent%
    \llap{\textcolor{lightgray}{\thesection\ kap.\quad}}%
    \stepcounter{paracnt}%
    \textbf{\arabic{paracnt}\,§}\quad%
  }{%
    % If an optional argument is provided, first print new sub-subsection
    \mysubsection{#1}%
    \par\noindent%
    \llap{\textcolor{lightgray}{\thesection\ kap.\quad}}%
    \stepcounter{paracnt}%
    \textbf{\arabic{paracnt}\,§}\quad%
  }%
}
\makeatother

% The \stycke macro
\newcommand{\stycke}{%
  \par\noindent%
  \stepcounter{stycke}%
  \llap{\textcolor{lightgray}{\the\numexpr\value{stycke}+1\relax\,st.\quad}}%
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
