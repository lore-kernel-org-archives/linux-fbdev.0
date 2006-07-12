From: Rodolfo Giometti <giometti@linux.it>
Subject: [PATCH] au1100fb.c cursor enable/disable
Date: Wed, 12 Jul 2006 08:45:19 +0200
Message-ID: <20060712064519.GA17240@gundam.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0eTv-0004nq-Ox for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 06:10:24 -0700
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]
	helo=gundam.enneenne.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0eTu-0007Sn-Sg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 06:10:23 -0700
Content-Disposition: inline
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
To: linux-mips@linux-mips.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to add cursor enable/disable, very useful if you wish a
full screen boot logo.

Cursor can be disabled from kernel command line:

   video=au1100fb:nocursor,panel:Toppoly_TD035STED4

or from sysfs interface:

   echo 1 > /sys/module/au1100fb/parameters/nocursor

The patch also fixes up some wrong indentation issues.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-nocursor

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index e0b71fe..1b9ad17 100644
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
@@ -114,6 +115,10 @@ static struct fb_var_screeninfo au1100fb
 
 static struct au1100fb_drv_info drv_info;
 
+static int nocursor = 0;
+module_param(nocursor, int, 0644);
+MODULE_PARM_DESC(nocursor, "cursor enable/disable");
+
 int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi);
 
 /*
@@ -440,6 +445,17 @@ int au1100fb_fb_mmap(struct fb_info *fbi
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
@@ -451,6 +467,7 @@ static struct fb_ops au1100fb_ops =
 	.fb_imageblit		= cfb_imageblit,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
+	.fb_cursor		= au1100fb_fb_cursor,
 };
 
 
@@ -705,7 +722,7 @@ int au1100fb_setup(char *options)
 	if (options) {
 		while ((this_opt = strsep(&options,",")) != NULL) {
 			/* Panel option */
-		if (!strncmp(this_opt, "panel:", 6)) {
+			if (!strncmp(this_opt, "panel:", 6)) {
 				int i;
 				this_opt += 6;
 				for (i = 0; i < num_panels; i++) {
@@ -713,13 +730,18 @@ int au1100fb_setup(char *options)
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
@@ -728,7 +750,7 @@ int au1100fb_setup(char *options)
 			/* Unsupported option */
 			else {
 				print_warn("Unsupported option \"%s\"", this_opt);
-		}
+			}
 		}
 	}
 

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--FL5UXtIhxfXey3p5--
