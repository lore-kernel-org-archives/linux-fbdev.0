From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:40 +0000
Subject: [PATCH v3 26/29] vga16fb: use display information in info not in var for panning
Message-Id: <1310123683-8064-27-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Antonino A. Daplas <adaplas@gmail.com>
---
 drivers/video/vga16fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 305c975..0267acd 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -207,7 +207,7 @@ static void vga16fb_pan_var(struct fb_info *info,
 	 * granularity if someone supports xoffset in bit resolution */
 	vga_io_r(VGA_IS1_RC);		/* reset flip-flop */
 	vga_io_w(VGA_ATT_IW, VGA_ATC_PEL);
-	if (var->bits_per_pixel = 8)
+	if (info->var.bits_per_pixel = 8)
 		vga_io_w(VGA_ATT_IW, (xoffset & 3) << 1);
 	else
 		vga_io_w(VGA_ATT_IW, xoffset & 7);
-- 
1.7.3.4

