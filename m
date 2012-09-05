From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Sep 2012 08:25:43 +0000
Subject: [PATCH 05/17] OMAPFB: clear framebuffers with CPU
Message-Id: <1346833555-31258-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently vram.c clears the allocated memory automatically using OMAP
system DMA. In an effort to reduce OMAP dependencies, we'll do the
memory clear with CPU from now on.

This patch implements clearing of the framebuffer in omapfb, using
cfb_fillrect() to do the actual clear.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index fc671d3..7afdfcf 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1592,6 +1592,20 @@ static int omapfb_allocate_all_fbs(struct omapfb2_device *fbdev)
 	return 0;
 }
 
+static void omapfb_clear_fb(struct fb_info *fbi)
+{
+	const struct fb_fillrect rect = {
+		.dx = 0,
+		.dy = 0,
+		.width = fbi->var.xres_virtual,
+		.height = fbi->var.yres_virtual,
+		.color = 0,
+		.rop = ROP_COPY,
+	};
+
+	cfb_fillrect(fbi, &rect);
+}
+
 int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
@@ -1661,6 +1675,8 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 			goto err;
 	}
 
+	omapfb_clear_fb(fbi);
+
 	return 0;
 err:
 	omapfb_free_fbmem(fbi);
@@ -1972,6 +1988,16 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 		}
 	}
 
+	for (i = 0; i < fbdev->num_fbs; i++) {
+		struct fb_info *fbi = fbdev->fbs[i];
+		struct omapfb_info *ofbi = FB2OFB(fbi);
+
+		if (ofbi->region->size = 0)
+			continue;
+
+		omapfb_clear_fb(fbi);
+	}
+
 	/* Enable fb0 */
 	if (fbdev->num_fbs > 0) {
 		struct omapfb_info *ofbi = FB2OFB(fbdev->fbs[0]);
-- 
1.7.9.5

