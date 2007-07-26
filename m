From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/33] fbdev: Fix logo if logo depth is
 less than framebuffer depth
Date: Thu, 26 Jul 2007 19:46:40 +0800
Message-ID: <46A889A0.2060007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2sB-0000kZ-2u for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:19 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2sA-0007HM-SW
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:19 -0700
Received: by wa-out-1112.google.com with SMTP id k22so613963waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:55:18 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The VGA16 logo (bpp = 4) and monochrome logo (bpp = 1) do not contain any
color information (no CLUT).  If the fb depth is > logo depth, these logo's
will not properly display. Fix by using the console palette instead of
creating a new one.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmem.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 215ac57..0740272 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -244,8 +244,17 @@ static void fb_set_logo(struct fb_info *
 	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
 	u8 fg = 1, d;
 
-	if (fb_get_color_depth(&info->var, &info->fix) == 3)
+	switch (fb_get_color_depth(&info->var, &info->fix)) {
+	case 1:
+		fg = 1;
+		break;
+	case 2:
+		fg = 3;
+		break;
+	default:
 		fg = 7;
+		break;
+	}
 
 	if (info->fix.visual == FB_VISUAL_MONO01 ||
 	    info->fix.visual == FB_VISUAL_MONO10)
@@ -564,21 +573,6 @@ int fb_prepare_logo(struct fb_info *info
 		depth = 4;
 	}
 
-	if (depth >= 8) {
-		switch (info->fix.visual) {
-		case FB_VISUAL_TRUECOLOR:
-			fb_logo.needs_truepalette = 1;
-			break;
-		case FB_VISUAL_DIRECTCOLOR:
-			fb_logo.needs_directpalette = 1;
-			fb_logo.needs_cmapreset = 1;
-			break;
-		case FB_VISUAL_PSEUDOCOLOR:
-			fb_logo.needs_cmapreset = 1;
-			break;
-		}
-	}
-
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
 
@@ -604,6 +598,22 @@ int fb_prepare_logo(struct fb_info *info
 	else
 		fb_logo.depth = 1;
 
+
+ 	if (fb_logo.depth > 4 && depth > 4) {
+ 		switch (info->fix.visual) {
+ 		case FB_VISUAL_TRUECOLOR:
+ 			fb_logo.needs_truepalette = 1;
+ 			break;
+ 		case FB_VISUAL_DIRECTCOLOR:
+ 			fb_logo.needs_directpalette = 1;
+ 			fb_logo.needs_cmapreset = 1;
+ 			break;
+ 		case FB_VISUAL_PSEUDOCOLOR:
+ 			fb_logo.needs_cmapreset = 1;
+ 			break;
+ 		}
+ 	}
+
 	return fb_prepare_extra_logos(info, fb_logo.logo->height, yres);
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
