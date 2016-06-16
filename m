From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jun 2016 09:36:12 +0000
Subject: [PATCH 0/6] CLCD support for Nomadik and Versatile series
Message-Id: <1466069778-16087-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is a rebase and repost of my earlier "uncontroversial"
series of patches to CLCD, which excludes the part where
we deal with the Versatile autodetected displays. This makes
it possible to handle Nomadik graphics and RealView with just
device tree while keeping the Versatile specialties on hold.

We got an earlier nod from Tomi on this series:
http://marc.info/?l=linux-fbdev&m5733624305361&w=2

Sorry for not getting around to revising and reposting sooner :(

Linus Walleij (6):
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
 drivers/video/fbdev/amba-clcd.c           | 199 +++++++++++++--
 include/linux/amba/clcd.h                 |  63 ++++-
 8 files changed, 937 insertions(+), 21 deletions(-)
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 create mode 100644 drivers/video/fbdev/amba-clcd-versatile.h

-- 
2.4.11

