From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 3/5] intelfb: RESEND -
	add vsync interrupt support
Date: Tue, 20 Jun 2006 14:31:38 -0400 (EDT)
Message-ID: <20060620183138.2D94590CE12@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslG6-0002iW-TO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:47:30 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FskxT-0004nE-Dz for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:15 -0700
Received: from mail5.sea5.speakeasy.net ([69.17.117.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FskxT-0005B8-2t
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:15 -0700
Received: from lex098.cecropia.com (HELO xenon)
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	20 Jun 2006 18:28:13 -0000
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

From: Eric Hustvedt <ehustvedt@cecropia.com>

[03/05] intelfb: Implement basic interrupt handling

Functions have been added to enable and disable interrupts using the MMIO registers. Currently only pipe A vsync interrupts are enabled.
A generalized vsync accounting struct is defined, with the intent that it can encapsulate per-pipe vsync related info in the future. Currently a single instance is hard-coded.
The interrupt service routine currently only looks for vsync interrupts on pipe A, and increments a counter and wakes up anyone waiting on it.

This implementation is heavily influenced by similar implementations in the atyfb and matroxfb drivers.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
---

 drivers/video/intelfb/intelfb.h    |   11 +++
 drivers/video/intelfb/intelfbdrv.c |   39 +++++++++++++
 drivers/video/intelfb/intelfbhw.c  |   76 +++++++++++++++++++++++++++
 drivers/video/intelfb/intelfbhw.h  |    2 
 4 files changed, 128 insertions(+)

diff -X linux-2.6.17-rc4-hwstam/Documentation/dontdiff -Naurp linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfb.h linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfb.h	2006-06-09 09:43:18.000000000 -0600
+++ linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfb.h	2006-06-09 10:10:15.000000000 -0600
@@ -208,6 +208,11 @@ struct intelfb_heap_data {
 	u32 size;    // in bytes
 };
 
+struct intelfb_vsync {
+	wait_queue_head_t wait;
+	unsigned int count;
+};
+
 struct intelfb_info {
 	struct fb_info *info;
 	struct fb_ops  *fbops;
@@ -271,7 +276,13 @@ struct intelfb_info {
 	int fixed_mode;
 	int ring_active;
 	int flag;
+	unsigned long irq_flags;
+	int open;
 
+	/* vsync */
+	struct intelfb_vsync vsync;
+	spinlock_t int_lock;
+
 	/* hw cursor */
 	int cursor_on;
 	int cursor_blanked;
diff -X linux-2.6.17-rc4-hwstam/Documentation/dontdiff -Naurp linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbdrv.c linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbdrv.c	2006-06-09 09:41:10.000000000 -0600
+++ linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbdrv.c	2006-06-09 10:11:11.000000000 -0600
@@ -137,6 +137,8 @@
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);
+static int intelfb_open(struct fb_info *info, int user);
+static int intelfb_release(struct fb_info *info, int user);
 static int intelfb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int intelfb_set_par(struct fb_info *info);
@@ -195,6 +197,8 @@ static int num_registered = 0;
 /* fb ops */
 static struct fb_ops intel_fb_ops = {
 	.owner =		THIS_MODULE,
+	.fb_open =              intelfb_open,
+	.fb_release =           intelfb_release,
 	.fb_check_var =         intelfb_check_var,
 	.fb_set_par =           intelfb_set_par,
 	.fb_setcolreg =		intelfb_setcolreg,
@@ -447,6 +451,8 @@ cleanup(struct intelfb_info *dinfo)
 	if (!dinfo)
 		return;
 
+	intelfbhw_disable_irq(dinfo);
+
 	fb_dealloc_cmap(&dinfo->info->cmap);
 	kfree(dinfo->info->pixmap.addr);
 
@@ -889,6 +895,11 @@ intelfb_pci_register(struct pci_dev *pde
 	}
 
 	dinfo->registered = 1;
+	dinfo->open = 0;
+
+	init_waitqueue_head(&dinfo->vsync.wait);
+	spin_lock_init(&dinfo->int_lock);
+	dinfo->irq_flags = 0;
 
 	return 0;
 
@@ -1189,6 +1200,34 @@ update_dinfo(struct intelfb_info *dinfo,
  ***************************************************************/
 
 static int
+intelfb_open(struct fb_info *info, int user)
+{
+	struct intelfb_info *dinfo = GET_DINFO(info);
+
+	if (user) {
+		dinfo->open++;
+	}
+
+	return 0;
+}
+
+static int
+intelfb_release(struct fb_info *info, int user)
+{
+	struct intelfb_info *dinfo = GET_DINFO(info);
+
+	if (user) {
+		dinfo->open--;
+		msleep(1);
+		if (!dinfo->open) {
+			intelfbhw_disable_irq(dinfo);
+		}
+	}
+
+	return 0;
+}
+
+static int
 intelfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	int change_var = 0;
diff -X linux-2.6.17-rc4-hwstam/Documentation/dontdiff -Naurp linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.c linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.c	2006-06-09 09:43:18.000000000 -0600
+++ linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.c	2006-06-09 10:17:11.000000000 -0600
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/interrupt.h>
 
 #include <asm/io.h>
 
@@ -1991,3 +1992,78 @@ intelfbhw_cursor_reset(struct intelfb_in
 		addr += 16;
 	}
 }
+
+static irqreturn_t
+intelfbhw_irq(int irq, void *dev_id, struct pt_regs *fp) {
+	int handled = 0;
+	u16 tmp;
+	struct intelfb_info *dinfo = (struct intelfb_info *)dev_id;
+
+	spin_lock(&dinfo->int_lock);
+
+	tmp = INREG16(IIR);
+	tmp &= VSYNC_PIPE_A_INTERRUPT;
+
+	if (tmp == 0) {
+		spin_unlock(&dinfo->int_lock);
+		return IRQ_RETVAL(handled);
+	}
+
+	OUTREG16(IIR, tmp);
+
+	if (tmp & VSYNC_PIPE_A_INTERRUPT) {
+		dinfo->vsync.count++;
+		wake_up_interruptible(&dinfo->vsync.wait);
+		handled = 1;
+	}
+
+	spin_unlock(&dinfo->int_lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+int
+intelfbhw_enable_irq(struct intelfb_info *dinfo, int reenable) {
+
+	if (!test_and_set_bit(0, &dinfo->irq_flags)) {
+		if (request_irq(dinfo->pdev->irq, intelfbhw_irq, SA_SHIRQ, "intelfb", dinfo)) {
+			clear_bit(0, &dinfo->irq_flags);
+			return -EINVAL;
+		}
+
+		spin_lock_irq(&dinfo->int_lock);
+		OUTREG16(HWSTAM, 0xfffe);
+		OUTREG16(IMR, 0x0);
+		OUTREG16(IER, VSYNC_PIPE_A_INTERRUPT);
+		spin_unlock_irq(&dinfo->int_lock);
+	} else if (reenable) {
+		u16 ier;
+
+		spin_lock_irq(&dinfo->int_lock);
+		ier = INREG16(IER);
+		if ((ier & VSYNC_PIPE_A_INTERRUPT)) {
+			DBG_MSG("someone disabled the IRQ [%08X]\n", ier);
+			OUTREG(IER, VSYNC_PIPE_A_INTERRUPT);
+		}
+		spin_unlock_irq(&dinfo->int_lock);
+	}
+	return 0;
+}
+
+void
+intelfbhw_disable_irq(struct intelfb_info *dinfo) {
+	u16 tmp;
+
+	if (test_and_clear_bit(0, &dinfo->irq_flags)) {
+		spin_lock_irq(&dinfo->int_lock);
+		OUTREG16(HWSTAM, 0xffff);
+		OUTREG16(IMR, 0xffff);
+		OUTREG16(IER, 0x0);
+
+		tmp = INREG16(IIR);
+		OUTREG16(IIR, tmp);
+		spin_unlock_irq(&dinfo->int_lock);
+
+		free_irq(dinfo->pdev->irq, dinfo);
+	}
+}
diff -X linux-2.6.17-rc4-hwstam/Documentation/dontdiff -Naurp linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.h linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.h	2006-06-09 10:04:37.000000000 -0600
+++ linux-2.6.17-rc4-interrupt/drivers/video/intelfb/intelfbhw.h	2006-06-09 10:17:51.000000000 -0600
@@ -561,5 +561,7 @@ extern void intelfbhw_cursor_setcolor(st
 extern void intelfbhw_cursor_load(struct intelfb_info *dinfo, int width,
 				  int height, u8 *data);
 extern void intelfbhw_cursor_reset(struct intelfb_info *dinfo);
+extern int intelfbhw_enable_irq(struct intelfb_info *dinfo, int reenable);
+extern void intelfbhw_disable_irq(struct intelfb_info *dinfo);
 
 #endif /* _INTELFBHW_H */
