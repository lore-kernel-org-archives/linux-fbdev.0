From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] fbdev: xoffset,
	yoffset and yres are unsigned
Date: Wed,  4 Jun 2008 12:14:20 +0300
Message-ID: <1212570865-31419-2-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4j-0008Hz-V8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4i-000167-FX
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
In-Reply-To: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

The xoffset, yoffset and yres members of fb_var_screeninfo are __u32.
Make them unsigned in the code as well.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/fbmem.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 776f7fc..5554670 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -848,9 +848,8 @@ int
 fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	struct fb_fix_screeninfo *fix = &info->fix;
-        int xoffset = var->xoffset;
-        int yoffset = var->yoffset;
-        int err = 0, yres = info->var.yres;
+	unsigned int yres = info->var.yres;
+	int err = 0;
 
 	if (var->yoffset > 0) {
 		if (var->vmode & FB_VMODE_YWRAP) {
@@ -866,8 +865,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 				 (var->xoffset % fix->xpanstep)))
 		err = -EINVAL;
 
-        if (err || !info->fbops->fb_pan_display || xoffset < 0 ||
-	    yoffset < 0 || var->yoffset + yres > info->var.yres_virtual ||
+	if (err || !info->fbops->fb_pan_display ||
+	    var->yoffset + yres > info->var.yres_virtual ||
 	    var->xoffset + info->var.xres > info->var.xres_virtual)
 		return -EINVAL;
 
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
