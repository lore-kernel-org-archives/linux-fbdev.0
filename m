From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/22] pm3fb: hardware cursor support
Date: Mon, 13 Aug 2007 20:26:45 +0800
Message-ID: <46C04E05.5030400@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZJH-0004Nw-Mi for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:15 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZJH-0005O6-A8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:15 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:46:15 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds hardware cursor support to the pm3fb driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 0f753dd..85d1217 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -55,6 +55,7 @@ #define PM3_PIXMAP_SIZE	(2048 * 4)
 /*
  * Driver data
  */
+static int hwcursor = 1;
 static char *mode_option __devinitdata;
 static int noaccel __devinitdata;
 
@@ -604,6 +605,117 @@ static void pm3fb_imageblit(struct fb_in
 }
 /* end of acceleration functions */
 
+/*
+ *	Hardware Cursor support.
+ */
+static const u8 cursor_bits_lookup[16] = {
+	0x00, 0x40, 0x10, 0x50, 0x04, 0x44, 0x14, 0x54,
+	0x01, 0x41, 0x11, 0x51, 0x05, 0x45, 0x15, 0x55
+};
+
+static int pm3fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	struct pm3_par *par = info->par;
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
+	mode = PM3RD_CursorMode_TYPE_X;
+	if (cursor->enable)
+		 mode |= PM3RD_CursorMode_CURSOR_ENABLE;
+
+	PM3_WRITE_DAC_REG(par, PM3RD_CursorMode, mode);
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
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorXLow, x & 0xff);
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorXHigh, (x >> 8) & 0xf);
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorYLow, y & 0xff);
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorYHigh, (y >> 8) & 0xf);
+	}
+
+	if (cursor->set & FB_CUR_SETHOT) {
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorHotSpotX,
+				  cursor->hot.x & 0x3f);
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorHotSpotY,
+				  cursor->hot.y & 0x3f);
+	}
+
+	if (cursor->set & FB_CUR_SETCMAP) {
+		u32 fg_idx = cursor->image.fg_color;
+		u32 bg_idx = cursor->image.bg_color;
+		struct fb_cmap cmap = info->cmap;
+
+		/* the X11 driver says one should use these color registers */
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(39),
+				  cmap.red[fg_idx] >> 8 );
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(40),
+				  cmap.green[fg_idx] >> 8 );
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(41),
+				  cmap.blue[fg_idx] >> 8 );
+
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(42),
+				  cmap.red[bg_idx] >> 8 );
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(43),
+				  cmap.green[bg_idx] >> 8 );
+		PM3_WRITE_DAC_REG(par, PM3RD_CursorPalette(44),
+				  cmap.blue[bg_idx] >> 8 );
+	}
+
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+		u8 *bitmap = (u8 *)cursor->image.data;
+		u8 *mask = (u8 *)cursor->mask;
+		int i;
+		int pos = PM3RD_CursorPattern(0);
+
+		for (i = 0; i < cursor->image.height; i++) {
+			int j = (cursor->image.width + 7) >> 3;
+			int k = 8 - j;
+
+			for (; j > 0; j--) {
+				u8 data = *bitmap ^ *mask;
+
+				if (cursor->rop == ROP_COPY)
+					data = *mask & *bitmap;
+				/* Upper 4 bits of bitmap data */
+				PM3_WRITE_DAC_REG(par, pos++,
+					cursor_bits_lookup[data >> 4] |
+					(cursor_bits_lookup[*mask >> 4] << 1));
+				/* Lower 4 bits of bitmap */
+				PM3_WRITE_DAC_REG(par, pos++,
+					cursor_bits_lookup[data & 0xf] |
+					(cursor_bits_lookup[*mask & 0xf] << 1));
+				bitmap++;
+				mask++;
+			}
+			for (; k > 0; k--) {
+				PM3_WRITE_DAC_REG(par, pos++, 0);
+				PM3_WRITE_DAC_REG(par, pos++, 0);
+			}
+		}
+		while (pos < PM3RD_CursorPattern(1024))
+			PM3_WRITE_DAC_REG(par, pos++, 0);
+	}
+	return 0;
+}
+
 /* write the mode to registers */
 static void pm3fb_write_mode(struct fb_info *info)
 {
@@ -1105,6 +1217,7 @@ static struct fb_ops pm3fb_ops = {
 	.fb_imageblit	= pm3fb_imageblit,
 	.fb_blank	= pm3fb_blank,
 	.fb_sync	= pm3fb_sync,
+	.fb_cursor	= pm3fb_cursor,
 };
 
 /* ------------------------------------------------------------------------- */
@@ -1420,6 +1533,8 @@ static int __init pm3fb_setup(char *opti
 			continue;
 		else if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
+		else if (!strncmp(this_opt, "hwcursor=", 9))
+			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
 #ifdef CONFIG_MTRR
 		else if (!strncmp(this_opt, "nomtrr", 6))
 			nomtrr = 1;
@@ -1459,6 +1574,9 @@ module_init(pm3fb_init);
 
 module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "Disable acceleration");
+module_param(hwcursor, int, 0644);
+MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
+			"(1=enable, 0=disable, default=1)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
