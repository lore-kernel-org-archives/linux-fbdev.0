From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/17] vesafb: Fix color palette handling
Date: Tue, 18 Oct 2005 17:16:56 +0800
Message-ID: <4354BD88.9060003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIK-0000bl-GG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:48 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIK-0000dG-DA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:48 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:48 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Fix out-of-bounds bug.  The pseudopalette has room only for 16 entries,
thus, write only the first 16 entries to the pseudopalette.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 vesafb.c |   56 +++++++++++++++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 31 deletions(-)


diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -164,45 +164,39 @@ static int vesafb_setcolreg(unsigned reg
 	if (regno >= info->cmap.len)
 		return 1;
 
-	switch (info->var.bits_per_pixel) {
-	case 8:
+	if (info->var.bits_per_pixel == 8)
 		vesa_setpalette(regno,red,green,blue);
-		break;
-	case 16:
-		if (info->var.red.offset == 10) {
-			/* 1:5:5:5 */
-			((u32*) (info->pseudo_palette))[regno] =	
+	else if (regno < 16) {
+		switch (info->var.bits_per_pixel) {
+		case 16:
+			if (info->var.red.offset == 10) {
+				/* 1:5:5:5 */
+				((u32*) (info->pseudo_palette))[regno] =
 					((red   & 0xf800) >>  1) |
 					((green & 0xf800) >>  6) |
 					((blue  & 0xf800) >> 11);
-		} else {
-			/* 0:5:6:5 */
-			((u32*) (info->pseudo_palette))[regno] =	
+			} else {
+				/* 0:5:6:5 */
+				((u32*) (info->pseudo_palette))[regno] =
 					((red   & 0xf800)      ) |
 					((green & 0xfc00) >>  5) |
 					((blue  & 0xf800) >> 11);
+			}
+			break;
+		case 24:
+		case 32:
+			red   >>= 8;
+			green >>= 8;
+			blue  >>= 8;
+			((u32 *)(info->pseudo_palette))[regno] =
+				(red   << info->var.red.offset)   |
+				(green << info->var.green.offset) |
+				(blue  << info->var.blue.offset);
+			break;
 		}
-		break;
-	case 24:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		((u32 *)(info->pseudo_palette))[regno] =
-			(red   << info->var.red.offset)   |
-			(green << info->var.green.offset) |
-			(blue  << info->var.blue.offset);
-		break;
-	case 32:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		((u32 *)(info->pseudo_palette))[regno] =
-			(red   << info->var.red.offset)   |
-			(green << info->var.green.offset) |
-			(blue  << info->var.blue.offset);
-		break;
-    }
-    return 0;
+	}
+
+	return 0;
 }
 
 static struct fb_ops vesafb_ops = {




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
