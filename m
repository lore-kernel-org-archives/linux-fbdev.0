From: Alexander Kern <alex.kern@gmx.de>
Subject: Fwd: [PATCH 2.5.59] fix for fbcon.c
Date: Sun, 19 Jan 2003 19:56:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301191956.33826.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9Y5ZDSBVNUHQ0ADT6RCH"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aKcu-0006Dv-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 10:57:01 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux-fbdev-devel@lists.sourceforge.net


--------------Boundary-00=_9Y5ZDSBVNUHQ0ADT6RCH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



----------  Weitergeleitete Nachricht  ----------

Subject: [PATCH 2.5.59] fix for fbcon.c
Date: Sun, 19 Jan 2003 19:36:12 +0100
From: Alexander Kern <alex.kern@gmx.de>
To: fb-devel@lists.sourceforge.net

Hello,

hier is a fix needed by 1400x1050 resolution. fbcon_resize() without fis =
set
resolution to 1400x1040 and confusing LCD vertical stretching.

Regards
Alex

PS: I have retest both kernel versions, here is a result.

COMPAQ ARMADA E500, ATI (Mach64) Rage 3D Mobility P/M
15" with native 1400x1050 pixel

                        2.4.21-pre3                              2.5.59
640x400        perfect(LOGO)                        perfect
640x480        perfect(LOGO)                        perfect
800x600        perfect                                      perfect
1024x768      h. overlapping(LOGO)          h. overlapping
1152x864      h. overlapping                        h. overlapping
1280x1024    h. overlapping                        h. overlapping
1400x1050    perfect                                   perfect (with this
 fix)

LOGO by 640x4?0 means strange blue pixels as mirror of pinguin
LOGO by 1024x768 means shift to top, pinguin head is unvisible
h. overlapping means mostly stretching issue.

-------------------------------------------------------


--------------Boundary-00=_9Y5ZDSBVNUHQ0ADT6RCH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fbcon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fbcon.diff"

--- linux-2.5.orig/drivers/video/console/fbcon.c	2003-01-17 16:13:53.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2003-01-19 19:17:23.000000000 +0100
@@ -1876,17 +1876,23 @@
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_info *info = p->fb_info;
 	struct fb_var_screeninfo var = info->var;
-	int err;
+	int err; int x_diff, y_diff;
 
 	var.xres = width * vc->vc_font.width;
 	var.yres = height * vc->vc_font.height;
 	var.activate = FB_ACTIVATE_NOW;
-
+	x_diff = info->var.xres - var.xres;
+	y_diff = info->var.yres - var.yres;
+	if(x_diff < 0 || x_diff > vc->vc_font.width ||
+	  (y_diff < 0 || y_diff > vc->vc_font.height)) {
+		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 	err = fb_set_var(&var, info);
 	return  (err || var.xres != info->var.xres ||
-		 var.yres != info->var.yres) ?
-		-EINVAL : 0;
-	  
+			var.yres != info->var.yres) ? -EINVAL : 0;
+	} else {
+		DPRINTK("prevent resize\n");
+		return 0;
+	}
 }
 
 static int fbcon_switch(struct vc_data *vc)

--------------Boundary-00=_9Y5ZDSBVNUHQ0ADT6RCH--



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
