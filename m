From: Grazvydas Ignotas <notasas@gmail.com>
Date: Sat, 04 Aug 2012 16:19:13 +0000
Subject: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Message-Id: <1344097153-13903-1-git-send-email-notasas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

omapfb does not currently set pseudo palette correctly for color depths
above 16bpp, making red text invisible, command like
  echo -e '\e[0;31mRED' > /dev/tty1
will display nothing on framebuffer console in 24bpp mode.
This is because temporary variable is declared incorrectly, fix it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 70aa47d..f7c1753 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1183,7 +1183,7 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
 			break;
 
 		if (regno < 16) {
-			u16 pal;
+			u32 pal;
 			pal = ((red >> (16 - var->red.length)) <<
 					var->red.offset) |
 				((green >> (16 - var->green.length)) <<
-- 
1.7.0.4

