From: Marko Kohtala <marko.kohtala@okoko.fi>
Date: Tue, 18 Jun 2019 07:41:09 +0000
Subject: [PATCH 4/6] video: ssd1307fb: Handle width and height that are not multiple of 8
Message-Id: <20190618074111.9309-5-marko.kohtala@okoko.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190618074111.9309-1-marko.kohtala@okoko.fi>
In-Reply-To: <20190618074111.9309-1-marko.kohtala@okoko.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

Some displays have dimensions that are not multiple of eight, for example
height of 36, but the driver divided the dimensions by 8. Defining display
to the next multiple of 8 is not good as then the display registers get
configured to dimensions that do not match. This contradicts intructions
by some display manufacturers.

Use DIV_ROUND_UP to multiple of 8 when needed so correct values can be
used.

The ssd1307fb_update_display bit reordering receives a simplification in
the process.

Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
---
 drivers/video/fbdev/ssd1307fb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 86f2b79f3ed5..4f4a1b99d17d 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -151,10 +151,11 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
 	u8 *vmem = par->info->screen_buffer;
+	unsigned int line_length = par->info->fix.line_length;
+	unsigned int pages = DIV_ROUND_UP(par->height, 8);
 	int i, j, k;
 
-	array = ssd1307fb_alloc_array(par->width * par->height / 8,
-				      SSD1307FB_DATA);
+	array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
 	if (!array)
 		return;
 
@@ -187,22 +188,24 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
 	 */
 
-	for (i = 0; i < (par->height / 8); i++) {
+	for (i = 0; i < pages; i++) {
 		for (j = 0; j < par->width; j++) {
+			int m = 8;
 			u32 array_idx = i * par->width + j;
 			array->data[array_idx] = 0;
-			for (k = 0; k < 8; k++) {
-				u32 page_length = par->width * i;
-				u32 index = page_length + (par->width * k + j) / 8;
-				u8 byte = *(vmem + index);
-				u8 bit = byte & (1 << (j % 8));
-				bit = bit >> (j % 8);
+			/* Last page may be partial */
+			if (i + 1 = pages && par->height % 8)
+				m = par->height % 8;
+			for (k = 0; k < m; k++) {
+				u8 byte = vmem[(8 * i + k) * line_length +
+					       j / 8];
+				u8 bit = (byte >> (j % 8)) & 1;
 				array->data[array_idx] |= bit << k;
 			}
 		}
 	}
 
-	ssd1307fb_write_array(par->client, array, par->width * par->height / 8);
+	ssd1307fb_write_array(par->client, array, par->width * pages);
 	kfree(array);
 }
 
@@ -438,7 +441,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		return ret;
 
 	ret = ssd1307fb_write_cmd(par->client,
-				  par->page_offset + (par->height / 8) - 1);
+				  par->page_offset +
+				  DIV_ROUND_UP(par->height, 8) - 1);
 	if (ret < 0)
 		return ret;
 
@@ -618,7 +622,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->dclk_div = par->device_info->default_dclk_div;
 	par->dclk_frq = par->device_info->default_dclk_frq;
 
-	vmem_size = par->width * par->height / 8;
+	vmem_size = DIV_ROUND_UP(par->width, 8) * par->height;
 
 	vmem = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					get_order(vmem_size));
@@ -641,7 +645,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	info->fbops = &ssd1307fb_ops;
 	info->fix = ssd1307fb_fix;
-	info->fix.line_length = par->width / 8;
+	info->fix.line_length = DIV_ROUND_UP(par->width, 8);
 	info->fbdefio = ssd1307fb_defio;
 
 	info->var = ssd1307fb_var;
-- 
2.17.1
