From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 04 Sep 2012 10:30:51 +0000
Subject: [GIT PULL] fbdev fixes for 3.6
Message-Id: <5045D85B.6060501@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Linus,

please pull the fixes below.


Thanks,

Florian Tobias Schandinat


The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://github.com/schandinat/linux-2.6.git fbdev-fixes-for-3.6-1

for you to fetch changes up to c1c52848cef52e157468b8879fc3cae23b6f3a99:

  OMAPFB: fix framebuffer console colors (2012-08-23 12:37:22 +0000)

----------------------------------------------------------------
fbdev fixes for 3.6

- a fix by Paul Cercueil to prevent a possible buffer overflow
- a fix by Bruno Pr=E9mont to prevent a rare sleep in invalid context
- a fix by Julia Lawall for a double free in auo_k190x
- a fix by Dan Carpenter to prevent a division by zero in mb862xxfb
- a regression fix by Tomi Valkeinen for the SDI output in OMAP
- a fix by Grazvydas Ignotas to fix the console colors in OMAP

----------------------------------------------------------------
Bruno Pr=E9mont (1):
      fbcon: Fix bit_putcs() call to kmalloc(s, GFP_KERNEL)

Dan Carpenter (1):
      video: mb862xxfb: prevent divide by zero bug

Grazvydas Ignotas (1):
      OMAPFB: fix framebuffer console colors

Julia Lawall (1):
      drivers/video/auo_k190x.c: drop kfree of devm_kzalloc's data

Paul Cercueil (1):
      fbcon: prevent possible buffer overflow.

Tomi Valkeinen (1):
      OMAPDSS: Fix SDI PLL locking

 drivers/video/auo_k190x.c                |    2 --
 drivers/video/console/bitblit.c          |    2 +-
 drivers/video/console/fbcon.c            |    2 +-
 drivers/video/mb862xx/mb862xxfbdrv.c     |    2 ++
 drivers/video/omap2/dss/sdi.c            |   14 ++++++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 6 files changed, 19 insertions(+), 5 deletions(-)
