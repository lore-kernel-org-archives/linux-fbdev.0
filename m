From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:11 +0000
Subject: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch adds a module parameter 'bitsperpixel' to adjust the colordepth
of the framebuffer. All values >1 will result in memory map of the requested
color depth. However only the MSB of each pixel will be sent to the device.
The framebuffer identifies itself as a grayscale display with the specified
depth.

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 945ded9..1d81877 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -43,6 +43,11 @@
 #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
 #define	SSD1307FB_SET_VCOMH		0xdb
 
+#define BITSPERPIXEL 1
+
+static u_int bitsperpixel = BITSPERPIXEL;
+module_param(bitsperpixel, uint, 0);
+
 struct ssd1307fb_par;
 
 struct ssd1307fb_deviceinfo {
@@ -91,7 +96,8 @@ static struct fb_fix_screeninfo ssd1307fb_fix = {
 };
 
 static struct fb_var_screeninfo ssd1307fb_var = {
-	.bits_per_pixel	= 1,
+	.bits_per_pixel	= BITSPERPIXEL,
+	.grayscale = 1,
 };
 
 static void *rvmalloc(unsigned long size)
@@ -223,10 +229,11 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 			array->data[array_idx] = 0;
 			for (k = 0; k < 8; k++) {
 				u32 page_length = par->width * i;
-				u32 index = page_length + (par->width * k + j) / 8;
+				u32 index = page_length * bitsperpixel + (par->width * k + j) * bitsperpixel / 8;
 				u8 byte = *(vmem + index);
-				u8 bit = byte & (1 << (j % 8));
-				bit = bit >> (j % 8);
+				u8 bit = byte & (((1 << (bitsperpixel))-1) << (j % 8/bitsperpixel));
+
+				bit = (bit >> (j % 8/bitsperpixel)) >> (bitsperpixel-1);
 				array->data[array_idx] |= bit << k;
 			}
 		}
@@ -548,7 +555,6 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
 		par->page_offset = 1;
 
-	vmem_size = par->width * par->height / 8;
 	if (of_property_read_u32(node, "solomon,segment-remap", &par->seg_remap))
 		par->seg_remap = 0;
 
@@ -582,6 +588,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (of_property_read_u32(node, "solomon,dclk-frq", &par->dclk_frq))
 		par->dclk_frq  = par->device_info->default_dclk_frq;
 
+	vmem_size = par->width * par->height * bitsperpixel / 8;
+
 	vmem = rvmalloc(vmem_size);
 	if (!vmem) {
 		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
@@ -591,20 +599,21 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	info->fbops = &ssd1307fb_ops;
 	info->fix = ssd1307fb_fix;
-	info->fix.line_length = par->width / 8;
+	info->fix.line_length = par->width * bitsperpixel / 8;
 	info->fbdefio = &ssd1307fb_defio;
 
 	info->var = ssd1307fb_var;
+	info->var.bits_per_pixel = bitsperpixel;
 	info->var.xres = par->width;
 	info->var.xres_virtual = par->width;
 	info->var.yres = par->height;
 	info->var.yres_virtual = par->height;
 
-	info->var.red.length = 1;
+	info->var.red.length = bitsperpixel;
 	info->var.red.offset = 0;
-	info->var.green.length = 1;
+	info->var.green.length = bitsperpixel;
 	info->var.green.offset = 0;
-	info->var.blue.length = 1;
+	info->var.blue.length = bitsperpixel;
 	info->var.blue.offset = 0;
 
 	info->screen_base = (u8 __force __iomem *)vmem;
-- 
2.1.1

