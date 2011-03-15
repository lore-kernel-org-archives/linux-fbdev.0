From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 15 Mar 2011 18:41:11 +0000
Subject: [GIT PULL] viafb updates for 2.6.39
Message-Id: <4D7FB2C7.80300@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

please pull the viafb updates below for this merge window.
The stuff is pretty boring, most things are cleanups. The only user visible 
change is the behavior for modes for which we don't know a proper clock now use 
the best available clock instead an invalid one. The rest are preparations which 
will allow easier improvements.


Thanks,

Florian Tobias Schandinat


The following changes since commit dd9c1549edef02290edced639f67b54a25abbe0e:
   Linus Torvalds (1):
         Linux 2.6.38-rc7

are available in the git repository at:

   git://github.com/schandinat/linux-2.6.git viafb-next

Florian Tobias Schandinat (9):
       viafb: kill lcd_panel_id
       viafb: remove unused data_mode and device_type
       viafb: strip some structures
       viafb: factor lcd scaling parameters out
       viafb: remove duplicated clock information
       viafb: always return the best possible clock
       viafb: remove duplicated clock storage
       viafb: split pll configs up
       Merge branch 'viafb-pll' into viafb-next

Peter Huewe (1):
       video/via: drop deprecated (and unused) i2c_adapter.id

Stephen Hemminger (2):
       video via: fix iomem access
       video via: make local variables static

  drivers/video/via/chip.h          |    9 -
  drivers/video/via/dvi.c           |    4 +-
  drivers/video/via/hw.c            |  772 ++++++++++++++++++-------------------
  drivers/video/via/hw.h            |    2 -
  drivers/video/via/lcd.c           |   83 +---
  drivers/video/via/share.h         |  141 -------
  drivers/video/via/tblDPASetting.c |   23 --
  drivers/video/via/tblDPASetting.h |    2 -
  drivers/video/via/via_i2c.c       |    3 +-
  drivers/video/via/viafbdev.c      |    6 +-
  drivers/video/via/viamode.c       |  507 ++++++++----------------
  drivers/video/via/viamode.h       |    9 -
  drivers/video/via/vt1636.c        |   43 +--
  13 files changed, 579 insertions(+), 1025 deletions(-)
