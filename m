From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/15] fbdev: Add __iomem annotations to sstfb
Date: Fri, 29 Oct 2004 09:58:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.29349.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2l-00063p-1F
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:07 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2i-0000Aq-Bi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9AB8E8E5CAA
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:57 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ghozlane Toumi <gtoumi@laposte.net>

Add __iomem annotations to sstfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/sstfb.c |   34 +++++++++++++++-------------------
 include/video/sstfb.h |   11 +++++++----
 2 files changed, 22 insertions(+), 23 deletions(-)

diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	2004-10-29 08:23:39 +08:00
+++ b/drivers/video/sstfb.c	2004-10-29 08:55:32 +08:00
@@ -67,10 +67,6 @@
 
 #undef SST_DEBUG
 
-#define SST_DEBUG_REG   0
-#define SST_DEBUG_FUNC  0
-#define SST_DEBUG_VAR   0
-
 /* enable 24/32 bpp functions ? (completely untested!) */
 #undef EN_24_32_BPP
 
@@ -220,26 +216,26 @@
 #define dac_i_read(reg)		__dac_i_read(par->mmio_vbase, reg)
 #define dac_i_write(reg,val)	__dac_i_write(par->mmio_vbase, reg, val)
 
-static inline u32 __sst_read(u_long vbase, u32 reg)
+static inline u32 __sst_read(u8 __iomem *vbase, u32 reg)
 {
 	u32 ret = readl(vbase + reg);
 	sst_dbg_print_read_reg(reg, ret);
 	return ret;
 }
 
-static inline void __sst_write(u_long vbase, u32 reg, u32 val)
+static inline void __sst_write(u8 __iomem *vbase, u32 reg, u32 val)
 {
 	sst_dbg_print_write_reg(reg, val);
 	writel(val, vbase + reg);
 }
 
-static inline void __sst_set_bits(u_long vbase, u32 reg, u32 val)
+static inline void __sst_set_bits(u8 __iomem *vbase, u32 reg, u32 val)
 {
 	r_dprintk("sst_set_bits(%#x, %#x)\n", reg, val);
 	__sst_write(vbase, reg, __sst_read(vbase, reg) | val);
 }
 
-static inline void __sst_unset_bits(u_long vbase, u32 reg, u32 val)
+static inline void __sst_unset_bits(u8 __iomem *vbase, u32 reg, u32 val)
 {
 	r_dprintk("sst_unset_bits(%#x, %#x)\n", reg, val);
 	__sst_write(vbase, reg, __sst_read(vbase, reg) & ~val);
@@ -254,7 +250,7 @@
 
 #define sst_wait_idle() __sst_wait_idle(par->mmio_vbase)
 
-static int __sst_wait_idle(u_long vbase)
+static int __sst_wait_idle(u8 __iomem *vbase)
 {
 	int count = 0;
 
@@ -279,7 +275,7 @@
 
 /* dac access */
 /* dac_read should be remaped to FbiInit2 (via the pci reg init_enable) */
-static u8 __sst_dac_read(u_long vbase, u8 reg)
+static u8 __sst_dac_read(u8 __iomem *vbase, u8 reg)
 {
 	u8 ret;
 
@@ -293,7 +289,7 @@
 	return ret;
 }
 
-static void __sst_dac_write(u_long vbase, u8 reg, u8 val)
+static void __sst_dac_write(u8 __iomem *vbase, u8 reg, u8 val)
 {
 	r_dprintk("sst_dac_write(%#x, %#x)\n", reg, val);
 	reg &= 0x07;
@@ -301,7 +297,7 @@
 }
 
 /* indexed access to ti/att dacs */
-static u32 __dac_i_read(u_long vbase, u8 reg)
+static u32 __dac_i_read(u8 __iomem *vbase, u8 reg)
 {
 	u32 ret;
 
@@ -310,7 +306,7 @@
 	r_dprintk("sst_dac_read_i(%#x): %#x\n", reg, ret);
 	return ret;
 }
-static void __dac_i_write(u_long vbase, u8 reg,u8 val)
+static void __dac_i_write(u8 __iomem *vbase, u8 reg,u8 val)
 {
 	r_dprintk("sst_dac_write_i(%#x, %#x)\n", reg, val);
 	__sst_dac_write(vbase, DACREG_ADDR_I, reg);
@@ -886,7 +882,7 @@
  */
 static int __devinit sst_get_memsize(struct fb_info *info, __u32 *memsize)
 {
-	u_long fbbase_virt = (u_long) info->screen_base;
+	u8 __iomem *fbbase_virt = info->screen_base;
 
 	/* force memsize */
 	if ((mem >= 1 ) &&  (mem <= 4)) {
@@ -1442,7 +1438,7 @@
 		goto fail_fb_mem;
 	}
 
-	par->mmio_vbase = (u_long) ioremap_nocache(fix->mmio_start,
+	par->mmio_vbase = ioremap_nocache(fix->mmio_start,
 					fix->mmio_len);
 	if (!par->mmio_vbase) {
 		eprintk("cannot remap register area %#lx\n",
@@ -1526,7 +1522,7 @@
 fail:
 	iounmap(info->screen_base);
 fail_fb_remap:
-	iounmap((void *)par->mmio_vbase);
+	iounmap(par->mmio_vbase);
 fail_mmio_remap:
 	release_mem_region(fix->smem_start, 0x400000);
 fail_fb_mem:
@@ -1547,7 +1543,7 @@
 	sst_shutdown(info);
 	unregister_framebuffer(info);
 	iounmap(info->screen_base);
-	iounmap((void*)par->mmio_vbase);
+	iounmap(par->mmio_vbase);
 	release_mem_region(info->fix.smem_start, 0x400000);
 	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
 	kfree(info);
@@ -1644,10 +1640,10 @@
 
 static void sstfb_fillrect_softw( struct fb_info *info, const struct fb_fillrect *rect)
 {
-	unsigned long fbbase_virt = (unsigned long) info->screen_base;
+	u8 __iomem *fbbase_virt = info->screen_base;
 	int x, y, w = info->var.bits_per_pixel == 16 ? 2 : 4;
 	u32 color = rect->color, height = rect->height;
-	unsigned long p;
+	u8 __iomem *p;
 	
 	if (w==2) color |= color<<16;
 	for (y=rect->dy; height; y++, height--) {
diff -Nru a/include/video/sstfb.h b/include/video/sstfb.h
--- a/include/video/sstfb.h	2004-10-29 08:23:40 +08:00
+++ b/include/video/sstfb.h	2004-10-29 08:49:01 +08:00
@@ -18,11 +18,14 @@
 
 #ifdef SST_DEBUG
 #  define dprintk(X...)		printk("sstfb: " X)
+#  define SST_DEBUG_REG  1
+#  define SST_DEBUG_FUNC 1
+#  define SST_DEBUG_VAR  1
 #else
 #  define dprintk(X...)
-#  undef SST_DEBUG_REG
-#  undef SST_DEBUG_FUNC
-#  undef SST_DEBUG_VAR
+#  define SST_DEBUG_REG  0
+#  define SST_DEBUG_FUNC 0
+#  define SST_DEBUG_VAR  0
 #endif
 
 #if (SST_DEBUG_REG > 0)
@@ -340,7 +343,7 @@
 	unsigned int vBackPorch;
 	struct pll_timing pll;
 	unsigned int tiles_in_X;/* num of tiles in X res */
-	unsigned long mmio_vbase;
+	u8 __iomem *mmio_vbase;
 	struct dac_switch 	dac_sw;	/* dac specific functions */
 	struct pci_dev		*dev;
 	int	type;




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
