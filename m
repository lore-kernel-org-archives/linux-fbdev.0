From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 4/4] pm2fb: fix big-endian (Sparc) support
Date: Tue, 7 Dec 2004 11:50:34 +0000
Message-ID: <20041207115034.4b16ad01@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbdrg-00032R-0p
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:44 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cbdre-00017L-AP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:43 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: Ron Murray <murrayr@dor.state.ma.us>


- Big-endian fixes. The driver is now known to work on Sparc.

Signed-off-by: Jim Hague <jim.hague@acm.org>

This patch could not have happened without a lot of patient work by Ron
Murray. Thanks, Ron.

Known problems:

At 24bit big-endianness is handled by setting the hardware to BGR
instead of the usual RGB. Console colours are correct, but red/blue are
reversed when e.g. displaying images with fbi. Swapping blue/red via the
var->(red|blue).offset and leaving the hardware at RGB leaves images
correct but console red/blue reversed on the test 2.6.9 Sparc kernel.
8/16/32bit work fine.

To do:

On Sparc obtain initial mode from PROM.

=== a/include/video/permedia2.h
==================================================================
--- a/include/video/permedia2.h  (revision 107)
+++ a/include/video/permedia2.h  (revision 112)
@@ -188,6 +188,14 @@
 #define PM2F_VSYNC_ACT_LOW				0x60
 #define PM2F_LINE_DOUBLE				0x04
 #define PM2F_VIDEO_ENABLE				0x01
+#define PM2F_RD_PIXELFORMAT_SVGA			0x01
+#define PM2F_RD_PIXELFORMAT_RGB232OFFSET		0x02
+#define PM2F_RD_PIXELFORMAT_RGBA2321			0x03
+#define PM2F_RD_PIXELFORMAT_RGBA5551			0x04
+#define PM2F_RD_PIXELFORMAT_RGBA4444			0x05
+#define PM2F_RD_PIXELFORMAT_RGB565			0x06
+#define PM2F_RD_PIXELFORMAT_RGBA8888			0x08
+#define PM2F_RD_PIXELFORMAT_RGB888			0x09
 #define PM2F_RD_GUI_ACTIVE				0x10
 #define PM2F_RD_COLOR_MODE_RGB				0x20
 #define PM2F_DELTA_ORDER_RGB				(1L<<18)
@@ -209,6 +217,9 @@
 #define PM2F_MEM_BANKS_2				(1L<<29)
 #define PM2F_MEM_BANKS_3				(2L<<29)
 #define PM2F_MEM_BANKS_4				(3L<<29)
+#define PM2F_APERTURE_STANDARD				0
+#define PM2F_APERTURE_BYTESWAP				1
+#define PM2F_APERTURE_HALFWORDSWAP			2
 
 typedef enum {
 	PM2_TYPE_PERMEDIA2,
=== a/drivers/video/pm2fb.c
==================================================================
--- a/drivers/video/pm2fb.c  (revision 107)
+++ a/drivers/video/pm2fb.c  (revision 112)
@@ -11,12 +11,12 @@
  * and additional input from James Simmon's port of Hannu Mallat's tdfx
  * driver.
  *
- * $Id$
+ * I have a Creative Graphics Blaster Exxtreme card - pm2fb on x86.  I
+ * have no access to other pm2fb implementations. Sparc (and thus
+ * hopefully other big-endian) devices now work, thanks to a lot of
+ * testing work by Ron Murray. I have no access to CVision hardware,
+ * and therefore for now I am omitting the CVision code.
  *
- * I have a Creative Graphics Blaster Exxtreme card - pm2fb on x86.
- * I have no access to other pm2fb implementations, and cannot test
- * on them. Therefore for now I am omitting Sparc and CVision code.
- *
  * Multiple boards support has been on the TODO list for ages.
  * Don't expect this to change.
  *
@@ -48,10 +48,6 @@
 #error	"The endianness of the target host has not been defined."
 #endif
 
-#if defined(__BIG_ENDIAN) && !defined(__sparc__)
-#define PM2FB_BE_APERTURE
-#endif
-
 #if !defined(CONFIG_PCI)
 #error "Only generic PCI cards supported."
 #endif
@@ -424,27 +420,36 @@
 
 static void set_aperture(struct pm2fb_par* p, u32 depth)
 {
+	/*
+	 * The hardware is little-endian. When used in big-endian
+	 * hosts, the on-chip aperture settings are used where
+	 * possible to translate from host to card byte order.
+	 */
 	WAIT_FIFO(p, 4);
 #ifdef __LITTLE_ENDIAN
-	pm2_WR(p, PM2R_APERTURE_ONE, 0);
-	pm2_WR(p, PM2R_APERTURE_TWO, 0);
+	pm2_WR(p, PM2R_APERTURE_ONE, PM2F_APERTURE_STANDARD);
 #else
 	switch (depth) {
-	case 8:
-	case 24:
-		pm2_WR(p, PM2R_APERTURE_ONE, 0);
-		pm2_WR(p, PM2R_APERTURE_TWO, 1);
+	case 24:	/* RGB->BGR */
+		/*
+		 * We can't use the aperture to translate host to
+		 * card byte order here, so we switch to BGR mode
+		 * in pm2fb_set_par().
+		 */
+	case 8:		/* B->B */
+		pm2_WR(p, PM2R_APERTURE_ONE, PM2F_APERTURE_STANDARD);
 		break;
-	case 16:
-		pm2_WR(p, PM2R_APERTURE_ONE, 2);
-		pm2_WR(p, PM2R_APERTURE_TWO, 1);
+	case 16:	/* HL->LH */
+		pm2_WR(p, PM2R_APERTURE_ONE, PM2F_APERTURE_HALFWORDSWAP);
 		break;
-	case 32:
-		pm2_WR(p, PM2R_APERTURE_ONE, 1);
-		pm2_WR(p, PM2R_APERTURE_TWO, 1);
+	case 32:	/* RGBA->ABGR */
+		pm2_WR(p, PM2R_APERTURE_ONE, PM2F_APERTURE_BYTESWAP);
 		break;
 	}
 #endif
+
+	// We don't use aperture two, so this may be superflous
+	pm2_WR(p, PM2R_APERTURE_TWO, PM2F_APERTURE_STANDARD);
 }
 
 static void set_color(struct pm2fb_par* p, unsigned char regno,
@@ -638,16 +643,14 @@
 		var->blue.offset  = 0;
 		var->blue.length  = 5;
 		break;
+	case 32:
+		var->transp.offset = 24;
+		var->transp.length = 8;
 	case 24:
 		var->red.offset	  = 16;
 		var->green.offset = 8;
 		var->blue.offset  = 0;
 		var->red.length = var->green.length = var->blue.length = 8;
-	case 32:
-		var->red.offset   = 16;
-		var->green.offset = 8;
-		var->blue.offset  = 0;
-		var->red.length = var->green.length = var->blue.length = 8;
 		break;
 	}
 	var->height = var->width = -1;
@@ -676,7 +679,7 @@
 	u32 stride;
 	u32 base;
 	u32 video = 0;
-	u32 clrmode = PM2F_RD_COLOR_MODE_RGB;
+	u32 clrmode = PM2F_RD_COLOR_MODE_RGB | PM2F_RD_GUI_ACTIVE;
 	u32 txtmap = 0;
 	u32 pixsize = 0;
 	u32 clrformat = 0;
@@ -771,22 +774,23 @@
 		break;
 	case 16:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 1);
