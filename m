From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:12 +0000
Subject: [PATCH 6/8]  fbdev: ssd1307fb: Add module parameter to set update delay of the  deffered io.
Message-Id: <1423261694-5939-7-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch adds the module parameter "delaydivider" to set delay for the
deferred io. Effectively this is setting the refresh rate for mmap access
to the framebuffer. The delay for the deferred io is HZ/delaydivider.

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1d81877..b38315d 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -44,10 +44,14 @@
 #define	SSD1307FB_SET_VCOMH		0xdb
 
 #define BITSPERPIXEL 1
+#define DELAYDIVIDER 20
 
 static u_int bitsperpixel = BITSPERPIXEL;
 module_param(bitsperpixel, uint, 0);
 
+static u_int delaydivider = DELAYDIVIDER;
+module_param(delaydivider, uint, 0);
+
 struct ssd1307fb_par;
 
 struct ssd1307fb_deviceinfo {
@@ -312,7 +316,7 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
 }
 
 static struct fb_deferred_io ssd1307fb_defio = {
-	.delay		= HZ,
+	.delay		= HZ/DELAYDIVIDER,
 	.deferred_io	= ssd1307fb_deferred_io,
 };
 
@@ -601,6 +605,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	info->fix = ssd1307fb_fix;
 	info->fix.line_length = par->width * bitsperpixel / 8;
 	info->fbdefio = &ssd1307fb_defio;
+	info->fbdefio->delay = HZ/delaydivider;
 
 	info->var = ssd1307fb_var;
 	info->var.bits_per_pixel = bitsperpixel;
-- 
2.1.1

