From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 07 Sep 2016 09:09:19 +0000
Subject: [PATCH] simplefb: Disable and release clocks and regulators in destroy callback
Message-Id: <20160907090919.27187-1-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

simplefb gets unregister when a proper framebuffer driver comes in and
kicks it out. However the claimed clocks and regulators stay enabled
as they are only released in the platform device remove function, which
in theory would never get called.

Move the clock/regulator cleanup into the framebuffer destroy callback,
which gets called as part of the framebuffer unregister process.

Note this introduces asymmetry in how the resources are claimed and
released.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/video/fbdev/simplefb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index e9cf19977285..3620d10a0d00 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -74,8 +74,14 @@ static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	return 0;
 }
 
+struct simplefb_par;
+static void simplefb_clocks_destroy(struct simplefb_par *par);
+static void simplefb_regulators_destroy(struct simplefb_par *par);
+
 static void simplefb_destroy(struct fb_info *info)
 {
+	simplefb_regulators_destroy(info->par);
+	simplefb_clocks_destroy(info->par);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 }
@@ -487,11 +493,8 @@ error_fb_release:
 static int simplefb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
-	struct simplefb_par *par = info->par;
 
 	unregister_framebuffer(info);
-	simplefb_regulators_destroy(par);
-	simplefb_clocks_destroy(par);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.9.3

