From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: Add __iomem annotations to intelfb
Date: Thu, 28 Oct 2004 09:10:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410280910.41649.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMyl4-0003KH-1z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 18:07:18 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMyl3-0004Hh-8n
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 18:07:17 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8873493FF01
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Oct 2004 01:07:09 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@ifrance.com>

- Add __iomem annotations to intelfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 intelfb.h    |    6 +++---
 intelfbdrv.c |   23 +++++++++++++----------
 intelfbhw.c  |   28 ++++++++++++++++------------
 intelfbhw.h  |   12 +++++++-----
 4 files changed, 39 insertions(+), 30 deletions(-)

diff -Nru a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb.h
--- a/drivers/video/intelfb/intelfb.h	2004-10-21 05:06:38 +08:00
+++ b/drivers/video/intelfb/intelfb.h	2004-10-23 23:13:14 +08:00
@@ -205,7 +205,7 @@
 
 struct intelfb_heap_data {
 	u32 physical;
-	u32 virtual;
+	u32 __iomem *virtual;
 	u32 offset;  // in GATT pages
 	u32 size;    // in bytes
 };
@@ -234,13 +234,13 @@
 
 	/* mmio regs */
 	u32 mmio_base_phys;
-	u32 mmio_base;
+	u32 __iomem *mmio_base;
 
 	/* fb start offset (in bytes) */
 	u32 fb_start;
 
 	/* ring buffer */
-	u32 ring_head;
+	u32 __iomem *ring_head;
 	u32 ring_tail;
 	u32 ring_tail_mask;
 	u32 ring_space;
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-10-21 05:06:40 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-10-23 23:13:14 +08:00
@@ -410,9 +410,9 @@
 	}
 
 	if (dinfo->mmio_base)
-		iounmap((void *)dinfo->mmio_base);
+		iounmap((void __iomem *)dinfo->mmio_base);
 	if (dinfo->aperture.virtual)
-		iounmap((void *)dinfo->aperture.virtual);
+		iounmap((void __iomem *)dinfo->aperture.virtual);
 
 	if (dinfo->mmio_base_phys)
 		release_mem_region(dinfo->mmio_base_phys, INTEL_REG_SIZE);
@@ -510,15 +510,16 @@
 	}
 
 	/* Map the fb and MMIO regions */
-	dinfo->aperture.virtual = (u32)ioremap_nocache
+	dinfo->aperture.virtual = (u32 __iomem *)ioremap_nocache
 		(dinfo->aperture.physical, dinfo->aperture.size);
 	if (!dinfo->aperture.virtual) {
 		ERR_MSG("Cannot remap FB region.\n");
 		cleanup(dinfo);
 		return -ENODEV;
 	}
-	dinfo->mmio_base = (u32)ioremap_nocache(dinfo->mmio_base_phys,
-						INTEL_REG_SIZE);
+	dinfo->mmio_base =
+		(u32 __iomem *)ioremap_nocache(dinfo->mmio_base_phys,
+					       INTEL_REG_SIZE);
 	if (!dinfo->mmio_base) {
 		ERR_MSG("Cannot remap MMIO region.\n");
 		cleanup(dinfo);
@@ -656,14 +657,16 @@
 
 	DBG_MSG("fb: 0x%x(+ 0x%x)/0x%x (0x%x)\n",
 		dinfo->fb.physical, dinfo->fb.offset, dinfo->fb.size,
-		dinfo->fb.virtual);
+		(u32 __iomem ) dinfo->fb.virtual);
 	DBG_MSG("MMIO: 0x%x/0x%x (0x%x)\n",
-		dinfo->mmio_base_phys, INTEL_REG_SIZE, dinfo->mmio_base);
+		dinfo->mmio_base_phys, INTEL_REG_SIZE,
+		(u32 __iomem) dinfo->mmio_base);
 	DBG_MSG("ring buffer: 0x%x/0x%x (0x%x)\n",
-		dinfo->ring.physical, dinfo->ring.size, dinfo->ring.virtual);
+		dinfo->ring.physical, dinfo->ring.size,
+		(u32 __iomem ) dinfo->ring.virtual);
 	DBG_MSG("HW cursor: 0x%x/0x%x (0x%x) (offset 0x%x) (phys 0x%x)\n",
 		dinfo->cursor.physical, dinfo->cursor.size,
-		dinfo->cursor.virtual, dinfo->cursor.offset,
+		(u32 __iomem ) dinfo->cursor.virtual, dinfo->cursor.offset,
 		dinfo->cursor.physical);
 
 	DBG_MSG("options: accel = %d, hwcursor = %d, fixed = %d, "
@@ -1159,7 +1162,7 @@
 	if (FIXED_MODE(dinfo))
 		dinfo->pitch = dinfo->initial_pitch;
 
-	dinfo->info->screen_base = (char *)dinfo->fb.virtual;
+	dinfo->info->screen_base = (char __iomem *)dinfo->fb.virtual;
 	dinfo->info->fix.line_length = dinfo->pitch;
 	dinfo->info->fix.visual = dinfo->visual;
 }
