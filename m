From: Richard Genoud <richard.genoud@gmail.com>
Date: Fri, 31 May 2013 14:28:38 +0000
Subject: [PATCH 1/2] trivial: atmel_lcdfb: add missing error message
Message-Id: <1370010519-18691-1-git-send-email-richard.genoud@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>

When a too small framebuffer is given, the atmel_lcdfb_check_var
silently fails.
Adding an error message will save some head scratching.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/video/atmel_lcdfb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 540909d..6e6491f 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -461,8 +461,11 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 	if (info->fix.smem_len) {
 		unsigned int smem_len = (var->xres_virtual * var->yres_virtual
 					 * ((var->bits_per_pixel + 7) / 8));
-		if (smem_len > info->fix.smem_len)
+		if (smem_len > info->fix.smem_len) {
+			dev_err(dev, "Frame buffer is too small (%u) for screen size (need at least %u)\n",
+				info->fix.smem_len, smem_len);
 			return -EINVAL;
+		}
 	}
 
 	/* Saturate vertical and horizontal timings at maximum values */
-- 
1.7.10.4

