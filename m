From: Heiko Schocher <hs@denx.de>
Date: Thu, 11 Jun 2015 13:13:13 +0000
Subject: [PATCH] video: sm501fb: fixing static checker warning
Message-Id: <1434028393-32224-1-git-send-email-hs@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rasmus Villemoes <linux-qQsb+v5E8BnlAoU/VqSP6n9LOBIZ5rWg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Dan Carpenter reported the static checker warning:

drivers/video/fbdev/sm501fb.c:1958 sm501fb_probe()
warn: strcpy() 'cp' of unknown size might be too large for 'fb_mode'

Fix it, as the SM501 datasheet says the SM501 can "200 MHz
DAC support 1280x1024 resolution", which would result in a
too long mode string for current fb_mode var.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/video/fbdev/sm501fb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 9e74e8f..ea50df3 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -43,7 +43,9 @@
 
 #include "edid.h"
 
-static char *fb_mode = "640x480-16@60";
+static char *fb_default_mode = "640x480-16@60";
+static char fb_mode[20];
+static char *fb_mode_cmdline;
 static unsigned long default_bpp = 16;
 
 static struct fb_videomode sm501_default_mode = {
@@ -1963,6 +1965,12 @@ static int sm501fb_probe(struct platform_device *pdev)
 				if (info->edid_data)
 					found = 1;
 			}
+		} else {
+			if (fb_mode_cmdline)
+				strncpy(fb_mode, fb_mode_cmdline,
+					sizeof(fb_mode) - 1);
+			else
+				strcpy(fb_mode, fb_default_mode);
 		}
 #endif
 		if (!found) {
@@ -2230,7 +2238,7 @@ static struct platform_driver sm501fb_driver = {
 
 module_platform_driver(sm501fb_driver);
 
-module_param_named(mode, fb_mode, charp, 0);
+module_param_named(mode, fb_mode_cmdline, charp, 0);
 MODULE_PARM_DESC(mode,
 	"Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 module_param_named(bpp, default_bpp, ulong, 0);
-- 
2.1.0

