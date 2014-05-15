From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Thu, 15 May 2014 07:55:05 +0000
Subject: [PATCH] video : remove redundant error check
Message-Id: <20140515075505.GA28119@devel.8.8.4.4>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, jg1.han@samsung.com, daeseok.youn@gmail.com, daniel.vetter@ffwll.ch, Julia.Lawall@lip6.fr, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From 060757f81f85babf393cc76714d49af25af7791d Mon Sep 17 00:00:00 2001
From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Thu, 15 May 2014 16:51:35 +0900
Subject: [PATCH] video : remove redundant error check

It doesn't need to check "err" for printing info.
And also use pr_info instead of printk.

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index bb674e4..15cb397 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -1910,13 +1910,12 @@ static void i810fb_find_init_mode(struct fb_info *info)
 
 	for (i = 0; i < par->ddc_num + 1; i++) {
 		err = i810_probe_i2c_connector(info, &par->edid, i);
-		if (!err)
+		if (!err) {
+			pr_info("i810fb_init_pci: DDC probe successful\n");
 			break;
+		}
 	}
 
-	if (!err)
-		printk("i810fb_init_pci: DDC probe successful\n");
-
 	fb_edid_to_monspecs(par->edid, specs);
 
 	if (specs->modedb = NULL)
-- 
1.7.1

