From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 10:01:37 +0000
Subject: [PATCH 0/7] video: ARM CLCD: non-controversial parts
Message-Id: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is a redux version of the previous patch set that strips out
any attempts to auto-switch or rewrite the device tree to match
the CLCD Versatile panel.

Instead, it does detect it and COMPARE it to what was found in
the device tree, prints a warning if those do not match, and
continue anyway.

This patch series brings support for device tree-only boot with
graphics to the Nomadik and all RealView platforms (so we can boot
RealView with only device tree) so it is very useful still even
if the Versatile is not yet fully supported.

Please consider applying this for v4.6 if these parts look
uncontroversial. Or applying partly from low to high patch
numbers so I'm not sitting with too much out-of-tree code.

Also resending a fix which has not yet landed upstream (1/7)
I guess it was lost.

Linus Walleij (7):
  video: ARM CLCD: runtime check for Versatile
  video: ARM CLCD: backlight support for OF
  video: ARM CLCD: support DT signal inversion flags
  video: ARM CLCD: support pads connected in reverse order
  video: ARM CLCD: support Nomadik variant
  video: ARM CLCD: add special board and panel hooks for Nomadik
  video: ARM CLCD: add special panel hook for Versatiles

 drivers/video/fbdev/Kconfig               |   6 +-
 drivers/video/fbdev/Makefile              |   1 +
 drivers/video/fbdev/amba-clcd-nomadik.c   | 257 ++++++++++++++++++++
 drivers/video/fbdev/amba-clcd-nomadik.h   |  24 ++
 drivers/video/fbdev/amba-clcd-versatile.c | 391 ++++++++++++++++++++++++++++++
 drivers/video/fbdev/amba-clcd-versatile.h |  17 ++
 drivers/video/fbdev/amba-clcd.c           | 218 +++++++++++++++--
 include/linux/amba/clcd.h                 |  76 +++++-
 8 files changed, 958 insertions(+), 32 deletions(-)
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 create mode 100644 drivers/video/fbdev/amba-clcd-versatile.h

-- 
2.4.3

