From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 12/15] fbdev: Add __iomem annotations to cirrusfb
Date: Fri, 29 Oct 2004 09:58:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.52021.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM3C-0006A9-D9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:34 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM3A-0001aL-Kn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:34 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 79ACC961CFB
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:21 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add __iomem annotations to cirrusfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 cirrusfb.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	2004-10-19 20:21:28 +08:00
+++ b/drivers/video/cirrusfb.c	2004-10-28 23:37:46 +08:00
@@ -391,9 +391,9 @@
 struct cirrusfb_info {
 	struct fb_info *info;
 
-	caddr_t fbmem;
-	caddr_t regbase;
-	caddr_t mem;
+	u8 __iomem *fbmem;
+	u8 __iomem *regbase;
+	u8 __iomem *mem;
 	unsigned long size;
 	cirrusfb_board_t btype;
 	unsigned char SFR;	/* Shadow of special function register */
@@ -571,13 +571,13 @@
 		   unsigned char *green,
 		   unsigned char *blue);
 #endif
-static void cirrusfb_WaitBLT (caddr_t regbase);
-static void cirrusfb_BitBLT (caddr_t regbase, int bits_per_pixel,
+static void cirrusfb_WaitBLT (u8 __iomem *regbase);
+static void cirrusfb_BitBLT (u8 __iomem *regbase, int bits_per_pixel,
 			     u_short curx, u_short cury,
 			     u_short destx, u_short desty,
 			     u_short width, u_short height,
 			     u_short line_length);
-static void cirrusfb_RectFill (caddr_t regbase, int bits_per_pixel,
+static void cirrusfb_RectFill (u8 __iomem *regbase, int bits_per_pixel,
 			       u_short x, u_short y,
 			       u_short width, u_short height,
 			       u_char color, u_short line_length);
@@ -1016,7 +1016,7 @@
 	struct cirrusfb_info *cinfo = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	struct cirrusfb_regs regs;
-	caddr_t regbase = cinfo->regbase;
+	u8 __iomem *regbase = cinfo->regbase;
 	unsigned char tmp;
 	int offset = 0, err;
 	const struct cirrusfb_board_info_rec *bi;
@@ -2149,7 +2149,7 @@
  * based on the DRAM bandwidth bit and DRAM bank switching bit.  This
  * works with 1MB, 2MB and 4MB configurations (which the Motorola boards
  * seem to have. */
-static unsigned int cirrusfb_get_memsize (caddr_t regbase)
+static unsigned int cirrusfb_get_memsize (u8 __iomem *regbase)
 {
 	unsigned long mem;
 	unsigned char SRF;
@@ -2394,7 +2394,7 @@
 		get_prep_addrs (&board_addr, &cinfo->fbregs_phys);
 #endif
 		/* PReP dies if we ioremap the IO registers, but it works w/out... */
-		cinfo->regbase = (char *) cinfo->fbregs_phys;
+		cinfo->regbase = (char __iomem *) cinfo->fbregs_phys;
 	} else {
 		DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
 		get_pci_addrs (pdev, &board_addr, &cinfo->fbregs_phys);
@@ -2865,7 +2865,7 @@
 *********************************************************************/
 
 /* FIXME: use interrupts instead */
-static void cirrusfb_WaitBLT (caddr_t regbase)
+static void cirrusfb_WaitBLT (u8 __iomem *regbase)
 {
 	/* now busy-wait until we're done */
 	while (vga_rgfx (regbase, CL_GR31) & 0x08)
@@ -2878,7 +2878,7 @@
 	perform accelerated "scrolling"
 ********************************************************************/
 
-static void cirrusfb_BitBLT (caddr_t regbase, int bits_per_pixel,
+static void cirrusfb_BitBLT (u8 __iomem *regbase, int bits_per_pixel,
 			     u_short curx, u_short cury, u_short destx, u_short desty,
 			     u_short width, u_short height, u_short line_length)
 {
@@ -2969,7 +2969,7 @@
 	perform accelerated rectangle fill
 ********************************************************************/
 
-static void cirrusfb_RectFill (caddr_t regbase, int bits_per_pixel,
+static void cirrusfb_RectFill (u8 __iomem *regbase, int bits_per_pixel,
 		     u_short x, u_short y, u_short width, u_short height,
 		     u_char color, u_short line_length)
 {




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
