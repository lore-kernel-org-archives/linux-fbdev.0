From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] omapfb: invalid test on unsigned
Date: Mon, 22 Jun 2009 22:35:59 +0200
Message-ID: <4A3FEB2F.8040307@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: imre.deak@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Unsigned regno cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this correct? please review.

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 060d72f..787271f 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -276,7 +276,7 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 		if (r != 0)
 			break;
 
-		if (regno < 0) {
+		if (regno >= info->cmap.len) {
 			r = -EINVAL;
 			break;
 		}
