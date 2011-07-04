From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Jul 2011 08:21:05 +0000
Subject: [GIT PULL] fbdev fixes for 3.0-rc6
Message-Id: <20110704082105.GC24169@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-3.x.git fbdev-fix=
es-for-linus

Which contains:

Damian Hobson-Garcia (1):
      fbdev: sh_mobile_meram: Correct pointer check for YCbCr chroma plane

Daniel J Blueman (1):
      vesafb: fix memory leak

Lo=C3=AFc Minier (1):
      fbdev: amba: Link fb device to its parent

Pavel Shved (1):
      hecubafb: add module_put on error path in hecubafb_probe()

Randy Dunlap (2):
      gx1fb: Fix section mismatch warnings
      sm501fb: fix section mismatch warning

Timur Tabi (1):
      fsl-diu-fb: remove check for pixel clock ranges

William Katsak (1):
      udlfb: Correct sub-optimal resolution selection.

 drivers/video/amba-clcd.c        |    2 ++
 drivers/video/fsl-diu-fb.c       |   16 ----------------
 drivers/video/geode/gx1fb_core.c |   14 +++++++-------
 drivers/video/hecubafb.c         |    3 ++-
 drivers/video/sh_mobile_meram.c  |    2 +-
 drivers/video/sm501fb.c          |    2 +-
 drivers/video/udlfb.c            |    8 ++++++--
 drivers/video/vesafb.c           |    1 +
 include/linux/fsl-diu-fb.h       |    6 ------
 9 files changed, 20 insertions(+), 34 deletions(-)
