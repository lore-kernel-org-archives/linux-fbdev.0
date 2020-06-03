From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 03 Jun 2020 09:25:47 +0000
Subject: [PATCH] fbdev: geocode: Add the missed pci_disable_device() for gx1fb_map_video_memory()
Message-Id: <20200603092547.1424428-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-geode@lists.infradead.org, dri-devel@lists.freedesktop.org, Adrian Bunk <bunk@stusta.de>, Andres Salomon <dilinger@queued.net>, David Vrabel <dvrabel@arcom.com>

Although gx1fb_probe() has handled the failure of gx1fb_map_video_memory()
partly, it does not call pci_disable_device() as gx1fb_map_video_memory()
calls pci_enable_device().
Add the missed function call to fix the bug.

Fixes: 53eed4ec8bcd ("[PATCH] fbdev: geode updates]")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/geode/gx1fb_core.c | 37 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index 5d34d89fb665..c9465542204a 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -208,29 +208,44 @@ static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 
 	ret = pci_request_region(dev, 0, "gx1fb (video)");
 	if (ret < 0)
-		return ret;
+		goto err;
 	par->vid_regs = pci_ioremap_bar(dev, 0);
-	if (!par->vid_regs)
-		return -ENOMEM;
+	if (!par->vid_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
-		return -EBUSY;
+	if (!request_mem_region(gx_base + 0x8300, 0x100,
+				"gx1fb (display controller)")) {
+		ret = -EBUSY;
+		goto err;
+	}
 	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
-	if (!par->dc_regs)
-		return -ENOMEM;
+	if (!par->dc_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	if ((fb_len = gx1_frame_buffer_size()) < 0)
-		return -ENOMEM;
+	if ((fb_len = gx1_frame_buffer_size()) < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	info->fix.smem_start = gx_base + 0x800000;
 	info->fix.smem_len = fb_len;
 	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
-	if (!info->screen_base)
-		return -ENOMEM;
+	if (!info->screen_base) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
 		 info->fix.smem_len / 1024, info->fix.smem_start);
 
 	return 0;
+
+err:
+	pci_disable_device(dev);
+	return ret;
 }
 
 static int parse_panel_option(struct fb_info *info)
-- 
2.26.2
