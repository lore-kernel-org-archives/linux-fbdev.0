From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 20/41] vfb: Use sys instead of cfb
	drawing functions
Date: Wed, 25 Apr 2007 14:44:18 +0800
Message-ID: <462EF8C2.8090207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc8o-0001Fu-D3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:18 -0700
Received: from wx-out-0506.google.com ([66.249.82.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc8o-0003kc-3q
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:18 -0700
Received: by wx-out-0506.google.com with SMTP id i30so295188wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:42:17 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Since vfb's framebuffer is vmalloc'ed, use the sys_* drawing functions
instead of cfb_*.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |    6 +++---
 drivers/video/vfb.c   |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2a571f9..60e3ceb 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1704,9 +1704,9 @@ config FB_PS3_DEFAULT_SIZE_M
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index a9b99b0..1293c20 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -88,9 +88,9 @@ static struct fb_ops vfb_ops = {
 	.fb_set_par	= vfb_set_par,
 	.fb_setcolreg	= vfb_setcolreg,
 	.fb_pan_display	= vfb_pan_display,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_fillrect	= sys_fillrect,
+	.fb_copyarea	= sys_copyarea,
+	.fb_imageblit	= sys_imageblit,
 	.fb_mmap	= vfb_mmap,
 };
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
