default: install

installdir = $(shell kpsewhich --var-value TEXMFHOME)/tex/latex/dtek
fontinstalldir = $(HOME)/.local/share/fonts/dtek

install:
	mkdir -p $(installdir)
	cp -r dtek.cls dtekprotokoll.cls dtekmotion.cls dtekinstruktion.cls dteklag.cls dtekkallelse.cls dteklogo.pdf dteklogo_orange.pdf ChS_FONTS $(installdir)
	mkdir -p $(fontinstalldir)
	cp ChS_FONTS/Open_Sans/*.ttf ChS_FONTS/PT_Serif/*.ttf $(fontinstalldir)
	fc-cache -f -v
