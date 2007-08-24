From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: panning and hardware cursor fixes
Date: Fri, 24 Aug 2007 22:26:13 +0200
Message-ID: <20070824222613.40e46213.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOfeJ-0006C9-UW for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 13:20:56 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOfeH-0004Hg-An
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 13:20:55 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	24 Aug 2007 22:20:44 +0200
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch:
- disallows setting of virtual height above 2048 as it does
  not work for accelerated copyarea and imageblit
- fixes blinking of pm2v cursor by pushing cursor outside 
  the display (x=2047)
- fixes hardware cursor position on Permedia 2 chips with
  panning enabled
- enables hardware cursor by default

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The panning and virtual height above 2047 produces artifacts on the screen.
It is the same problem as was solved in the tdfxfb driver.


diff -urp linux-2.6.23.ref/drivers/video/pm2fb.c linux-2.6.23/drivers/video/pm2fb.c
--- linux-2.6.23.ref/drivers/video/pm2fb.c	2007-08-24 17:32:03.511731927 +0200
+++ linux-2.6.23/drivers/video/pm2fb.c	2007-08-24 22:12:54.680754027 +0200
@@ -66,7 +66,7 @@
 /*
  * Driver data
  */
-static int hwcursor;
+static int hwcursor = 1;
 static char *mode __devinitdata;
 
 /*
@@ -587,6 +587,11 @@ static int pm2fb_check_var(struct fb_var
 		return -EINVAL;
 	}
 
+	/* permedia cannot blit over 2048 */
+	if (var->yres_virtual > 2047) {
+		var->yres_virtual = 2047;
+	}
+
 	if (var->xoffset) {
 		DPRINTK("xoffset not supported\n");
 		return -EINVAL;
@@ -1258,12 +1263,21 @@ static int pm2vfb_cursor(struct fb_info 
 {
 	struct pm2fb_par *par = info->par;
 	u8 mode = PM2F_CURSORMODE_TYPE_X;
+	int x = cursor->image.dx - info->var.xoffset;
+	int y = cursor->image.dy - info->var.yoffset;
 
 	if (cursor->enable)
 		mode |= PM2F_CURSORMODE_CURSOR_ENABLE;
 
 	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_MODE, mode);
 
+	if (!cursor->enable)
+		x = 2047;	/* push it outside display */
+	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_LOW, x & 0xff);
+	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_HIGH, (x >> 8) & 0xf);
+	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_LOW, y & 0xff);
+	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_HIGH, (y >> 8) & 0xf);
+
 	/*
 	 * If the cursor is not be changed this means either we want the
 	 * current cursor state (if enable is set) or we want to query what
@@ -1272,16 +1286,6 @@ static int pm2vfb_cursor(struct fb_info 
 	if (!cursor->set)
 		return 0;
 
-	if (cursor->set & FB_CUR_SETPOS) {
-		int x = cursor->image.dx - info->var.xoffset;
-		int y = cursor->image.dy - info->var.yoffset;
-
-		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_LOW, x & 0xff);
-		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_HIGH, (x >> 8) & 0xf);
-		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_LOW, y & 0xff);
-		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_HIGH, (y >> 8) & 0xf);
-	}
-
 	if (cursor->set & FB_CUR_SETHOT) {
 		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_HOT,
 			     cursor->hot.x & 0x3f);
@@ -1373,7 +1377,7 @@ static int pm2fb_cursor(struct fb_info *
 	if (par->type == PM2_TYPE_PERMEDIA2V)
 		return pm2vfb_cursor(info, cursor);
 
-	mode = 0;
+	mode = 0x40;
 	if (cursor->enable)
 		 mode = 0x43;
 
@@ -1388,10 +1392,9 @@ static int pm2fb_cursor(struct fb_info *
 		return 0;
 
 	if (cursor->set & FB_CUR_SETPOS) {
-		int x, y;
+		int x = cursor->image.dx - info->var.xoffset + 63;
+		int y = cursor->image.dy - info->var.yoffset + 63;
 
-		x = cursor->image.dx + 63;
-		y = cursor->image.dy + 63;
 		WAIT_FIFO(par, 4);
 		pm2_WR(par, PM2R_RD_CURSOR_X_LSB, x & 0xff);
 		pm2_WR(par, PM2R_RD_CURSOR_X_MSB, (x >> 8) & 0x7);
@@ -1838,7 +1841,7 @@ module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "Disable acceleration");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
-			"(1=enable, 0=disable, default=0)");
+			"(1=enable, 0=disable, default=1)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
