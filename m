From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 19/41] hecubafb: Use sys instead of cfb
	drawing functions
Date: Wed, 25 Apr 2007 14:43:36 +0800
Message-ID: <462EF898.4090307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcFM-0001xp-Pl for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:49:04 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc8a-0002pB-H8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:42:04 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:42:04 -0700 (PDT)
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

Since hecubafb's framebuffer is vmalloc'ed, use the sys_* drawing functions
instead of cfb_*.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig    |    6 +++---
 drivers/video/hecubafb.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 9c49f4f..2a571f9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -599,9 +599,9 @@ config FB_IMAC
 config FB_HECUBA
        tristate "Hecuba board support"
        depends on FB && X86 && MMU
-       select FB_CFB_FILLRECT
-       select FB_CFB_COPYAREA
-       select FB_CFB_IMAGEBLIT
+       select FB_SYS_FILLRECT
+       select FB_SYS_COPYAREA
+       select FB_SYS_IMAGEBLIT
        select FB_DEFERRED_IO
        help
          This enables support for the Hecuba board. This driver was tested
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index dc12e2d..0ade725 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -238,7 +238,7 @@ static void hecubafb_fillrect(struct fb_
 {
 	struct hecubafb_par *par = info->par;
 
-	cfb_fillrect(info, rect);
+	sys_fillrect(info, rect);
 
 	hecubafb_dpy_update(par);
 }
@@ -248,7 +248,7 @@ static void hecubafb_copyarea(struct fb_
 {
 	struct hecubafb_par *par = info->par;
 
-	cfb_copyarea(info, area);
+	sys_copyarea(info, area);
 
 	hecubafb_dpy_update(par);
 }
@@ -258,7 +258,7 @@ static void hecubafb_imageblit(struct fb
 {
 	struct hecubafb_par *par = info->par;
 
-	cfb_imageblit(info, image);
+	sys_imageblit(info, image);
 
 	hecubafb_dpy_update(par);
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
