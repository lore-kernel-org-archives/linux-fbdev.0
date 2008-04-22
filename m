From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] atyfb: Fix 64 bits resources on 32
	bits archs
Date: Tue, 22 Apr 2008 11:26:09 +1000
Message-ID: <20080422012726.42775DE2A3@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jo7I8-0000tl-Hc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:29 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jo7I7-000586-Tk
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:28 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, adaplas@gmail.com

This fixes atyfb to not truncate 64 bits resources on 32 bits
platforms. Unfortunately, there are still issues with addresses
returned to userspace via struct fb_fix_screeninfo. This will
have to be dealt with separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/video/aty/atyfb_base.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-work.orig/drivers/video/aty/atyfb_base.c	2008-04-22 11:21:46.000000000 +1000
+++ linux-work/drivers/video/aty/atyfb_base.c	2008-04-22 11:23:58.000000000 +1000
@@ -2842,7 +2842,7 @@ static int atyfb_setcolreg(u_int regno, 
 #ifdef __sparc__
 
 static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
-			struct fb_info *info, unsigned long addr)
+			struct fb_info *info, resource_size_t addr)
 {
 	struct atyfb_par *par = info->par;
 	struct device_node *dp;
@@ -3334,11 +3334,11 @@ static int __devinit init_from_bios(stru
 }
 #endif /* __i386__ */
 
-static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info, unsigned long addr)
+static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info, resource_size_t addr)
 {
 	struct atyfb_par *par = info->par;
 	u16 tmp;
-	unsigned long raddr;
+	resource_size_t raddr;
 	struct resource *rrp;
 	int ret = 0;
 
@@ -3351,8 +3351,8 @@ static int __devinit atyfb_setup_generic
 		PRINTKI("using auxiliary register aperture\n");
 	}
 
-	info->fix.mmio_start = raddr;
-	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+	info->fix.mmio_start = (unsigned long)raddr;
+	par->ati_regbase = ioremap(raddr, 0x1000);
 	if (par->ati_regbase == 0)
 		return -ENOMEM;
 
@@ -3374,7 +3374,7 @@ static int __devinit atyfb_setup_generic
 #endif
 
 	/* Map in frame buffer */
-	info->fix.smem_start = addr;
+	info->fix.smem_start = (unsigned long)addr;
 	info->screen_base = ioremap(addr, 0x800000);
 	if (info->screen_base == NULL) {
 		ret = -ENOMEM;
@@ -3411,7 +3411,7 @@ atyfb_setup_generic_fail:
 
 static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	unsigned long addr, res_start, res_size;
+	resource_size_t addr, res_start, res_size;
 	struct fb_info *info;
 	struct resource *rp;
 	struct atyfb_par *par;

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
