From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: Add option to disable hardware cursor.
Date: Thu, 17 Jun 2004 12:41:56 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617094156.GA28687@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BatPF-0000rk-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:42:01 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BatPE-0003Ih-MS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:42:00 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 71D5A405E1
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 12:41:57 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The hardware cursor code in atyfb didn't work for me so I added this=20
swcursor option to disable it. The fbops->fb_cursor change good even=20
without the option since aty_init_cursor() is only called for chips with=20
integrated RAMDAC.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-swcursor.patch"

diff -urN linux-orig/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux-orig/drivers/video/aty/atyfb.h	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/atyfb.h	2004-06-17 11:22:15.140210168 +0300
@@ -297,7 +297,6 @@
      */
 
 extern int aty_init_cursor(struct fb_info *info);
-extern int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
     /*
      *  Hardware acceleration
diff -urN linux-orig/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-orig/drivers/video/aty/atyfb_base.c	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-06-17 11:24:48.971824208 +0300
@@ -255,7 +255,7 @@
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
-	.fb_cursor	= atyfb_cursor,
+	.fb_cursor	= soft_cursor, /* changed in aty_init_cursor() */
 #ifdef __sparc__
 	.fb_mmap	= atyfb_mmap,
 #endif
@@ -263,6 +263,7 @@
 };
 
 static char noaccel __initdata = 0;
+static char swcursor __initdata = 0;
 static u32 default_vram __initdata = 0;
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
@@ -2353,7 +2354,7 @@
 #endif
 
 #ifdef CONFIG_FB_ATY_CT
-	if (M64_HAS(INTEGRATED))
+	if (!swcursor && M64_HAS(INTEGRATED))
 		aty_init_cursor(info);
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
@@ -2379,9 +2380,11 @@
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "noaccel", 7)) {
+		if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
-		} else if (!strncmp(this_opt, "vram:", 5))
+		else if (!strncmp(this_opt, "swcursor", 8))
+			swcursor = 1;
+		else if (!strncmp(this_opt, "vram:", 5))
 			default_vram =
 			    simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
diff -urN linux-orig/drivers/video/aty/mach64_cursor.c linux/drivers/video/aty/mach64_cursor.c
--- linux-orig/drivers/video/aty/mach64_cursor.c	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/mach64_cursor.c	2004-06-17 11:22:37.324837592 +0300
@@ -71,7 +71,7 @@
 	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
 };		
 
-void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned int width)
+static void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned int width)
 {
 	int i, j, offset = info->sprite.scan_align - width*2;
 	u8 *mask = info->cursor.mask, m, b;
@@ -91,7 +91,7 @@
 	}
 }
 
-int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u16 xoff, yoff;
@@ -214,6 +214,9 @@
 	info->sprite.buf_align = 16; 	// *64;	// and 64 lines tall.
 	info->sprite.flags = FB_PIXMAP_IO;
 	info->sprite.outbuf = aty_set_cursor_shape;
+
+	info->fbops->fb_cursor = atyfb_cursor;
+
 	return 0;
 }
 

--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
