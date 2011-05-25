From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:57:52 +0000
Subject: [PATCH 00/29] Use display information in info not in var for panning
Message-Id: <1306364301-8195-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

While playing with the FBIOPAN_DISPLAY ioctl I noticed that many drivers use
information from the ioctl argument such as the display resolution when they
should use the current settings from the fb_info structure.

These 29 patches fix most of those drivers. Missing drivers are ivtv (for
which I've already sent a patch), sh_mobile_lcdcfb (for which the fix is a
bit more complex, I will work on it later) and viafb (for which Florian Tobias
Schandinat has already sent a patch).

The patches have been compile-tested on architectures for which I have a
working compiler (x86 and ARM) with allyesconfig. I don't own any hardware
supported by these drivers so I haven't been able to perform additional tests.

I've split the fixes in one patch per driver for easier review and handling of
potential problems. The patches can be squashed together if needed. I've tried
to CC individual driver maintainers when possible.

Laurent Pinchart (29):
  68328fb: use display information in info not in var for panning
  acornfb: Dont BUG() on invalid pan parameters
  acornfb: use display information in info not in var for panning
  arkfb: use display information in info not in var for panning
  atmel_lcdfb: use display information in info not in var for panning
  radeonfb: use display information in info not in var for panning
  fbdev: da8xx: use display information in info not in var for panning
  fbdev: unicore32: use display information in info not in var for
    panning
  g364fb: use display information in info not in var for panning
  gxt4500: use display information in info not in var for panning
  hgafb: use display information in info not in var for panning
  imsttfb: use display information in info not in var for panning
  intelfb: use display information in info not in var for panning
  mb862xxfb: use display information in info not in var for panning
  mx3fb: use display information in info not in var for panning
  neofb: use display information in info not in var for panning
  pm2fb: use display information in info not in var for panning
  pm3fb: use display information in info not in var for panning
  s3c-fb: use display information in info not in var for panning
  s3c-fb: use display information in info not in var for panning
  s3fb: use display information in info not in var for panning
  sisfb: use display information in info not in var for panning
  sm501fb: use display information in info not in var for panning
  tridentfb: use display information in info not in var for panning
  vfb: use display information in info not in var for panning
  vga16fb: use display information in info not in var for panning
  vt8500lcdfb: use display information in info not in var for panning
  vt8623fb: use display information in info not in var for panning
  staging: xgifb: use display information in info not in var for
    panning

 drivers/staging/xgifb/XGI_main_26.c    |   22 ++++++----------------
 drivers/video/68328fb.c                |    4 ++--
 drivers/video/acornfb.c                |    5 +++--
 drivers/video/arkfb.c                  |    9 +++++----
 drivers/video/atmel_lcdfb.c            |   15 +++++++++------
 drivers/video/aty/radeon_base.c        |   10 +++++-----
 drivers/video/da8xx-fb.c               |    4 ++--
 drivers/video/fb-puv3.c                |    4 ++--
 drivers/video/g364fb.c                 |    5 +++--
 drivers/video/gxt4500.c                |    4 ++--
 drivers/video/hgafb.c                  |    4 ++--
 drivers/video/imsttfb.c                |    2 +-
 drivers/video/intelfb/intelfbhw.c      |    6 +++---
 drivers/video/mb862xx/mb862xxfb.c      |    2 +-
 drivers/video/mx3fb.c                  |    6 +++---
 drivers/video/neofb.c                  |    4 ++--
 drivers/video/pm2fb.c                  |    4 ++--
 drivers/video/pm3fb.c                  |    4 ++--
 drivers/video/s3c-fb.c                 |    2 +-
 drivers/video/s3fb.c                   |    7 ++++---
 drivers/video/savage/savagefb_driver.c |   16 +++++++---------
 drivers/video/sis/sis_main.c           |   30 ++++++++++--------------------
 drivers/video/sm501fb.c                |    6 +++---
 drivers/video/tridentfb.c              |    4 ++--
 drivers/video/vfb.c                    |    4 ++--
 drivers/video/vga16fb.c                |    2 +-
 drivers/video/vt8500lcdfb.c            |    4 ++--
 drivers/video/vt8623fb.c               |    9 +++++----
 28 files changed, 92 insertions(+), 106 deletions(-)

-- 
Regards,

Laurent Pinchart

