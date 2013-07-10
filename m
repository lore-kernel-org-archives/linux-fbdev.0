From: Luis Henriques <luis.henriques@canonical.com>
Date: Wed, 10 Jul 2013 22:57:00 +0000
Subject: [PATCH] vga16fb: Remove unused variable
Message-Id: <20130710225659.GA14107@hercules>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

Fix build warning of unused variable:

drivers/video/vga16fb.c:1268:26: warning: unused variable ‘dev’ [-Wunused-variable]

Signed-off-by: Luis Henriques<luis.henriques@canonical.com>
---
 drivers/video/vga16fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 830ded4..2827333 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1265,7 +1265,6 @@ static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image
 
 static void vga16fb_destroy(struct fb_info *info)
 {
-	struct platform_device *dev = container_of(info->device, struct platform_device, dev);
 	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 	/* XXX unshare VGA regions */
-- 
1.8.1.2
