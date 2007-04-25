From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/41] arcfb: Use sys instead of cfb
	drawing functions
Date: Wed, 25 Apr 2007 14:42:29 +0800
Message-ID: <462EF855.5050007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc8F-0001A6-K4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:41:43 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc8F-0002pB-Av
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:41:43 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:41:43 -0700 (PDT)
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
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Since arcfb's framebuffer is vmalloc'ed, use the sys_* drawing functions
instead of cfb_*.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |    6 +++---
 drivers/video/arcfb.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 234502d..9c49f4f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -412,9 +412,9 @@ config FB_FM2
 config FB_ARC
 	tristate "Arc Monochrome LCD board support"
 	depends on FB && X86
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
 	help
 	  This enables support for the Arc Monochrome LCD board. The board
 	  is based on the KS-108 lcd controller and is typically a matrix
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 66e0bd1..740b83b 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -369,7 +369,7 @@ static void arcfb_fillrect(struct fb_inf
 {
 	struct arcfb_par *par = info->par;
 
-	cfb_fillrect(info, rect);
+	sys_fillrect(info, rect);
 
 	/* update the physical lcd */
 	arcfb_lcd_update(par, rect->dx, rect->dy, rect->width, rect->height);
@@ -380,7 +380,7 @@ static void arcfb_copyarea(struct fb_inf
 {
 	struct arcfb_par *par = info->par;
 
-	cfb_copyarea(info, area);
+	sys_copyarea(info, area);
 
 	/* update the physical lcd */
 	arcfb_lcd_update(par, area->dx, area->dy, area->width, area->height);
@@ -390,7 +390,7 @@ static void arcfb_imageblit(struct fb_in
 {
 	struct arcfb_par *par = info->par;
 
-	cfb_imageblit(info, image);
+	sys_imageblit(info, image);
 
 	/* update the physical lcd */
 	arcfb_lcd_update(par, image->dx, image->dy, image->width,


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
