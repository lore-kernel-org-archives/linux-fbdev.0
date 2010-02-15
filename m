From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 15 Feb 2010 14:46:48 +0000
Subject: [PATCH 10/10] udlfb: remove printk and small cleanup
Message-Id: <1266245208.4353.3305.camel@bernie-aspireone>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove last remaining printk and clarify comments

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/staging/udlfb/udlfb.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-next/drivers/staging/udlfb/udlfb.c
=================================--- linux-next.orig/drivers/staging/udlfb/udlfb.c	2010-02-14 20:27:02.000000000 -0800
+++ linux-next/drivers/staging/udlfb/udlfb.c	2010-02-14 20:27:04.000000000 -0800
@@ -83,8 +83,8 @@ static struct fb_deferred_io dlfb_defio;
 #endif
 
 /*
- * Inserts a specific DisplayLink controller command into the provided
- * buffer.
+ * All DisplayLink bulk operations start with 0xAF, followed by specific code
+ * All operations are written to buffers which then later get sent to device
  */
 static char *dlfb_set_register(char *buf, u8 reg, u8 val)
 {
@@ -129,6 +129,10 @@ static char *dlfb_set_base16bpp(char *wr
 	return dlfb_set_register(wrptr, 0x22, base);
 }
 
+/*
+ * DisplayLink HW has separate 16bpp and 8bpp framebuffers.
+ * In 24bpp modes, the low 323 RGB bits go in the 8bpp framebuffer
+ */
 static char *dlfb_set_base8bpp(char *wrptr, u32 base)
 {
 	wrptr = dlfb_set_register(wrptr, 0x26, base >> 16);
@@ -161,7 +165,7 @@ static char *dlfb_set_register_16be(char
  * same actual count. This makes sense once you read above a couple of
  * times and think about it from a hardware perspective.
  */
-static u16 lfsr16(u16 actual_count)
+static u16 dlfb_lfsr16(u16 actual_count)
 {
 	u32 lv = 0xFFFF; /* This is the lfsr value that the hw starts with */
 
@@ -180,7 +184,7 @@ static u16 lfsr16(u16 actual_count)
  */
 static char *dlfb_set_register_lfsr16(char *wrptr, u8 reg, u16 value)
 {
-	return dlfb_set_register_16(wrptr, reg, lfsr16(value));
+	return dlfb_set_register_16(wrptr, reg, dlfb_lfsr16(value));
 }
 
 /*
@@ -292,8 +296,9 @@ static int dlfb_ops_mmap(struct fb_info 
 	unsigned long size = vma->vm_end - vma->vm_start;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
+	struct dlfb_data *dev = info->par;
 
-	printk("MMAP: %lu %u\n", offset + size, info->fix.smem_len);
+	dl_notice("MMAP: %lu %u\n", offset + size, info->fix.smem_len);
 
 	if (offset + size > info->fix.smem_len)
 		return -EINVAL;


