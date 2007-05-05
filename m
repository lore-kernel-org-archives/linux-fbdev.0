From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/20] skeletonfb: improvements
Date: Sat, 05 May 2007 23:05:17 +0800
Message-ID: <463C9D2D.4020305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkNx5-0000b4-2C for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 10:21:47 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEY-0008EN-Gc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:43 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:42 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds a macro to register PCI ids table and corrects
type of xxxfb_fix variable to avoid modpost warnings.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/skeletonfb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index c15b6fe..842b5cd 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -84,7 +84,7 @@ struct xxx_par;
  * if we don't use modedb. If we do use modedb see xxxfb_init how to use it
  * to get a fb_var_screeninfo. Otherwise define a default var as well. 
  */
-static struct fb_fix_screeninfo xxxfb_fix __initdata = {
+static struct fb_fix_screeninfo xxxfb_fix __devinitdata = {
 	.id =		"FB's name", 
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -705,7 +705,7 @@ static int __devinit xxxfb_probe(struct 
     info->screen_base = framebuffer_virtual_memory;
     info->fbops = &xxxfb_ops;
     info->fix = xxxfb_fix; /* this will be the only time xxxfb_fix will be
-			    * used, so mark it as __initdata
+			    * used, so mark it as __devinitdata
 			    */
     info->pseudo_palette = pseudo_palette; /* The pseudopalette is an
 					    * 16-member array
@@ -900,6 +900,8 @@ static struct pci_driver xxxfb_driver = 
 	.resume =       xxxfb_resume,  /* optional but recommended */
 };
 
+MODULE_DEVICE_TABLE(pci, xxxfb_id_table);
+
 int __init xxxfb_init(void)
 {
 	/*


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
