From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][FBDEV]: Find correct logo for directcolor < 24bpp
Date: Thu, 5 Aug 2004 07:53:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408050753.02074.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsVbX-0002QI-Aa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 16:55:31 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BsVbW-00010E-Pj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 16:55:31 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 72336764A53
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Aug 2004 23:03:15 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Andrew,

Current algorithm does not choose correct logo type for directcolor < 24 bpp.
It chooses logo_224, but this is too deep for bpp < 24.  This should fix the
problem.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff -uprN linux-2.6.8-rc2-mm2-orig/drivers/video/fbmem.c linux-2.6.8-rc2-mm2/drivers/video/fbmem.c
--- linux-2.6.8-rc2-mm2-orig/drivers/video/fbmem.c	2004-08-04 23:37:26.339174664 +0000
+++ linux-2.6.8-rc2-mm2/drivers/video/fbmem.c	2004-08-04 23:37:40.785978416 +0000
@@ -734,26 +734,35 @@ static struct logo_data {
 
 int fb_prepare_logo(struct fb_info *info)
 {
+	int depth = fb_get_color_depth(info);
+
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
-	switch (info->fix.visual) {
-	case FB_VISUAL_TRUECOLOR:
-		if (info->var.bits_per_pixel >= 8)
+	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		depth = info->var.blue.length;
+		if (info->var.red.length < depth)
+			depth = info->var.red.length;
+		if (info->var.green.length < depth)
+			depth = info->var.green.length;
+	}
+
+	if (depth >= 8) {
+		switch (info->fix.visual) {
+		case FB_VISUAL_TRUECOLOR:
 			fb_logo.needs_truepalette = 1;
-		break;
-	case FB_VISUAL_DIRECTCOLOR:
-		if (info->var.bits_per_pixel >= 24) {
+			break;
+		case FB_VISUAL_DIRECTCOLOR:
 			fb_logo.needs_directpalette = 1;
 			fb_logo.needs_cmapreset = 1;
+			break;
+		case FB_VISUAL_PSEUDOCOLOR:
+			fb_logo.needs_cmapreset = 1;
+			break;
 		}
-		break;
-	case FB_VISUAL_PSEUDOCOLOR:
-		fb_logo.needs_cmapreset = 1;
-		break;
 	}
 
 	/* Return if no suitable logo was found */
-	fb_logo.logo = fb_find_logo(fb_get_color_depth(info));
+	fb_logo.logo = fb_find_logo(depth);
 	
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
