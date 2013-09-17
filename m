From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 04:53:26 +0000
Subject: [PATCH 00/19] video: use dev_get_platdata()
Message-Id: <000401ceb361$d84c4600$88e4d200$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

---
 drivers/video/amba-clcd.c        |    2 +-
 drivers/video/atmel_lcdfb.c      |    4 ++--
 drivers/video/da8xx-fb.c         |    4 ++--
 drivers/video/ep93xx-fb.c        |    2 +-
 drivers/video/imxfb.c            |    6 +++---
 drivers/video/mbx/mbxfb.c        |    2 +-
 drivers/video/mx3fb.c            |    4 ++--
 drivers/video/nuc900fb.c         |    6 +++---
 drivers/video/omap/hwa742.c      |    2 +-
 drivers/video/omap/omapfb_main.c |    4 ++--
 drivers/video/pxa168fb.c         |    6 +++---
 drivers/video/pxafb.c            |   16 ++++++++--------
 drivers/video/s1d13xxxfb.c       |   12 ++++++------
 drivers/video/s3c-fb.c           |    2 +-
 drivers/video/s3c2410fb.c        |    6 +++---
 drivers/video/sa1100fb.c         |    4 ++--
 drivers/video/sh_mobile_hdmi.c   |    6 +++---
 drivers/video/simplefb.c         |    4 ++--
 drivers/video/tmiofb.c           |   10 +++++-----
 drivers/video/w100fb.c           |    2 +-
 20 files changed, 52 insertions(+), 52 deletions(-)


