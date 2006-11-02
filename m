From: akpm@osdl.org
Subject: [patch 10/25] constify vga16fb.c
Date: Wed, 01 Nov 2006 21:50:24 -0800
Message-ID: <200611020550.kA25oOjX002318@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTK-0007YH-1f for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:38 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTJ-0008RE-P0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:38 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, deller@gmx.de

From: Helge Deller <deller@gmx.de>

- move some static data into the .rodata section

- simplify source code for transl_l[] and transl_h[] which makes it more
  readable

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/vga16fb.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff -puN drivers/video/vga16fb.c~constify-vga16fbc drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c~constify-vga16fbc
+++ a/drivers/video/vga16fb.c
@@ -264,7 +264,7 @@ static void vga16fb_clock_chip(struct vg
 			       const struct fb_info *info,
 			       int mul, int div)
 {
-	static struct {
+	static const struct {
 		u32 pixclock;
 		u8  misc;
 		u8  seq_clock_mode;
@@ -652,7 +652,7 @@ static int vga16fb_set_par(struct fb_inf
 
 static void ega16_setpalette(int regno, unsigned red, unsigned green, unsigned blue)
 {
-	static unsigned char map[] = { 000, 001, 010, 011 };
+	static const unsigned char map[] = { 000, 001, 010, 011 };
 	int val;
 	
 	if (regno >= 16)
@@ -1139,23 +1139,19 @@ static void vga16fb_copyarea(struct fb_i
 	}
 }
 
-#ifdef __LITTLE_ENDIAN
-static unsigned int transl_l[] =
-{0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF};
-static unsigned int transl_h[] =
-{0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00,
- 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00};
-#else
-#ifdef __BIG_ENDIAN
-static unsigned int transl_h[] =
-{0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF};
-static unsigned int transl_l[] =
-{0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00,
- 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00};
+#define TRANS_MASK_LOW  {0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF}
+#define TRANS_MASK_HIGH {0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00, \
+			 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00}
+
+#if defined(__LITTLE_ENDIAN)
+static const u16 transl_l[] = TRANS_MASK_LOW;
+static const u16 transl_h[] = TRANS_MASK_HIGH;
+#elif defined(__BIG_ENDIAN)
+static const u16 transl_l[] = TRANS_MASK_HIGH;
+static const u16 transl_h[] = TRANS_MASK_LOW;
 #else
 #error "Only __BIG_ENDIAN and __LITTLE_ENDIAN are supported in vga-planes"
 #endif
-#endif
 
 static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
 {
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
