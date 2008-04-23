From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] amifb: test virtual screen range before
	subtraction on unsigned
Date: Wed, 23 Apr 2008 20:55:28 +0200
Message-ID: <480F8620.2000502@tiscali.nl>
References: <480F6FF9.9000605@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jok83-00024R-0b for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 11:55:39 -0700
Received: from smtp-out3.tiscali.nl ([195.241.79.178])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jok80-00006l-Jz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 11:55:38 -0700
In-Reply-To: <480F6FF9.9000605@tiscali.nl>
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
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>

and another,
---
dx and dy are u32's, so the test should occur before the subtraction

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 4c9ec3f..cc62349 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2048,13 +2048,16 @@ static void amifb_copyarea(struct fb_info *info,
 	width = x2 - dx;
 	height = y2 - dy;
 
+	if (area->sx + dx < area->dx || area->sy + dy < area->dy)
+		return;
+
 	/* update sx,sy */
 	sx = area->sx + (dx - area->dx);
 	sy = area->sy + (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 || (sx + width) > info->var.xres_virtual ||
-	    (sy + height) > info->var.yres_virtual)
+	if (sx + width > info->var.xres_virtual ||
+			sy + height > info->var.yres_virtual)
 		return;
 
 	if (dy > sy || (dy == sy && dx > sx)) {


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
