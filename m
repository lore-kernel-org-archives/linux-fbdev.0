From: Johan Hovold <jhovold@gmail.com>
Date: Mon, 10 Dec 2012 12:28:47 +0000
Subject: [PATCH 0/3] atmel_lcdfb: fix 16-bpp regression
Message-Id: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

These patches fix a regression in 16-bpp support for older SOCs which use
IBGR:555 rather than BGR:565 pixel layout. Use SOC-type to determine if the
controller uses the intensity-bit and restore the old layout in that case.

The third patch is simply a clean up.

Thanks,
Johan

Johan Hovold (3):
  atmel_lcdfb: fix 16-bpp modes on older SOCs
  ARM: at91/neocore926: fix LCD-wiring mode
  atmel_lcdfb: remove unsupported 15-bpp mode

 arch/arm/mach-at91/board-neocore926.c |  2 +-
 drivers/video/atmel_lcdfb.c           | 23 +++++++++++++++--------
 include/video/atmel_lcdc.h            |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.8.0

