From: Aditya Nellutla <aditya.n@ti.com>
Date: Wed, 23 May 2012 06:18:31 +0000
Subject: [PATCH] da8xx-fb: Rounding FB size to satisfy SGX buffer requirements
Message-Id: <1337753191-14802-1-git-send-email-aditya.n@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In the real time use-case when SGX is used for rendering to FB buffers it has been
observed that, the available memory from framebuffer driver is not sufficient for
SGX under certain cases (like 16-bit WVGA resolution). SGX requires 2 swap buffers
with each of the buffers aligned to lcm(line_length, PAGE_SIZE).

Inorder to satisfy this requirement, we have two options,

	- Increase number of FB buffers (LCD_NUM_BUFFERS) to 3. This is not
	  recommended as we end up wasting huge memory in most of the cases.

	- Align FB buffers to lcm(line_length, PAGE_SIZE).This ensures framebuffer
	  size is increased to satisfy SGX requirements keeping alignment intact.

This patch makes sure that FB allocates buffers aligned to above formula.

Signed-off-by: Aditya Nellutla <aditya.n@ti.com>
---
 drivers/video/da8xx-fb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 47118c7..2f24c19 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -31,6 +31,7 @@
 #include <linux/cpufreq.h>
 #include <linux/console.h>
 #include <linux/slab.h>
+#include <linux/lcm.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>
 
@@ -1114,6 +1115,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	struct da8xx_fb_par *par;
 	resource_size_t len;
 	int ret, i;
+	unsigned long ulcm;
 
 	if (fb_pdata = NULL) {
 		dev_err(&device->dev, "Can not get platform data\n");
@@ -1209,7 +1211,8 @@ static int __devinit fb_probe(struct platform_device *device)
 
 	/* allocate frame buffer */
 	par->vram_size = lcdc_info->width * lcdc_info->height * lcd_cfg->bpp;
-	par->vram_size = PAGE_ALIGN(par->vram_size/8);
+	ulcm = lcm((lcdc_info->width * lcd_cfg->bpp)/8, PAGE_SIZE);
+	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
 	par->vram_virt = dma_alloc_coherent(NULL,
-- 
1.7.0.4

