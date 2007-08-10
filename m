From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: Permedia 2V hardware cursor
	support
Date: Fri, 10 Aug 2007 21:31:00 +0200
Message-ID: <20070810213100.017dd0cc.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJa8E-0006C4-Cd for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:26:49 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJa8D-0002oM-1x
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:26:45 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	10 Aug 2007 21:26:39 +0200
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

This patch adds hardware cursor support for Permedia 2V chips.
The hardware cursor is disabled by default. It does not blink - the
same issue is mentioned in the x11 driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The pm2fb_cursor function is for Permedia 2 hardware cursor support (not 2V).
I am working on it.

--- linux-2.6.22.new/drivers/video/pm2fb.c	2007-08-10 21:19:55.436496086 +0200
+++ linux-2.6.23/drivers/video/pm2fb.c	2007-08-10 21:18:00.265932891 +0200
@@ -66,6 +66,7 @@
 /*
  * Driver data
  */
+static int hwcursor;
 static char *mode __devinitdata;
 
 /*
@@ -1245,6 +1246,136 @@ static void pm2fb_imageblit(struct fb_in
 	pm2_WR(par, PM2R_SCISSOR_MODE, 0);
 }
 
+/*
+ *	Hardware cursor support.
+ */
+static const u8 cursor_bits_lookup[16] = {
+	0x00, 0x40, 0x10, 0x50, 0x04, 0x44, 0x14, 0x54,
+	0x01, 0x41, 0x11, 0x51, 0x05, 0x45, 0x15, 0x55
+};
+
+static int pm2vfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	struct pm2fb_par *par = info->par;
+	u8 mode;
+
+	if (!hwcursor)
+		return -EINVAL;	/* just to force soft_cursor() call */
+
+	/* Too large of a cursor or wrong bpp :-( */
+	if (cursor->image.width > 64 ||
+	    cursor->image.height > 64 ||
+	    cursor->image.depth > 1)
+		return -EINVAL;
+
+	mode = PM2F_CURSORMODE_TYPE_X;
+	if (cursor->enable)
+		mode |= PM2F_CURSORMODE_CURSOR_ENABLE;
+
+	pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_MODE, mode);
+
+	/*
+	 * If the cursor is not be changed this means either we want the
+	 * current cursor state (if enable is set) or we want to query what
+	 * we can do with the cursor (if enable is not set)
+	 */
+	if (!cursor->set)
+		return 0;
+
+	if (cursor->set & FB_CUR_SETPOS) {
+		int x = cursor->image.dx - info->var.xoffset;
+		int y = cursor->image.dy - info->var.yoffset;
+
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_LOW, x & 0xff);
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_HIGH, (x >> 8) & 0xf);
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_LOW, y & 0xff);
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_HIGH, (y >> 8) & 0xf);
+	}
+
+	if (cursor->set & FB_CUR_SETHOT) {
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_X_HOT,
+			     cursor->hot.x & 0x3f);
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_Y_HOT,
+			     cursor->hot.y & 0x3f);
+	}
+
+	if (cursor->set & FB_CUR_SETCMAP) {
+		u32 fg_idx = cursor->image.fg_color;
+		u32 bg_idx = cursor->image.bg_color;
+		struct fb_cmap cmap = info->cmap;
+
+		/* the X11 driver says one should use these color registers */
+		pm2_WR(par, PM2VR_RD_INDEX_HIGH, PM2VI_RD_CURSOR_PALETTE >> 8);
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 0,
+			     cmap.red[bg_idx] >> 8 );
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 1,
+			     cmap.green[bg_idx] >> 8 );
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 2,
+			     cmap.blue[bg_idx] >> 8 );
+
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 3,
+			     cmap.red[fg_idx] >> 8 );
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 4,
+			     cmap.green[fg_idx] >> 8 );
+		pm2v_RDAC_WR(par, PM2VI_RD_CURSOR_PALETTE + 5,
+			     cmap.blue[fg_idx] >> 8 );
+		pm2_WR(par, PM2VR_RD_INDEX_HIGH, 0);
+	}
+
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+		u8 *bitmap = (u8 *)cursor->image.data;
+		u8 *mask = (u8 *)cursor->mask;
+		int i;
+		int pos = PM2VI_RD_CURSOR_PATTERN;
+
+		for (i = 0; i < cursor->image.height; i++) {
+			int j = (cursor->image.width + 7) >> 3;
+			int k = 8 - j;
+
+			pm2_WR(par, PM2VR_RD_INDEX_HIGH, pos >> 8);
+
+			for (; j > 0; j--) {
+				u8 data = *bitmap ^ *mask;
+
+				if (cursor->rop == ROP_COPY)
+					data = *mask & *bitmap;
+				/* Upper 4 bits of bitmap data */
+				pm2v_RDAC_WR(par, pos++,
+					cursor_bits_lookup[data >> 4] |
+					(cursor_bits_lookup[*mask >> 4] << 1));
+				/* Lower 4 bits of bitmap */
+				pm2v_RDAC_WR(par, pos++,
+					cursor_bits_lookup[data & 0xf] |
+					(cursor_bits_lookup[*mask & 0xf] << 1));
+				bitmap++;
+				mask++;
+			}
+			for (; k > 0; k--) {
+				pm2v_RDAC_WR(par, pos++, 0);
+				pm2v_RDAC_WR(par, pos++, 0);
+			}
+		}
+
+		while (pos < (1024 + PM2VI_RD_CURSOR_PATTERN)) {
+			pm2_WR(par, PM2VR_RD_INDEX_HIGH, pos >> 8);
+			pm2v_RDAC_WR(par, pos++, 0);
+		}
+
+		pm2_WR(par, PM2VR_RD_INDEX_HIGH, 0);
+	}
+	return 0;
+}
+
+static int pm2fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	struct pm2fb_par *par = info->par;
+
+	if (par->type == PM2_TYPE_PERMEDIA2V)
+		return pm2vfb_cursor(info, cursor);
+
+	return -ENXIO;
+}
+
 /* ------------ Hardware Independent Functions ------------ */
 
 /*
@@ -1262,6 +1393,7 @@ static struct fb_ops pm2fb_ops = {
 	.fb_copyarea	= pm2fb_copyarea,
 	.fb_imageblit	= pm2fb_imageblit,
 	.fb_sync	= pm2fb_sync,
+	.fb_cursor	= pm2fb_cursor,
 };
 
 /*
@@ -1550,6 +1682,8 @@ static int __init pm2fb_setup(char *opti
 			lowhsync = 1;
 		else if (!strcmp(this_opt, "lowvsync"))
 			lowvsync = 1;
+		else if (!strncmp(this_opt, "hwcursor=", 9))
+			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
 #ifdef CONFIG_MTRR
 		else if (!strncmp(this_opt, "nomtrr", 6))
 			nomtrr = 1;
@@ -1601,6 +1735,9 @@ module_param(lowvsync, bool, 0);
 MODULE_PARM_DESC(lowvsync, "Force vertical sync low regardless of mode");
 module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "Disable acceleration");
+module_param(hwcursor, int, 0644);
+MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
+			"(1=enable, 0=disable, default=0)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
--- linux-2.6.22.new/include/video/permedia2.h	2007-08-10 21:19:43.399810154 +0200
+++ linux-2.6.23/include/video/permedia2.h	2007-08-10 21:15:31.853475347 +0200
@@ -232,6 +232,8 @@
 #define PM2F_APERTURE_STANDARD				0
 #define PM2F_APERTURE_BYTESWAP				1
 #define PM2F_APERTURE_HALFWORDSWAP			2
+#define PM2F_CURSORMODE_CURSOR_ENABLE			(1 << 0)
+#define PM2F_CURSORMODE_TYPE_X				(1 << 4)
 
 typedef enum {
 	PM2_TYPE_PERMEDIA2,

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
