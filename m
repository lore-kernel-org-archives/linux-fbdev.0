From: Kai Jiang <b18973@freescale.com>
Subject: [linux-fbdev-devel][PATCH]fb_pan_display:add
	x/yoffset check
Date: Mon, 29 Jun 2009 11:49:31 +0800
Message-ID: <4A4839CB.8020801@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030103050505000406070209"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1ML7oc-0000rT-Aw
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 03:45:58 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ML7ob-0007X6-DN
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 03:45:58 +0000
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5T3jXdv010284 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 28 Jun 2009 20:45:38 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n5T3jVQx024407
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 28 Jun 2009 22:45:32 -0500 (CDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030103050505000406070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030103050505000406070209
Content-Type: text/x-patch;
 name="fb_pan_display-check-offset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb_pan_display-check-offset.patch"

From a01ede69772634b30a83b44eada5a8db66f8463a Mon Sep 17 00:00:00 2001
From: Kai Jiang <Kai.Jiang@freescale.com>
Date: Mon, 29 Jun 2009 11:25:58 +0800
Subject: [PATCH] When moving virtual space straight to one side in the screen(ex.
 straight to the left),finally the virtual space will move outside
 of the real screen. Then the xoffset or yoffset will be nagative
 value(transfered from user application) to indicate that the virtual
 space is beyond the screen boundary. In the function fb_pan_disaplay,
 xoffset and yoffset should be checked to ensure that, when they are
 negative, the virtual space will not move any more,and the function
 will return an error. However, xoffset and yoffset in the structure
 fb_var_screeninfo are "__u32" type, here need to transfer them to
 "int" type for comparing.

Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
---
 drivers/video/fbmem.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index d412a1d..27628de 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -855,6 +855,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	struct fb_fix_screeninfo *fix = &info->fix;
 	unsigned int yres = info->var.yres;
+	int xoffset = var->xoffset;
+	int yoffset = var->yoffset;
 	int err = 0;
 
 	if (var->yoffset > 0) {
@@ -873,7 +875,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 
 	if (err || !info->fbops->fb_pan_display ||
 	    var->yoffset + yres > info->var.yres_virtual ||
-	    var->xoffset + info->var.xres > info->var.xres_virtual)
+	    var->xoffset + info->var.xres > info->var.xres_virtual ||
+	    xoffset < 0 || yoffset < 0)
 		return -EINVAL;
 
 	if ((err = info->fbops->fb_pan_display(var, info)))
-- 
1.6.2.1


--------------030103050505000406070209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------030103050505000406070209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------030103050505000406070209--