diff -Nru a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c	2004-10-21 05:06:43 +08:00
+++ b/drivers/video/intelfb/intelfbhw.c	2004-10-23 23:13:14 +08:00
@@ -1240,17 +1240,19 @@
 
 	end = jiffies + (HZ * 3);
 	while (dinfo->ring_space < n) {
-		dinfo->ring_head = INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
-		if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
-			dinfo->ring_space = dinfo->ring_head
+		dinfo->ring_head = (u32 __iomem *)(INREG(PRI_RING_HEAD) &
+						   RING_HEAD_MASK);
+		if (dinfo->ring_tail + RING_MIN_FREE <
+		    (u32 __iomem) dinfo->ring_head)
+			dinfo->ring_space = (u32 __iomem) dinfo->ring_head
 				- (dinfo->ring_tail + RING_MIN_FREE);
 		else
 			dinfo->ring_space = (dinfo->ring.size +
-					     dinfo->ring_head)
+					     (u32 __iomem) dinfo->ring_head)
 				- (dinfo->ring_tail + RING_MIN_FREE);
-		if (dinfo->ring_head != last_head) {
+		if ((u32 __iomem) dinfo->ring_head != last_head) {
 			end = jiffies + (HZ * 3);
-			last_head = dinfo->ring_head;
+			last_head = (u32 __iomem) dinfo->ring_head;
 		}
 		i++;
 		if (time_before(end, jiffies)) {
@@ -1310,13 +1312,15 @@
 	DBG_MSG("refresh_ring\n");
 #endif
 
-	dinfo->ring_head = INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
+	dinfo->ring_head = (u32 __iomem *) (INREG(PRI_RING_HEAD) &
+		RING_HEAD_MASK);
 	dinfo->ring_tail = INREG(PRI_RING_TAIL) & RING_TAIL_MASK;
-	if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
-		dinfo->ring_space = dinfo->ring_head
+	if (dinfo->ring_tail + RING_MIN_FREE < (u32 __iomem)dinfo->ring_head)
+		dinfo->ring_space = (u32 __iomem) dinfo->ring_head
 			- (dinfo->ring_tail + RING_MIN_FREE);
 	else
-		dinfo->ring_space = (dinfo->ring.size + dinfo->ring_head)
+		dinfo->ring_space = (dinfo->ring.size +
+				     (u32 __iomem) dinfo->ring_head)
 			- (dinfo->ring_tail + RING_MIN_FREE);
 }
 
@@ -1701,7 +1705,7 @@
 intelfbhw_cursor_load(struct intelfb_info *dinfo, int width, int height,
 		      u8 *data)
 {
-	u8 *addr = (u8 *)dinfo->cursor.virtual;
+	u8 __iomem *addr = (u8 __iomem *)dinfo->cursor.virtual;
 	int i, j, w = width / 8;
 	int mod = width % 8, t_mask, d_mask;
 
@@ -1729,7 +1733,7 @@
 
 void
 intelfbhw_cursor_reset(struct intelfb_info *dinfo) {
-	u8 *addr = (u8 *)dinfo->cursor.virtual;
+	u8 __iomem *addr = (u8 __iomem *)dinfo->cursor.virtual;
 	int i, j;
 
 #if VERBOSE > 0
diff -Nru a/drivers/video/intelfb/intelfbhw.h b/drivers/video/intelfb/intelfbhw.h
--- a/drivers/video/intelfb/intelfbhw.h	2004-10-21 05:06:45 +08:00
+++ b/drivers/video/intelfb/intelfbhw.h	2004-10-23 23:13:14 +08:00
@@ -484,14 +484,16 @@
 /*** Macros ***/
 
 /* I/O macros */
-#define INREG8(addr)	      readb((u8 *)(dinfo->mmio_base + (addr)))
-#define INREG(addr)	      readl((u32 *)(dinfo->mmio_base + (addr)))
-#define OUTREG8(addr, val)    writeb((val), (u8 *)(dinfo->mmio_base + (addr)))
-#define OUTREG(addr, val)     writel((val), (u32 *)(dinfo->mmio_base + (addr)))
+#define INREG8(addr)	      readb((u8 __iomem *)(dinfo->mmio_base + (addr)))
+#define INREG(addr)	      readl((u32 __iomem *)(dinfo->mmio_base + (addr)))
+#define OUTREG8(addr, val)    writeb((val),(u8 __iomem *)(dinfo->mmio_base + \
+							   (addr)))
+#define OUTREG(addr, val)     writel((val),(u32 __iomem *)(dinfo->mmio_base + \
+                                     (addr)))
 
 /* Ring buffer macros */
 #define OUT_RING(n)	do {						\
-	writel((n), (u32 *)(dinfo->ring.virtual + dinfo->ring_tail));	\
+	writel((n), (u32 __iomem *)(dinfo->ring.virtual + dinfo->ring_tail));\
 	dinfo->ring_tail += 4;						\
 	dinfo->ring_tail &= dinfo->ring_tail_mask;			\
 } while (0)





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
