From: Marek Vasut <marex@denx.de>
Date: Fri, 26 Aug 2016 15:53:35 +0000
Subject: [PATCH V2] video: mxsfb: Fix framebuffer corruption on mx6sx
Message-Id: <20160826155335.8747-1-marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Allocate the framebuffer memory as coherent, otherwise the framebuffer
will suffer from artifacts when displaying scrolling text or video.
This can be replicated on i.MX6SX (armv7), which has more complex memory
architecture compared to the i.MX23/28 (armv5).

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
---
V2: Switch to from dma_{alloc,free}_coherent() to dma_{alloc,free}_wc()
    for performance reasons, as suggested by Lucas Stach
---
 drivers/video/fbdev/mxsfb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 4e6608c..7846f0e 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -800,6 +800,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
 			struct fb_videomode *vmode)
 {
 	int ret;
+	struct device *dev = &host->pdev->dev;
 	struct fb_info *fb_info = &host->fb_info;
 	struct fb_var_screeninfo *var = &fb_info->var;
 	dma_addr_t fb_phys;
@@ -825,12 +826,10 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
 
 	/* Memory allocation for framebuffer */
 	fb_size = SZ_2M;
-	fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
+	fb_virt = dma_alloc_wc(dev, PAGE_ALIGN(fb_size), &fb_phys, GFP_KERNEL);
 	if (!fb_virt)
 		return -ENOMEM;
 
-	fb_phys = virt_to_phys(fb_virt);
-
 	fb_info->fix.smem_start = fb_phys;
 	fb_info->screen_base = fb_virt;
 	fb_info->screen_size = fb_info->fix.smem_len = fb_size;
@@ -843,9 +842,11 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
 
 static void mxsfb_free_videomem(struct mxsfb_info *host)
 {
+	struct device *dev = &host->pdev->dev;
 	struct fb_info *fb_info = &host->fb_info;
 
-	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
+	dma_free_wc(dev, fb_info->screen_size, fb_info->screen_base,
+		    fb_info->fix.smem_start);
 }
 
 static const struct platform_device_id mxsfb_devtype[] = {
-- 
2.9.3

