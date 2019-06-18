From: Marko Kohtala <marko.kohtala@okoko.fi>
Date: Tue, 18 Jun 2019 07:41:06 +0000
Subject: [PATCH 1/6] video: ssd1307fb: Use screen_buffer instead of screen_base
Message-Id: <20190618074111.9309-2-marko.kohtala@okoko.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190618074111.9309-1-marko.kohtala@okoko.fi>
In-Reply-To: <20190618074111.9309-1-marko.kohtala@okoko.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

sparse reported incorrect type due to different address spaces.
The screen_base is __iomem, but the memory is not from a device so we can
use screen_buffer instead and avoid some type casts.

Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
---
 drivers/video/fbdev/ssd1307fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3b361bc9feb8..6c2980331ffd 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -150,7 +150,7 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
 static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
-	u8 *vmem = par->info->screen_base;
+	u8 *vmem = par->info->screen_buffer;
 	int i, j, k;
 
 	array = ssd1307fb_alloc_array(par->width * par->height / 8,
@@ -213,7 +213,7 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	struct ssd1307fb_par *par = info->par;
 	unsigned long total_size;
 	unsigned long p = *ppos;
-	u8 __iomem *dst;
+	void *dst;
 
 	total_size = info->fix.smem_len;
 
@@ -226,7 +226,7 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
-	dst = (void __force *) (info->screen_base + p);
+	dst = info->screen_buffer + p;
 
 	if (copy_from_user(dst, buf, count))
 		return -EFAULT;
@@ -547,7 +547,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	struct fb_deferred_io *ssd1307fb_defio;
 	u32 vmem_size;
 	struct ssd1307fb_par *par;
-	u8 *vmem;
+	void *vmem;
 	int ret;
 
 	if (!node) {
@@ -657,7 +657,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	info->var.blue.length = 1;
 	info->var.blue.offset = 0;
 
-	info->screen_base = (u8 __force __iomem *)vmem;
+	info->screen_buffer = vmem;
 	info->fix.smem_start = __pa(vmem);
 	info->fix.smem_len = vmem_size;
 
-- 
2.17.1
