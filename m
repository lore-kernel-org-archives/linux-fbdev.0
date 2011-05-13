From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:45 +0000
Subject: [PATCH 1/5] video: mb862xxfb: correct fix.smem_len field initialization
Message-Id: <1305302089-7666-2-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Initialize smem_len field to the actual frame buffer size and
not to the whole video RAM size. This prevents overwriting
other video memory (which could be used by other layers, cursors
or accelerated drivers) by frame buffer applications relying on
fix.smem_len.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index c76e663..8257958 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -336,7 +336,6 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 
 	strcpy(fbi->fix.id, DRV_NAME);
 	fbi->fix.smem_start = (unsigned long)par->fb_base_phys;
-	fbi->fix.smem_len = par->mapped_vram;
 	fbi->fix.mmio_start = (unsigned long)par->mmio_base_phys;
 	fbi->fix.mmio_len = par->mmio_len;
 	fbi->fix.accel = FB_ACCEL_NONE;
@@ -420,6 +419,7 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 			 FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	fbi->fix.line_length = (fbi->var.xres_virtual *
 				fbi->var.bits_per_pixel) / 8;
+	fbi->fix.smem_len = fbi->fix.line_length * fbi->var.yres_virtual;
 	return 0;
 }
 
-- 
1.7.1

