From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/7] fbcon: Save var rotate field in struct display
Date: Sun, 20 Mar 2005 21:08:40 +0800
Message-ID: <200503202108.40384.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0DY-0001JE-QV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:11:44 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0DX-0007lo-Rg
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:11:44 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A7DC614CE803
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:28 +0000 (UTC)
Content-Disposition: inline
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

  Add the rotate field among parameters saved in struct display (per console
  structure).  Some out-of-tree drivers are possibly using this field.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |    2 ++
 fbcon.h |    1 +
 2 files changed, 3 insertions(+)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-20 20:09:13 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-16 07:07:15 +08:00
@@ -703,6 +703,7 @@
 	disp->green = var->green;
 	disp->blue = var->blue;
 	disp->transp = var->transp;
+	disp->rotate = var->rotate;
 	disp->mode = fb_match_mode(var, &info->modelist);
 	if (disp->mode == NULL)
 		/* This should not happen */
@@ -726,6 +727,7 @@
 	var->green = disp->green;
 	var->blue = disp->blue;
 	var->transp = disp->transp;
+	var->rotate = disp->rotate;
 }
 
 static const char *fbcon_startup(void)
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-03-20 20:09:13 +08:00
+++ b/drivers/video/console/fbcon.h	2005-03-16 07:07:15 +08:00
@@ -41,6 +41,7 @@
     u32 grayscale;
     u32 nonstd;
     u32 accel_flags;
+    u32 rotate;
     struct fb_bitfield red;
     struct fb_bitfield green;
     struct fb_bitfield blue;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
