From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/13] au1100fb: Add option to
	enable/disable the cursor
Date: Tue, 01 Aug 2006 07:26:08 +0800
Message-ID: <44CE9190.4020202@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOG-000387-OF for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:41 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOG-0002fQ-5c
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:40 -0700
Received: by ug-out-1314.google.com with SMTP id s2so1007827uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:38 -0700 (PDT)
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

From: Rodolfo Giometti <giometti@linux.it>

- add cursor enable/disable, very useful if you wish a
full screen boot logo.

Cursor can be disabled from kernel command line:

   video=au1100fb:nocursor,panel:Toppoly_TD035STED4

or from sysfs interface:

   echo 1 > /sys/module/au1100fb/parameters/nocursor

- fix up some wrong indentation issues.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 26086bf..ef221cc 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -8,6 +8,7 @@
  *  	<c.pellegrin@exadron.com>
  *
  * PM support added by Rodolfo Giometti <giometti@linux.it>
+ * Cursor enable/disable by Rodolfo Giometti <giometti@linux.it>
  *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
@@ -110,6 +111,10 @@ static struct fb_var_screeninfo au1100fb
 
 static struct au1100fb_drv_info drv_info;
 
+static int nocursor = 0;
+module_param(nocursor, int, 0644);
+MODULE_PARM_DESC(nocursor, "cursor enable/disable");
+
 /*
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
@@ -425,6 +430,17 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 	return 0;
 }
 
+/* fb_cursor
+ * Used to disable cursor drawing...
+ */
+int au1100fb_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	if (nocursor)
+		return 0;
+	else
+		return -EINVAL;	/* just to force soft_cursor() call */
+}
+
 static struct fb_ops au1100fb_ops =
 {
 	.owner			= THIS_MODULE,
@@ -436,6 +452,7 @@ static struct fb_ops au1100fb_ops =
 	.fb_imageblit		= cfb_imageblit,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
+	.fb_cursor		= au1100fb_fb_cursor,
 };
 
 
@@ -680,7 +697,7 @@ int au1100fb_setup(char *options)
 	if (options) {
 		while ((this_opt = strsep(&options,",")) != NULL) {
 			/* Panel option */
-		if (!strncmp(this_opt, "panel:", 6)) {
+			if (!strncmp(this_opt, "panel:", 6)) {
 				int i;
 				this_opt += 6;
 				for (i = 0; i < num_panels; i++) {
@@ -688,13 +705,18 @@ int au1100fb_setup(char *options)
 					      	     known_lcd_panels[i].name,
 							strlen(this_opt))) {
 						panel_idx = i;
-					break;
+						break;
+					}
 				}
-			}
 				if (i >= num_panels) {
  					print_warn("Panel %s not supported!", this_opt);
 				}
 			}
+			if (!strncmp(this_opt, "nocursor", 8)) {
+				this_opt += 8;
+				nocursor = 1;
+				print_info("Cursor disabled");
+			}
 			/* Mode option (only option that start with digit) */
 			else if (isdigit(this_opt[0])) {
 				mode = kmalloc(strlen(this_opt) + 1, GFP_KERNEL);
@@ -703,7 +725,7 @@ int au1100fb_setup(char *options)
 			/* Unsupported option */
 			else {
 				print_warn("Unsupported option \"%s\"", this_opt);
-		}
+			}
 		}
 	}
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
