From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 3/3] fb accel capabilities (the main patch)
Date: Thu, 13 May 2004 01:50:03 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405130149210.2282@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085010321.5fd942@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO3Pf-0002jE-DP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:45:23 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BO3Pe-0003cw-W8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:45:23 -0700
In-Reply-To: <Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 00:13:46+02:00 eger@rosencrantz.theboonies.us 
#   Tell fbcon to read hints about hardware capabilities given by framebuffer devices
# 
# include/linux/fb.h
#   2004/05/13 00:13:25+02:00 eger@rosencrantz.theboonies.us +7 -2
#   fb_fix_screeninfo change - now we have accel hints to say which
#   accel functions are actually hw supported.
# 
# drivers/video/console/fbcon.h
#   2004/05/13 00:13:25+02:00 eger@rosencrantz.theboonies.us +4 -5
#   rework console accel hints to be sane
# 
# drivers/video/console/fbcon.c
#   2004/05/13 00:13:24+02:00 eger@rosencrantz.theboonies.us +18 -13
#   fix broken divides() logic
#   rework fbcon to work from accel hints given by fb's
# 
# drivers/video/aty/radeon_base.c
#   2004/05/13 00:13:24+02:00 eger@rosencrantz.theboonies.us +1 -9
#   update radeonfb for new acceleration hint semantics
# 
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Thu May 13 00:18:35 2004
+++ b/drivers/video/aty/radeon_base.c	Thu May 13 00:18:35 2004
@@ -1798,17 +1798,9 @@
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
-	if (radeon_accel_disabled())
-	        info->fix.accel = FB_ACCEL_NONE;
-	else
-		info->fix.accel = FB_ACCEL_ATI_RADEON;
+	info->fix.hwaccel = FB_HWACCEL_COPYAREA | FB_HWACCEL_FILLRECT;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	if (radeon_accel_disabled())
-		info->var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
-		info->var.accel_flags |= FB_ACCELF_TEXT;
 
         return 0;
 }
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Thu May 13 00:18:35 2004
+++ b/drivers/video/console/fbcon.c	Thu May 13 00:18:35 2004
@@ -140,7 +140,7 @@
 
 static int vbl_cursor_cnt;
 
-#define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
+#define divides(a, b)	((a && (b)%(a)) ? 0 : 1)
 
 /*
  *  Interface used by the world
@@ -607,8 +607,10 @@
 	/* on which frame buffer will we open this console? */
 	info = registered_fb[(int) con2fb_map[unit]];
 	
-	if (info->var.accel_flags)
-		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
+	if (info->fix.hwaccel & FB_HWACCEL_COPYAREA)
+		fb_display[unit].scrollmode = SCROLL_YACCEL;
+	else if (info->var.accel_flags)
+		fb_display[unit].scrollmode = SCROLL_YPANWRAP;
 	else
 		fb_display[unit].scrollmode = SCROLL_YREDRAW;
 	fbcon_set_display(vc, init, !init);
@@ -624,20 +626,23 @@
 static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-
 	int m;
-	if (p->scrollmode & __SCROLL_YFIXED)
-		return;
+
+	switch (p->scrollmode & __SCROLL_YMASK) {
+		case __SCROLL_YACCEL:
+		case __SCROLL_YREDRAW:
+			return;
+	}
+
+	/* assume we should do wrap/pan if we can */
 	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
-	    divides(vc->vc_font.height, info->var.yres_virtual))
+		divides(vc->vc_font.height, info->var.yres_virtual))
 		m = __SCROLL_YWRAP;
 	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
 		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
 		m = __SCROLL_YPAN;
-	else if (p->scrollmode & __SCROLL_YNOMOVE)
+	else 
 		m = __SCROLL_YREDRAW;
-	else
-		m = __SCROLL_YMOVE;
 	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
 }
 
@@ -1364,7 +1369,7 @@
 		if (logo_shown >= 0)
 			goto redraw_up;
 		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		case __SCROLL_YACCEL:
 			accel_bmove(vc, info, t + count, 0, t, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, b - count, 0, count,
@@ -1431,7 +1436,7 @@
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
 		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		case __SCROLL_YACCEL:
 			accel_bmove(vc, info, t, 0, t + count, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, t, 0, count, vc->vc_cols);
iff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	Thu May 13 00:18:35 2004
+++ b/drivers/video/console/fbcon.h	Thu May 13 00:18:35 2004
@@ -71,11 +71,9 @@
 /* Internal flags */
 #define __SCROLL_YPAN		0x001
 #define __SCROLL_YWRAP		0x002
-#define __SCROLL_YMOVE		0x003
+#define __SCROLL_YACCEL		0x003
 #define __SCROLL_YREDRAW	0x004
 #define __SCROLL_YMASK		0x00f
-#define __SCROLL_YFIXED		0x010
-#define __SCROLL_YNOMOVE	0x020
 #define __SCROLL_YPANREDRAW	0x040
 #define __SCROLL_YNOPARTIAL	0x080
 
@@ -92,8 +90,9 @@
    with every line covering all screen columns, it would not be the right
    benchmark).
  */
-#define SCROLL_YREDRAW		(__SCROLL_YFIXED|__SCROLL_YREDRAW)
-#define SCROLL_YNOMOVE		(__SCROLL_YNOMOVE|__SCROLL_YPANREDRAW)
+#define SCROLL_YACCEL      (__SCROLL_YACCEL)
+#define SCROLL_YPANWRAP		(__SCROLL_YPANREDRAW)
+#define SCROLL_YREDRAW		(__SCROLL_YREDRAW)
 
 /* SCROLL_YNOPARTIAL, used in combination with the above, is for video
    cards which can not handle using panning to scroll a portion of the
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Thu May 13 00:18:35 2004
+++ b/include/linux/fb.h	Thu May 13 00:18:35 2004
@@ -109,6 +109,9 @@
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
 
+#define FB_HWACCEL_COPYAREA	0x0001
+#define FB_HWACCEL_FILLRECT	0x0002
+#define FB_HWACCEL_ROTATE	0x0004
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
@@ -125,8 +128,10 @@
 	unsigned long mmio_start;	/* Start of Memory Mapped I/O   */
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
-	__u32 accel;			/* Type of acceleration available */
-	__u16 reserved[3];		/* Reserved for future compatibility */
+	__u32 accel;			/* Indicate to driver which 	*/
+					/*  specific chip/card we have	*/
+	__u16 hwaccel;			/* Which accel ops are hw-supported? */
+	__u16 reserved[2];		/* Reserved for future compatibility */
 };
 
 /* Interpretation of offset for color fields: All offsets are from the right,


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
