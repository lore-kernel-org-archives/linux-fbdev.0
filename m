From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] C99 initializers for drivers/video
Date: Mon, 25 Nov 2002 15:30:59 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021125213059.GF22546@debian>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from covert.black-ring.iadfw.net ([209.196.123.142] helo=covert.brown-ring.iadfw.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GRxs-0000IM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 14:44:28 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>, linux-fbdev-devel@lists.sourceforge.net

Hi.

Here's a set of patches switching drivers/video to use C99 initializers.
The patches are against 2.5.49.

Art Haas

--- linux-2.5.49/drivers/video/aty128fb.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/aty128fb.c	2002-11-22 19:56:35.000000000 -0600
@@ -2397,14 +2397,14 @@
 }
 
 static struct display_switch fbcon_aty128_8 = {
-    setup:		fbcon_cfb8_setup,
-    bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb8_clear,
-    putc:		fbcon_aty8_putc,
-    putcs:		fbcon_aty8_putcs,
-    revc:		fbcon_cfb8_revc,
-    clear_margins:	fbcon_aty8_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb8_setup,
+    .bmove		= fbcon_aty128_bmove,
+    .clear		= fbcon_cfb8_clear,
+    .putc		= fbcon_aty8_putc,
+    .putcs		= fbcon_aty8_putcs,
+    .revc		= fbcon_cfb8_revc,
+    .clear_margins	= fbcon_aty8_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
@@ -2445,14 +2445,14 @@
 }
 
 static struct display_switch fbcon_aty128_16 = {
-    setup:		fbcon_cfb16_setup,
-    bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb16_clear,
-    putc:		fbcon_aty16_putc,
-    putcs:		fbcon_aty16_putcs,
-    revc:		fbcon_cfb16_revc,
-    clear_margins:	fbcon_aty16_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb16_setup,
+    .bmove		= fbcon_aty128_bmove,
+    .clear		= fbcon_cfb16_clear,
+    .putc		= fbcon_aty16_putc,
+    .putcs		= fbcon_aty16_putcs,
+    .revc		= fbcon_cfb16_revc,
+    .clear_margins	= fbcon_aty16_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB24
@@ -2493,14 +2493,14 @@
 }
 
 static struct display_switch fbcon_aty128_24 = {
-    setup:		fbcon_cfb24_setup,
-    bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb24_clear,
-    putc:		fbcon_aty24_putc,
-    putcs:		fbcon_aty24_putcs,
-    revc:		fbcon_cfb24_revc,
-    clear_margins:	fbcon_aty24_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb24_setup,
+    .bmove		= fbcon_aty128_bmove,
+    .clear		= fbcon_cfb24_clear,
+    .putc		= fbcon_aty24_putc,
+    .putcs		= fbcon_aty24_putcs,
+    .revc		= fbcon_cfb24_revc,
+    .clear_margins	= fbcon_aty24_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
@@ -2541,14 +2541,14 @@
 }
 
 static struct display_switch fbcon_aty128_32 = {
-    setup:		fbcon_cfb32_setup,
-    bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb32_clear,
-    putc:		fbcon_aty32_putc,
-    putcs:		fbcon_aty32_putcs,
-    revc:		fbcon_cfb32_revc,
-    clear_margins:	fbcon_aty32_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb32_setup,
+    .bmove		= fbcon_aty128_bmove,
+    .clear		= fbcon_cfb32_clear,
+    .putc		= fbcon_aty32_putc,
+    .putcs		= fbcon_aty32_putcs,
+    .revc		= fbcon_cfb32_revc,
+    .clear_margins	= fbcon_aty32_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 
--- linux-2.5.49/drivers/video/controlfb.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/controlfb.c	2002-11-22 19:56:20.000000000 -0600
@@ -1264,25 +1264,25 @@
 }
 
 static struct display_switch control_cfb16 = {
-    setup:		fbcon_cfb16_setup,
-    bmove:		fbcon_cfb16_bmove,
-    clear:		fbcon_cfb16_clear,
-    putc:		fbcon_cfb16_putc,
-    putcs:		fbcon_cfb16_putcs,
-    revc:		control_cfb16_revc,
-    clear_margins:	fbcon_cfb16_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb16_setup,
+    .bmove		= fbcon_cfb16_bmove,
+    .clear		= fbcon_cfb16_clear,
+    .putc		= fbcon_cfb16_putc,
+    .putcs		= fbcon_cfb16_putcs,
+    .revc		= control_cfb16_revc,
+    .clear_margins	= fbcon_cfb16_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 static struct display_switch control_cfb32 = {
-    setup:		fbcon_cfb32_setup,
-    bmove:		fbcon_cfb32_bmove,
-    clear:		fbcon_cfb32_clear,
-    putc:		fbcon_cfb32_putc,
-    putcs:		fbcon_cfb32_putcs,
-    revc:		control_cfb32_revc,
-    clear_margins:	fbcon_cfb32_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb32_setup,
+    .bmove		= fbcon_cfb32_bmove,
+    .clear		= fbcon_cfb32_clear,
+    .putc		= fbcon_cfb32_putc,
+    .putcs		= fbcon_cfb32_putcs,
+    .revc		= control_cfb32_revc,
+    .clear_margins	= fbcon_cfb32_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-afb.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-afb.c	2002-11-22 19:56:18.000000000 -0600
@@ -412,13 +412,13 @@
      */
 
 struct display_switch fbcon_afb = {
-    setup:		fbcon_afb_setup,
-    bmove:		fbcon_afb_bmove,
-    clear:		fbcon_afb_clear,
-    putc:		fbcon_afb_putc,
-    putcs:		fbcon_afb_putcs,
-    revc:		fbcon_afb_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_afb_setup,
+    .bmove		= fbcon_afb_bmove,
+    .clear		= fbcon_afb_clear,
+    .putc		= fbcon_afb_putc,
+    .putcs		= fbcon_afb_putcs,
+    .revc		= fbcon_afb_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb16.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb16.c	2002-11-23 10:00:17.000000000 -0600
@@ -281,14 +281,14 @@
      */
 
 struct display_switch fbcon_cfb16 = {
-    setup:		fbcon_cfb16_setup,
-    bmove:		fbcon_cfb16_bmove,
-    clear:		fbcon_cfb16_clear,
-    putc:		fbcon_cfb16_putc,
-    putcs:		fbcon_cfb16_putcs,
-    revc:		fbcon_cfb16_revc,
-    clear_margins:	fbcon_cfb16_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb16_setup,
+    .bmove		= fbcon_cfb16_bmove,
+    .clear		= fbcon_cfb16_clear,
+    .putc		= fbcon_cfb16_putc,
+    .putcs		= fbcon_cfb16_putcs,
+    .revc		= fbcon_cfb16_revc,
+    .clear_margins	= fbcon_cfb16_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb2.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb2.c	2002-11-23 10:00:54.000000000 -0600
@@ -189,13 +189,13 @@
      */
 
 struct display_switch fbcon_cfb2 = {
-    setup:		fbcon_cfb2_setup,
-    bmove:		fbcon_cfb2_bmove,
-    clear:		fbcon_cfb2_clear,
-    putc:		fbcon_cfb2_putc,
-    putcs:		fbcon_cfb2_putcs,
-    revc:		fbcon_cfb2_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_cfb2_setup,
+    .bmove		= fbcon_cfb2_bmove,
+    .clear		= fbcon_cfb2_clear,
+    .putc		= fbcon_cfb2_putc,
+    .putcs		= fbcon_cfb2_putcs,
+    .revc		= fbcon_cfb2_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb24.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb24.c	2002-11-22 19:56:23.000000000 -0600
@@ -295,14 +295,14 @@
      */
 
 struct display_switch fbcon_cfb24 = {
-    setup:		fbcon_cfb24_setup,
-    bmove:		fbcon_cfb24_bmove,
-    clear:		fbcon_cfb24_clear,
-    putc:		fbcon_cfb24_putc,
-    putcs:		fbcon_cfb24_putcs,
-    revc:		fbcon_cfb24_revc,
-    clear_margins:	fbcon_cfb24_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb24_setup,
+    .bmove		= fbcon_cfb24_bmove,
+    .clear		= fbcon_cfb24_clear,
+    .putc		= fbcon_cfb24_putc,
+    .putcs		= fbcon_cfb24_putcs,
+    .revc		= fbcon_cfb24_revc,
+    .clear_margins	= fbcon_cfb24_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb32.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb32.c	2002-11-22 19:56:20.000000000 -0600
@@ -267,14 +267,14 @@
      */
 
 struct display_switch fbcon_cfb32 = {
-    setup:		fbcon_cfb32_setup,
-    bmove:		fbcon_cfb32_bmove,
-    clear:		fbcon_cfb32_clear,
-    putc:		fbcon_cfb32_putc,
-    putcs:		fbcon_cfb32_putcs,
-    revc:		fbcon_cfb32_revc,
-    clear_margins:	fbcon_cfb32_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb32_setup,
+    .bmove		= fbcon_cfb32_bmove,
+    .clear		= fbcon_cfb32_clear,
+    .putc		= fbcon_cfb32_putc,
+    .putcs		= fbcon_cfb32_putcs,
+    .revc		= fbcon_cfb32_revc,
+    .clear_margins	= fbcon_cfb32_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb4.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb4.c	2002-11-23 10:01:12.000000000 -0600
@@ -193,13 +193,13 @@
      */
 
 struct display_switch fbcon_cfb4 = {
-    setup:		fbcon_cfb4_setup,
-    bmove:		fbcon_cfb4_bmove,
-    clear:		fbcon_cfb4_clear,
-    putc:		fbcon_cfb4_putc,
-    putcs:		fbcon_cfb4_putcs,
-    revc:		fbcon_cfb4_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_cfb4_setup,
+    .bmove		= fbcon_cfb4_bmove,
+    .clear		= fbcon_cfb4_clear,
+    .putc		= fbcon_cfb4_putc,
+    .putcs		= fbcon_cfb4_putcs,
+    .revc		= fbcon_cfb4_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-cfb8.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-cfb8.c	2002-11-23 10:01:44.000000000 -0600
@@ -256,14 +256,14 @@
      */
 
 struct display_switch fbcon_cfb8 = {
-    setup:		fbcon_cfb8_setup,
-    bmove:		fbcon_cfb8_bmove,
-    clear:		fbcon_cfb8_clear,
-    putc:		fbcon_cfb8_putc,
-    putcs:		fbcon_cfb8_putcs,
-    revc:		fbcon_cfb8_revc,
-    clear_margins:	fbcon_cfb8_clear_margins,
-    fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+    .setup		= fbcon_cfb8_setup,
+    .bmove		= fbcon_cfb8_bmove,
+    .clear		= fbcon_cfb8_clear,
+    .putc		= fbcon_cfb8_putc,
+    .putcs		= fbcon_cfb8_putcs,
+    .revc		= fbcon_cfb8_revc,
+    .clear_margins	= fbcon_cfb8_clear_margins,
+    .fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-ilbm.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-ilbm.c	2002-11-22 19:56:28.000000000 -0600
@@ -260,13 +260,13 @@
      */
 
 struct display_switch fbcon_ilbm = {
-    setup:		fbcon_ilbm_setup,
-    bmove:		fbcon_ilbm_bmove,
-    clear:		fbcon_ilbm_clear,
-    putc:		fbcon_ilbm_putc,
-    putcs:		fbcon_ilbm_putcs,
-    revc:		fbcon_ilbm_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_ilbm_setup,
+    .bmove		= fbcon_ilbm_bmove,
+    .clear		= fbcon_ilbm_clear,
+    .putc		= fbcon_ilbm_putc,
+    .putcs		= fbcon_ilbm_putcs,
+    .revc		= fbcon_ilbm_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-iplan2p2.c.old	2002-07-05 18:42:32.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-iplan2p2.c	2002-11-22 19:56:45.000000000 -0600
@@ -438,14 +438,14 @@
      */
 
 struct display_switch fbcon_iplan2p2 = {
-    setup:		fbcon_iplan2p2_setup,
-    bmove:		fbcon_iplan2p2_bmove,
-    clear:		fbcon_iplan2p2_clear,
-    putc:		fbcon_iplan2p2_putc,
-    putcs:		fbcon_iplan2p2_putcs,
-    revc:		fbcon_iplan2p2_revc,
-    clear_margins:	fbcon_iplan2p2_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_iplan2p2_setup,
+    .bmove		= fbcon_iplan2p2_bmove,
+    .clear		= fbcon_iplan2p2_clear,
+    .putc		= fbcon_iplan2p2_putc,
+    .putcs		= fbcon_iplan2p2_putcs,
+    .revc		= fbcon_iplan2p2_revc,
+    .clear_margins	= fbcon_iplan2p2_clear_margins,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-iplan2p4.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-iplan2p4.c	2002-11-22 19:56:25.000000000 -0600
@@ -459,14 +459,14 @@
      */
 
 struct display_switch fbcon_iplan2p4 = {
-    setup:		fbcon_iplan2p4_setup,
-    bmove:		fbcon_iplan2p4_bmove,
-    clear:		fbcon_iplan2p4_clear,
-    putc:		fbcon_iplan2p4_putc,
-    putcs:		fbcon_iplan2p4_putcs,
-    revc:		fbcon_iplan2p4_revc,
-    clear_margins:	fbcon_iplan2p4_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_iplan2p4_setup,
+    .bmove		= fbcon_iplan2p4_bmove,
+    .clear		= fbcon_iplan2p4_clear,
+    .putc		= fbcon_iplan2p4_putc,
+    .putcs		= fbcon_iplan2p4_putcs,
+    .revc		= fbcon_iplan2p4_revc,
+    .clear_margins	= fbcon_iplan2p4_clear_margins,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-iplan2p8.c.old	2002-07-05 18:42:20.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-iplan2p8.c	2002-11-22 19:56:28.000000000 -0600
@@ -496,14 +496,14 @@
      */
 
 struct display_switch fbcon_iplan2p8 = {
-    setup:		fbcon_iplan2p8_setup,
-    bmove:		fbcon_iplan2p8_bmove,
-    clear:		fbcon_iplan2p8_clear,
-    putc:		fbcon_iplan2p8_putc,
-    putcs:		fbcon_iplan2p8_putcs,
-    revc:		fbcon_iplan2p8_revc,
-    clear_margins:	fbcon_iplan2p8_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_iplan2p8_setup,
+    .bmove		= fbcon_iplan2p8_bmove,
+    .clear		= fbcon_iplan2p8_clear,
+    .putc		= fbcon_iplan2p8_putc,
+    .putcs		= fbcon_iplan2p8_putcs,
+    .revc		= fbcon_iplan2p8_revc,
+    .clear_margins	= fbcon_iplan2p8_clear_margins,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-mfb.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-mfb.c	2002-11-22 19:56:40.000000000 -0600
@@ -179,14 +179,14 @@
      */
 
 struct display_switch fbcon_mfb = {
-    setup:		fbcon_mfb_setup,
-    bmove:		fbcon_mfb_bmove,
-    clear:		fbcon_mfb_clear,
-    putc:		fbcon_mfb_putc,
-    putcs:		fbcon_mfb_putcs,
-    revc:		fbcon_mfb_revc,
-    clear_margins:	fbcon_mfb_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_mfb_setup,
+    .bmove		= fbcon_mfb_bmove,
+    .clear		= fbcon_mfb_clear,
+    .putc		= fbcon_mfb_putc,
+    .putcs		= fbcon_mfb_putcs,
+    .revc		= fbcon_mfb_revc,
+    .clear_margins	= fbcon_mfb_clear_margins,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 
--- linux-2.5.49/drivers/video/fbcon-vga-planes.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/fbcon-vga-planes.c	2002-11-22 19:56:36.000000000 -0600
@@ -329,23 +329,23 @@
 }
 
 struct display_switch fbcon_vga_planes = {
-    setup:		fbcon_vga_planes_setup,
-    bmove:		fbcon_vga_planes_bmove,
-    clear:		fbcon_vga_planes_clear,
-    putc:		fbcon_vga_planes_putc,
-    putcs:		fbcon_vga_planes_putcs,
-    revc:		fbcon_vga_planes_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_vga_planes_setup,
+    .bmove		= fbcon_vga_planes_bmove,
+    .clear		= fbcon_vga_planes_clear,
+    .putc		= fbcon_vga_planes_putc,
+    .putcs		= fbcon_vga_planes_putcs,
+    .revc		= fbcon_vga_planes_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 struct display_switch fbcon_ega_planes = {
-    setup:		fbcon_vga_planes_setup,
-    bmove:		fbcon_vga_planes_bmove,
-    clear:		fbcon_vga_planes_clear,
-    putc:		fbcon_ega_planes_putc,
-    putcs:		fbcon_ega_planes_putcs,
-    revc:		fbcon_vga_planes_revc,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_vga_planes_setup,
+    .bmove		= fbcon_vga_planes_bmove,
+    .clear		= fbcon_vga_planes_clear,
+    .putc		= fbcon_ega_planes_putc,
+    .putcs		= fbcon_ega_planes_putcs,
+    .revc		= fbcon_vga_planes_revc,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 
 #ifdef MODULE
--- linux-2.5.49/drivers/video/g364fb.c.old	2002-08-27 19:11:02.000000000 -0500
+++ linux-2.5.49/drivers/video/g364fb.c	2002-11-23 10:03:25.000000000 -0600
@@ -78,30 +78,30 @@
 static struct fb_info fb_info;
 
 static struct fb_fix_screeninfo fb_fix __initdata = {
-	.id =		"G364 8plane",
-	.smem_start =	0x40000000,	/* physical address */
-	.type =		FB_TYPE_PACKED_PIXELS,
-	.visual =	FB_VISUAL_PSEUDOCOLOR,
-	.ypanstep =	1,
-	.accel =	FB_ACCEL_NONE,
+	.id		= "G364 8plane",
+	.smem_start	= 0x40000000,	/* physical address */
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.visual		= FB_VISUAL_PSEUDOCOLOR,
+	.ypanstep	= 1,
+	.accel		= FB_ACCEL_NONE,
 };
 
 static struct fb_var_screeninfo fb_var __initdata = {
-	.bits_per_pixel =8,
-	.red =		{ 0, 8, 0 },
-      	green:		{ 0, 8, 0 },
-      	blue:		{ 0, 8, 0 },
-      	activate:FB_ACTIVATE_NOW,
-      	height:		-1,
-      	width:		-1,
-      	pixclock:39722,
-      	left_margin:	40,
-      	right_margin:	24,
-      	upper_margin:	32,
-      	lower_margin:	11,
-      	hsync_len:	96,
-      	vsync_len:	2,
-      	vmode:		FB_VMODE_NONINTERLACED,
+	.bits_per_pixel = 8,
+	.red		= { 0, 8, 0 },
+      	.green		= { 0, 8, 0 },
+      	.blue		= { 0, 8, 0 },
+      	.activate	= FB_ACTIVATE_NOW,
+      	.height		= -1,
+      	.width		= -1,
+      	.pixclock	= 39722,
+      	.left_margin	= 40,
+      	.right_margin	= 24,
+      	.upper_margin	= 32,
+      	.lower_margin	= 11,
+      	.hsync_len	= 96,
+      	.vsync_len	= 2,
+      	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
 /*
--- linux-2.5.49/drivers/video/neofb.c.old	2002-08-27 19:11:03.000000000 -0500
+++ linux-2.5.49/drivers/video/neofb.c	2002-11-22 19:56:18.000000000 -0600
@@ -1403,75 +1403,75 @@
 /* --------------------------------------------------------------------- */
 
 static struct fb_var_screeninfo __devinitdata neofb_var640x480x8 = {
-	accel_flags:	FB_ACCELF_TEXT,
-	xres:		640,
-	yres:		480,
-	xres_virtual:	640,
-	yres_virtual:	30000,
-	bits_per_pixel:	8,
-	pixclock:	39722,
-	left_margin:	48,
-	right_margin:	16,
-	upper_margin:	33,
-	lower_margin:	10,
-	hsync_len:	96,
-	vsync_len:	2,
-	vmode:		FB_VMODE_NONINTERLACED
+	.accel_flags	= FB_ACCELF_TEXT,
+	.xres		= 640,
+	.yres		= 480,
+	.xres_virtual	= 640,
+	.yres_virtual	= 30000,
+	.bits_per_pixel	= 8,
+	.pixclock	= 39722,
+	.left_margin	= 48,
+	.right_margin	= 16,
+	.upper_margin	= 33,
+	.lower_margin	= 10,
+	.hsync_len	= 96,
+	.vsync_len	= 2,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 static struct fb_var_screeninfo __devinitdata neofb_var800x600x8 = {
-	accel_flags:	FB_ACCELF_TEXT,
-	xres:		800,
-	yres:		600,
-	xres_virtual:	800,
-	yres_virtual:	30000,
-	bits_per_pixel:	8,
-	pixclock:	25000,
-	left_margin:	88,
-	right_margin:	40,
-	upper_margin:	23,
-	lower_margin:	1,
-	hsync_len:	128,
-	vsync_len:	4,
-	sync:		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	vmode:		FB_VMODE_NONINTERLACED
+	.accel_flags	= FB_ACCELF_TEXT,
+	.xres		= 800,
+	.yres		= 600,
+	.xres_virtual	= 800,
+	.yres_virtual	= 30000,
+	.bits_per_pixel	= 8,
+	.pixclock	= 25000,
+	.left_margin	= 88,
+	.right_margin	= 40,
+	.upper_margin	= 23,
+	.lower_margin	= 1,
+	.hsync_len	= 128,
+	.vsync_len	= 4,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 static struct fb_var_screeninfo __devinitdata neofb_var1024x768x8 = {
-	accel_flags:	FB_ACCELF_TEXT,
-	xres:		1024,
-	yres:		768,
-	xres_virtual:	1024,
-	yres_virtual:	30000,
-	bits_per_pixel:	8,
-	pixclock:	15385,
-	left_margin:	160,
-	right_margin:	24,
-	upper_margin:	29,
-	lower_margin:	3,
-	hsync_len:	136,
-	vsync_len:	6,
-	sync:		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	vmode:		FB_VMODE_NONINTERLACED
+	.accel_flags	= FB_ACCELF_TEXT,
+	.xres		= 1024,
+	.yres		= 768,
+	.xres_virtual	= 1024,
+	.yres_virtual	= 30000,
+	.bits_per_pixel	= 8,
+	.pixclock	= 15385,
+	.left_margin	= 160,
+	.right_margin	= 24,
+	.upper_margin	= 29,
+	.lower_margin	= 3,
+	.hsync_len	= 136,
+	.vsync_len	= 6,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 #ifdef NOT_DONE
 static struct fb_var_screeninfo __devinitdata neofb_var1280x1024x8 = {
-	accel_flags:	FB_ACCELF_TEXT,
-	xres:		1280,
-	yres:		1024,
-	xres_virtual:	1280,
-	yres_virtual:	30000,
-	bits_per_pixel:	8,
-	pixclock:	9260,
-	left_margin:	248,
-	right_margin:	48,
-	upper_margin:	38,
-	lower_margin:	1,
-	hsync_len:	112,
-	vsync_len:	3,
-	sync:		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	vmode:		FB_VMODE_NONINTERLACED
+	.accel_flags	= FB_ACCELF_TEXT,
+	.xres		= 1280,
+	.yres		= 1024,
+	.xres_virtual	= 1280,
+	.yres_virtual	= 30000,
+	.bits_per_pixel	= 8,
+	.pixclock	= 9260,
+	.left_margin	= 248,
+	.right_margin	= 48,
+	.upper_margin	= 38,
+	.lower_margin	= 1,
+	.hsync_len	= 112,
+	.vsync_len	= 3,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 #endif
 
--- linux-2.5.49/drivers/video/pm2fb.c.old	2002-08-27 19:11:03.000000000 -0500
+++ linux-2.5.49/drivers/video/pm2fb.c	2002-11-22 19:56:39.000000000 -0600
@@ -1451,7 +1451,7 @@
 	.cursor =	pm2fb_cursor,
 	.set_font =	pm2fb_set_font,
 	.clear_margins =pm2fb_clear_margins8,
-	fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16) };
+	.fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16) };
 #endif /* FBCON_HAS_CFB8 */
 
 #ifdef FBCON_HAS_CFB16
--- linux-2.5.49/drivers/video/retz3fb.c.old	2002-08-27 19:11:03.000000000 -0500
+++ linux-2.5.49/drivers/video/retz3fb.c	2002-11-22 19:56:46.000000000 -0600
@@ -1589,13 +1589,13 @@
 
 
 static struct display_switch fbcon_retz3_8 = {
-    setup:		fbcon_cfb8_setup,
-    bmove:		retz3_8_bmove,
-    clear:		retz3_8_clear,
-    putc:		retz3_putc,
-    putcs:		retz3_putcs,
-    revc:		retz3_revc,
-    clear_margins:	retz3_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+    .setup		= fbcon_cfb8_setup,
+    .bmove		= retz3_8_bmove,
+    .clear		= retz3_8_clear,
+    .putc		= retz3_putc,
+    .putcs		= retz3_putcs,
+    .revc		= retz3_revc,
+    .clear_margins	= retz3_clear_margins,
+    .fontwidthmask	= FONTWIDTH(8)
 };
 #endif
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
