From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 06:49:16 +0000
Subject: [PATCH 00/21] video: remove unnecessary pci_set_drvdata()
Message-Id: <001a01ceaf84$32c52d90$984f88b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound),
the driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

---
 drivers/video/arkfb.c                  |    1 -
 drivers/video/carminefb.c              |    1 -
 drivers/video/cirrusfb.c               |    1 -
 drivers/video/cyber2000fb.c            |    5 -----
 drivers/video/geode/gx1fb_core.c       |    1 -
 drivers/video/geode/gxfb_core.c        |    1 -
 drivers/video/geode/lxfb_core.c        |    1 -
 drivers/video/i740fb.c                 |    1 -
 drivers/video/i810/i810_main.c         |    1 -
 drivers/video/intelfb/intelfbdrv.c     |    2 --
 drivers/video/kyro/fbdev.c             |    1 -
 drivers/video/mb862xx/mb862xxfbdrv.c   |    1 -
 drivers/video/neofb.c                  |    6 ------
 drivers/video/pm2fb.c                  |    1 -
 drivers/video/pm3fb.c                  |    1 -
 drivers/video/s3fb.c                   |    1 -
 drivers/video/savage/savagefb_driver.c |    6 ------
 drivers/video/sis/sis_main.c           |    4 ----
 drivers/video/tdfxfb.c                 |    1 -
 drivers/video/tridentfb.c              |    1 -
 drivers/video/vt8623fb.c               |    1 -
 21 files changed, 39 deletions(-)

