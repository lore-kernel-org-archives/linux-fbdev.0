From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 35/41] s3fb: Driver fixes
Date: Wed, 25 Apr 2007 15:15:33 +0800
Message-ID: <462F0015.3030300@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcD5-0001gP-Ds for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:46:43 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcD5-0004lH-39
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:46:43 -0700
Received: by py-out-1112.google.com with SMTP id a29so117686pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:46:42 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ondrej Zajicek <santiago@crfreenet.org>

This fixes broken fbcon on Virge VX in 24 bpp mode, and contains several
other small updates.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/fb/s3fb.txt |   12 ++++++++----
 drivers/video/s3fb.c      |   21 ++++++++++-----------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/fb/s3fb.txt b/Documentation/fb/s3fb.txt
index 8a04c0d..2c97770 100644
--- a/Documentation/fb/s3fb.txt
+++ b/Documentation/fb/s3fb.txt
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
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 2a8d7d3..dfa717b 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -65,7 +65,7 @@ static const struct svga_fb_format s3fb_
 
 
 static const struct svga_pll s3_pll = {3, 129, 3, 33, 0, 3,
-	60000, 240000, 14318};
+	35000, 240000, 14318};
 
 static const int s3_memsizes[] = {4096, 0, 3072, 8192, 2048, 6144, 1024, 512};
 
@@ -331,8 +331,13 @@ static void s3_set_pixclock(struct fb_in
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
@@ -710,7 +715,7 @@ static int s3fb_setcolreg(u_int regno, u
 		break;
 	case 16:
 		if (regno >= 16)
-			return -EINVAL;
+			return 0;
 
 		if (fb->var.green.length == 5)
 			((u32*)fb->pseudo_palette)[regno] = ((red & 0xF800) >> 1) |
@@ -723,9 +728,9 @@ static int s3fb_setcolreg(u_int regno, u
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
@@ -778,12 +783,6 @@ static int s3fb_pan_display(struct fb_va
 
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


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
