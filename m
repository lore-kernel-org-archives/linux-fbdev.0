From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 06:09:48 +0000
Subject: [PATCH 2/2] OMAPFB: fix framebuffer console colors
Message-Id: <1345529388-3509-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Grazvydas Ignotas <notasas@gmail.com>

omapfb does not currently set pseudo palette correctly for color depths
above 16bpp, making red text invisible, command like
  echo -e '\e[0;31mRED' > /dev/tty1
will display nothing on framebuffer console in 24bpp mode.
This is because temporary variable is declared incorrectly, fix it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: stable@vger.kernel.org # v3.x
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 08ec1a7..fc671d3 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1192,7 +1192,7 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
 			break;
 
 		if (regno < 16) {
-			u16 pal;
+			u32 pal;
 			pal = ((red >> (16 - var->red.length)) <<
 					var->red.offset) |
 				((green >> (16 - var->green.length)) <<
-- 
1.7.9.5