-		clrmode |= PM2F_RD_TRUECOLOR | 0x06;
+		clrmode |= PM2F_RD_TRUECOLOR | PM2F_RD_PIXELFORMAT_RGB565;
 		txtmap = PM2F_TEXTEL_SIZE_16;
 		pixsize = 1;
 		clrformat = 0x70;
 		break;
 	case 32:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 2);
-		clrmode |= PM2F_RD_TRUECOLOR | 0x08;
+		clrmode |= PM2F_RD_TRUECOLOR | PM2F_RD_PIXELFORMAT_RGBA8888;
 		txtmap = PM2F_TEXTEL_SIZE_32;
 		pixsize = 2;
 		clrformat = 0x20;
 		break;
 	case 24:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 4);
-		clrmode |= PM2F_RD_TRUECOLOR | 0x09;
-#ifndef PM2FB_BE_APERTURE
+		clrmode |= PM2F_RD_TRUECOLOR | PM2F_RD_PIXELFORMAT_RGB888;
+#ifdef __BIG_ENDIAN
+		/* Use BGR not RGB */
 		clrmode &= ~PM2F_RD_COLOR_MODE_RGB;
 #endif
 		txtmap = PM2F_TEXTEL_SIZE_24;
@@ -819,8 +823,7 @@
 	WAIT_FIFO(par, 4);
 	switch (par->type) {
 	case PM2_TYPE_PERMEDIA2:
-		pm2_RDAC_WR(par, PM2I_RD_COLOR_MODE,
-			    PM2F_RD_COLOR_MODE_RGB | PM2F_RD_GUI_ACTIVE | clrmode);
+		pm2_RDAC_WR(par, PM2I_RD_COLOR_MODE, clrmode);
 		break;
 	case PM2_TYPE_PERMEDIA2V:
 		pm2v_RDAC_WR(par, PM2VI_RD_PIXEL_SIZE, pixsize);
@@ -1086,9 +1089,15 @@
 	pm2fb_fix.mmio_start = pci_resource_start(pdev, 0);
 	pm2fb_fix.mmio_len = PM2_REGS_SIZE;
 
-#ifdef PM2FB_BE_APERTURE
+#if defined(__BIG_ENDIAN)
+	/*
+	 * PM2 has a 64k register file, mapped twice in 128k. Lower
+	 * map is little-endian, upper map is big-endian.
+	 */
 	pm2fb_fix.mmio_start += PM2_REGS_SIZE;
+	DPRINTK("Adjusting register base for big-endian.\n");
 #endif
+	DPRINTK("Register base at 0x%lx\n", pm2fb_fix.mmio_start);
     
 	/* Registers - request region and map it. */
 	if ( !request_mem_region(pm2fb_fix.mmio_start, pm2fb_fix.mmio_len,




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
