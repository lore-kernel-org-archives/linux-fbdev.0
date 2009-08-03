From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH] fb: fix fb_pan_display range check
Date: Mon,  3 Aug 2009 18:58:53 +0000
Message-ID: <1249325933-3721-1-git-send-email-FlorianSchandinat@gmx.de>
References: <4A56FA39.1040905@freescale.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754170AbZHCS5U@vger.kernel.org>
In-Reply-To: <4A56FA39.1040905@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, b18973@freescale.com
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

fb: fix fb_pan_display range check

This patch fixes the range check for panning. The current code fails to detect
some invalid values (very high ones that can occur if an app tries to move
further up/left than 0,0) as the check uses the unknown values for calculation
so that an overflow can occur. To fix this it is sufficient to move the
calculation to the right side to use only trusted values.
Kai Jiang detected this problem and proposed an initial patch.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/fbmem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index a85c818..346f257 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -871,8 +871,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 		err = -EINVAL;
 
 	if (err || !info->fbops->fb_pan_display ||
-	    var->yoffset + yres > info->var.yres_virtual ||
-	    var->xoffset + info->var.xres > info->var.xres_virtual)
+	    var->yoffset > info->var.yres_virtual - yres ||
+	    var->xoffset > info->var.xres_virtual - info->var.xres)
 		return -EINVAL;
 
 	if ((err = info->fbops->fb_pan_display(var, info)))
-- 
1.6.3.2
