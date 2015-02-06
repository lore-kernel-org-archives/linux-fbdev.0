From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:10 +0000
Subject: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

It makes sense to use vmalloc to allocate the video buffer since it has to be page aligned memory for using it with
mmap. Also deffered io seems buggy in combination with kmalloc'ed memory (crash on unloading the module).

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 43 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 01cfb46..945ded9 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/fb.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pwm.h>
@@ -93,6 +94,43 @@ static struct fb_var_screeninfo ssd1307fb_var = {
 	.bits_per_pixel	= 1,
 };
 
+static void *rvmalloc(unsigned long size)
+{
+	void *mem;
+	unsigned long adr;
+
+	size = PAGE_ALIGN(size);
+	mem = vmalloc_32(size);
+	if (!mem)
+		return NULL;
+
+	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
+	adr = (unsigned long) mem;
+	while (size > 0) {
+		SetPageReserved(vmalloc_to_page((void *)adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	return mem;
+}
+
+static void rvfree(void *mem, unsigned long size)
+{
+	unsigned long adr;
+
+	if (!mem)
+		return;
+
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		ClearPageReserved(vmalloc_to_page((void *)adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	vfree(mem);
+}
+
 static struct ssd1307fb_array *ssd1307fb_alloc_array(u32 len, u8 type)
 {
 	struct ssd1307fb_array *array;
@@ -538,13 +576,13 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (of_property_read_u32(node, "solomon,vcomh", &par->vcomh))
 		par->vcomh = par->device_info->default_vcomh;
 
-	vmem = devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
 	if (of_property_read_u32(node, "solomon,dclk-div", &par->dclk_div))
 		par->dclk_div = par->device_info->default_dclk_div;
 
 	if (of_property_read_u32(node, "solomon,dclk-frq", &par->dclk_frq))
 		par->dclk_frq  = par->device_info->default_dclk_frq;
 
+	vmem = rvmalloc(vmem_size);
 	if (!vmem) {
 		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
 		ret = -ENOMEM;
@@ -570,7 +608,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	info->var.blue.offset = 0;
 
 	info->screen_base = (u8 __force __iomem *)vmem;
-	info->fix.smem_start = (unsigned long)vmem;
+	info->fix.smem_start = __pa(vmem);
 	info->fix.smem_len = vmem_size;
 
 	fb_deferred_io_init(info);
@@ -614,6 +652,7 @@ panel_init_error:
 	};
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
+	rvfree(vmem, vmem_size);
 fb_alloc_error:
 	framebuffer_release(info);
 	return ret;
-- 
2.1.1

