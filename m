From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] ATI Rage 128 Pro (aty128fb) acceleration fix
Date: Mon, 19 Aug 2002 20:29:16 +0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020819162916.GA10206@vcserver.mivlgu.internal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [81.18.140.245] (helo=vcserver.mivlgu.internal)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gpP7-0004hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 09:29:21 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--WhfpMioaduB5tiZL
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have found a problem with the aty128fb framebuffer driver. I am using
kernel 2.4.18 (precisely,
ftp://ftp.altlinux.ru/pub/distributions/ALTLinux/Master/2.0/SRPMS.Master/kernel24-2.4.18-alt6master.src.rpm,
uniprocessor config) with the ATI Rage 128 Pro (32M) video card. aty128fb
is loaded as a module in the startup scripts without any module options,
then it is configured by fbset (though the problem is visible even in the
default 640x480 mode).

In this configuration sometimes there is garbage on the screen (parts of
characters, usually in place of spaces). The effect is visible in mutt
(when sorting by threads and there are many long threads) and in aptitude
(pull down the menu and press Left and Right to move between different
submenus).

I looked into aty128fb.c and found two possible problems:

1. The driver does not wrap display_switch.{clear,revc} in all color
depths, therefore some video memory access might be overlapping with the
accelerator.

2. The accelerated bmove function always uses left-to-right and
top-to-bottom direction, without checking the actual direction of move.
When doing overlapped copies, this causes corruption. (The "insert
characters" control code, which causes part of the line to be shifted
right, triggers the problem.)

I have made a patch against the driver sources included in
kernel24-2.4.18-alt6master to fix the problems. (The patch also applies
cleanly to the latest 2.4.x aty128fb as seen at
http://ppc.bkbits.net:8080/linux_2_4/anno/drivers/video/aty128fb.c@1.9?nav=index.html|src/.|src/drivers|src/drivers/video).

On my system, with the Rage128 Pro card, the fixed driver looks stable. 

Note about the patch: the first two hunks fix aty128_rectcopy() (problem
#2), the rest add wrappers for *_clear and *_revc (problem #1).

-- 
Sergey Vlasov

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0000992-linux-2.4.18-aty128fb_fix.patch"

--- linux/drivers/video/aty128fb.c.aty128fb_fix	Sat Jun  1 14:51:15 2002
+++ linux/drivers/video/aty128fb.c	Sun Jun  2 11:11:03 2002
@@ -2599,6 +2599,15 @@
         return;
     }
 
+    if (srcx < dstx) {
+	srcx += width - 1;
+	dstx += width - 1;
+    }
+    if (srcy < dsty) {
+	srcy += height - 1;
+	dsty += height - 1;
+    }
+
     wait_for_fifo(2, info);
     save_dp_datatype = aty_ld_le32(DP_DATATYPE);
     save_dp_cntl     = aty_ld_le32(DP_CNTL);
@@ -2606,7 +2615,9 @@
     wait_for_fifo(6, info);
     aty_st_le32(SRC_Y_X, (srcy << 16) | srcx);
     aty_st_le32(DP_MIX, ROP3_SRCCOPY | DP_SRC_RECT);
-    aty_st_le32(DP_CNTL, DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM);
+    aty_st_le32(DP_CNTL,
+		((srcx >= dstx) ? DST_X_LEFT_TO_RIGHT : 0) |
+		((srcy >= dsty) ? DST_Y_TOP_TO_BOTTOM : 0));
     aty_st_le32(DP_DATATYPE, save_dp_datatype | dstval | SRC_DSTCOLOR);
 
     aty_st_le32(DST_Y_X, (dsty << 16) | dstx);
@@ -2641,6 +2652,18 @@
 
 
 #ifdef FBCON_HAS_CFB8
+static void fbcon_aty8_clear(struct vc_data *conp, struct display *p,
+			     int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb8_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty8_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2666,6 +2689,17 @@
 }
 
 
+static void fbcon_aty8_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb8_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty8_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2680,15 +2714,27 @@
 static struct display_switch fbcon_aty128_8 = {
     setup:		fbcon_cfb8_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb8_clear,
+    clear:		fbcon_aty8_clear,
     putc:		fbcon_aty8_putc,
     putcs:		fbcon_aty8_putcs,
-    revc:		fbcon_cfb8_revc,
+    revc:		fbcon_aty8_revc,
     clear_margins:	fbcon_aty8_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
+static void fbcon_aty16_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb16_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty16_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2714,6 +2760,17 @@
 }
 
 
+static void fbcon_aty16_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb16_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty16_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2728,15 +2785,27 @@
 static struct display_switch fbcon_aty128_16 = {
     setup:		fbcon_cfb16_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb16_clear,
+    clear:		fbcon_aty16_clear,
     putc:		fbcon_aty16_putc,
     putcs:		fbcon_aty16_putcs,
-    revc:		fbcon_cfb16_revc,
+    revc:		fbcon_aty16_revc,
     clear_margins:	fbcon_aty16_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB24
+static void fbcon_aty24_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb24_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty24_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2762,6 +2831,17 @@
 }
 
 
+static void fbcon_aty24_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb24_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty24_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2776,15 +2856,27 @@
 static struct display_switch fbcon_aty128_24 = {
     setup:		fbcon_cfb24_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb24_clear,
+    clear:		fbcon_aty24_clear,
     putc:		fbcon_aty24_putc,
     putcs:		fbcon_aty24_putcs,
-    revc:		fbcon_cfb24_revc,
+    revc:		fbcon_aty24_revc,
     clear_margins:	fbcon_aty24_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
+static void fbcon_aty32_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb32_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty32_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2810,6 +2902,17 @@
 }
 
 
+static void fbcon_aty32_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb32_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty32_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2824,10 +2927,10 @@
 static struct display_switch fbcon_aty128_32 = {
     setup:		fbcon_cfb32_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb32_clear,
+    clear:		fbcon_aty32_clear,
     putc:		fbcon_aty32_putc,
     putcs:		fbcon_aty32_putcs,
-    revc:		fbcon_cfb32_revc,
+    revc:		fbcon_aty32_revc,
     clear_margins:	fbcon_aty32_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };

--gBBFr7Ir9EOA20Yy--

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9YRzcW82GfkQfsqIRAgMtAJ0RlKOA+LjTeruHXauWwIHlsGOr0QCfZF9t
PoFMyfe+qLoVpGszgr7eBgI=
=s3k9
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
