From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Fix for s3fb driver
Date: Fri, 20 Apr 2007 13:34:05 +0200
Message-ID: <20070420113405.GA2116@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HerNe-0005ZV-Kk for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Apr 2007 04:34:22 -0700
Received: from gateway.crfreenet.org
	([81.92.146.254] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HerNd-0001y2-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Apr 2007 04:34:22 -0700
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
To: torvalds@linux-foundation.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

This patch fixes broken fbcon on Virge VX in 24 bpp mode,
and contains several other small updates.

It is against linux-2.6.21-rc7

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

---

diff -uprN -X linux-2.6.21-rc7-base/Documentation/dontdiff linux-2.6.21-rc7-base/Documentation/fb/s3fb.txt linux-2.6.21-rc7-s3fb/Documentation/fb/s3fb.txt
--- linux-2.6.21-rc7-base/Documentation/fb/s3fb.txt	2007-04-16 01:50:57.000000000 +0200
+++ linux-2.6.21-rc7-s3fb/Documentation/fb/s3fb.txt	2007-04-20 02:52:51.000000000 +0200
@@ -35,10 +35,12 @@ Supported Features
 	* suspend/resume support
 	* DPMS support
 
-Text mode is supported even in higher resolutions, but there is limitation
-to lower pixclocks (maximum between 50-60 MHz, depending on specific hardware).
-This limitation is not enforced by driver. Text mode supports 8bit wide fonts
-only (hardware limitation) and 16bit tall fonts (driver limitation).
+Text mode is supported even in higher resolutions, but there is limitation to
+lower pixclocks (maximum usually between 50-60 MHz, depending on specific
+hardware, i get best results from plain S3 Trio32 card - about 75 MHz). This
+limitation is not enforced by driver. Text mode supports 8bit wide fonts only
+(hardware limitation) and 16bit tall fonts (driver limitation). Text mode
+support is broken on S3 Trio64 V2/DX.
 
 There are two 4 bpp modes. First mode (selected if nonstd == 0) is mode with
 packed pixels, high nibble first. Second mode (selected if nonstd == 1) is mode
@@ -73,6 +75,8 @@ Known bugs
 ==========
 
 	* cursor disable in text mode doesn't work
+	* text mode broken on S3 Trio64 V2/DX
+
 
 --
 Ondrej Zajicek <santiago@crfreenet.org>
diff -uprN -X linux-2.6.21-rc7-base/Documentation/dontdiff linux-2.6.21-rc7-base/drivers/video/s3fb.c linux-2.6.21-rc7-s3fb/drivers/video/s3fb.c
--- linux-2.6.21-rc7-base/drivers/video/s3fb.c	2007-04-16 01:50:57.000000000 +0200
+++ linux-2.6.21-rc7-s3fb/drivers/video/s3fb.c	2007-04-19 11:17:24.000000000 +0200
@@ -65,7 +65,7 @@ static const struct svga_fb_format s3fb_
 
 
 static const struct svga_pll s3_pll = {3, 129, 3, 33, 0, 3,
-	60000, 240000, 14318};
+	35000, 240000, 14318};
 
 static const int s3_memsizes[] = {4096, 0, 3072, 8192, 2048, 6144, 1024, 512};
 
@@ -326,8 +326,13 @@ static void s3_set_pixclock(struct fb_in
 {
 	u16 m, n, r;
 	u8 regval;
+	int rv;
 
-	svga_compute_pll(&s3_pll, 1000000000 / pixclock, &m, &n, &r, info->node);
+	rv = svga_compute_pll(&s3_pll, 1000000000 / pixclock, &m, &n, &r, info->node);
+	if (rv < 0) {
+		printk(KERN_ERR "fb%d: cannot set requested pixclock, keeping old value\n", info->node);
+		return;
+	}
 
 	/* Set VGA misc register  */
 	regval = vga_r(NULL, VGA_MIS_R);
@@ -699,7 +704,7 @@ static int s3fb_setcolreg(u_int regno, u
 		break;
 	case 16:
 		if (regno >= 16)
-			return -EINVAL;
+			return 0;
 
 		if (fb->var.green.length == 5)
 			((u32*)fb->pseudo_palette)[regno] = ((red & 0xF800) >> 1) |
@@ -712,9 +717,9 @@ static int s3fb_setcolreg(u_int regno, u
 	case 24:
 	case 32:
 		if (regno >= 16)
-			return -EINVAL;
+			return 0;
 
-		((u32*)fb->pseudo_palette)[regno] = ((transp & 0xFF00) << 16) | ((red & 0xFF00) << 8) |
+		((u32*)fb->pseudo_palette)[regno] = ((red & 0xFF00) << 8) |
 			(green & 0xFF00) | ((blue & 0xFF00) >> 8);
 		break;
 	default:
@@ -767,12 +772,6 @@ static int s3fb_pan_display(struct fb_va
 
 	unsigned int offset;
 
-	/* Validate the offsets */
-	if ((var->xoffset + var->xres) > var->xres_virtual)
-		return -EINVAL;
-	if ((var->yoffset + var->yres) > var->yres_virtual)
-		return -EINVAL;
-
 	/* Calculate the offset */
 	if (var->bits_per_pixel == 0) {
 		offset = (var->yoffset / 16) * (var->xres_virtual / 2) + (var->xoffset / 2);


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
