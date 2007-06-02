From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/24] macfb: Fix pseudo_palette size
	and overrun
Date: Sat, 02 Jun 2007 17:58:14 +0800
Message-ID: <46613F36.3030701@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQif-0000FX-6l for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:25 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQic-00011W-Ty
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:23 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:22 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Huggins-Daines <dhd@debian.org>

- the pseudo_palette is only 16 elements long.
- do not write to the pseudo_palette if regno (array index) is more than 15.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/macfb.c |   93 ++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/video/macfb.c b/drivers/video/macfb.c
index f7d647d..aa8c714 100644
--- a/drivers/video/macfb.c
+++ b/drivers/video/macfb.c
@@ -170,7 +170,7 @@ static struct fb_fix_screeninfo macfb_fi
 };
 
 static struct fb_info fb_info;
-static u32 pseudo_palette[17];
+static u32 pseudo_palette[16];
 static int inverse   = 0;
 static int vidtest   = 0;
 
@@ -529,56 +529,63 @@ static int macfb_setcolreg(unsigned regn
 	if (regno >= fb_info->cmap.len)
 		return 1;
 
-	switch (fb_info->var.bits_per_pixel) {
-	case 1:
-		/* We shouldn't get here */
-		break;
-	case 2:
-	case 4:
-	case 8:
-		if (macfb_setpalette)
-			macfb_setpalette(regno, red, green, blue, fb_info);
-		else
-			return 1;
-		break;
-	case 16:
-		if (fb_info->var.red.offset == 10) {
-			/* 1:5:5:5 */
-			((u32*) (fb_info->pseudo_palette))[regno] =
+	if (fb_info->var.bits_per_pixel <= 8) {
+		switch (fb_info->var.bits_per_pixel) {
+		case 1:
+			/* We shouldn't get here */
+			break;
+		case 2:
+		case 4:
+		case 8:
+			if (macfb_setpalette)
+				macfb_setpalette(regno, red, green, blue,
+						 fb_info);
+			else
+				return 1;
+			break;
+		}
+	} else if (regno < 16) {
+		switch (fb_info->var.bits_per_pixel) {
+		case 16:
+			if (fb_info->var.red.offset == 10) {
+				/* 1:5:5:5 */
+				((u32*) (fb_info->pseudo_palette))[regno] =
 					((red   & 0xf800) >>  1) |
 					((green & 0xf800) >>  6) |
 					((blue  & 0xf800) >> 11) |
 					((transp != 0) << 15);
-		} else {
-			/* 0:5:6:5 */
-			((u32*) (fb_info->pseudo_palette))[regno] =
+			} else {
+				/* 0:5:6:5 */
+				((u32*) (fb_info->pseudo_palette))[regno] =
 					((red   & 0xf800)      ) |
 					((green & 0xfc00) >>  5) |
 					((blue  & 0xf800) >> 11);
+			}
+			break;
+			/* I'm pretty sure that one or the other of these
+			   doesn't exist on 68k Macs */
+		case 24:
+			red   >>= 8;
+			green >>= 8;
+			blue  >>= 8;
+			((u32 *)(fb_info->pseudo_palette))[regno] =
+				(red   << fb_info->var.red.offset)   |
+				(green << fb_info->var.green.offset) |
+				(blue  << fb_info->var.blue.offset);
+			break;
+		case 32:
+			red   >>= 8;
+			green >>= 8;
+			blue  >>= 8;
+			((u32 *)(fb_info->pseudo_palette))[regno] =
+				(red   << fb_info->var.red.offset)   |
+				(green << fb_info->var.green.offset) |
+				(blue  << fb_info->var.blue.offset);
+			break;
 		}
-		break;	
-		/* I'm pretty sure that one or the other of these
-		   doesn't exist on 68k Macs */
-	case 24:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		((u32 *)(fb_info->pseudo_palette))[regno] =
-			(red   << fb_info->var.red.offset)   |
-			(green << fb_info->var.green.offset) |
-			(blue  << fb_info->var.blue.offset);
-		break;
-	case 32:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		((u32 *)(fb_info->pseudo_palette))[regno] =
-			(red   << fb_info->var.red.offset)   |
-			(green << fb_info->var.green.offset) |
-			(blue  << fb_info->var.blue.offset);
-		break;
-    }
-    return 0;
+	}
+
+	return 0;
 }
 
 static struct fb_ops macfb_ops = {



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
