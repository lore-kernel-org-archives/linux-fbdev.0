From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 5/5] intelfb: RESEND -
	add vsync interrupt support
Date: Tue, 20 Jun 2006 14:31:38 -0400 (EDT)
Message-ID: <20060620183138.3332290CE14@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FskxT-0000zC-JN for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:15 -0700
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FskxT-0000QN-0G
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:28:15 -0700
Received: from lex098.cecropia.com (HELO xenon)
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
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

[05/05] intelfb: Honor FB_ACTIVATE_VBL for display panning

Extends the intelfb_vsync struct to store panning offset. The interrupt service routine uses the stored panning offset if a pan is requested for the vsync. intelfbhw_disable_irq also pans the display if there is a pending request.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
---

 drivers/video/intelfb/intelfb.h    |    2 ++
 drivers/video/intelfb/intelfbdrv.c |    2 ++
 drivers/video/intelfb/intelfbhw.c  |   16 +++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff -X linux-2.6.17-rc4-vsyncwait/Documentation/dontdiff -Naurp linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfb.h linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfb.h	2006-06-09 10:41:06.000000000 -0600
+++ linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfb.h	2006-06-09 11:06:08.000000000 -0600
@@ -211,6 +211,8 @@ struct intelfb_heap_data {
 struct intelfb_vsync {
 	wait_queue_head_t wait;
 	unsigned int count;
+	int pan_display;
+	u32 pan_offset;
 };
 
 struct intelfb_info {
diff -X linux-2.6.17-rc4-vsyncwait/Documentation/dontdiff -Naurp linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbdrv.c linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbdrv.c	2006-06-09 10:45:10.000000000 -0600
+++ linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfbdrv.c	2006-06-09 11:08:22.000000000 -0600
@@ -900,6 +900,8 @@ intelfb_pci_register(struct pci_dev *pde
 	init_waitqueue_head(&dinfo->vsync.wait);
 	spin_lock_init(&dinfo->int_lock);
 	dinfo->irq_flags = 0;
+	dinfo->vsync.pan_display = 0;
+	dinfo->vsync.pan_offset = 0;
 
 	return 0;
 
diff -X linux-2.6.17-rc4-vsyncwait/Documentation/dontdiff -Naurp linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.c linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-vsyncwait/drivers/video/intelfb/intelfbhw.c	2006-06-09 10:48:26.000000000 -0600
+++ linux-2.6.17-rc4-panning/drivers/video/intelfb/intelfbhw.c	2006-06-09 11:12:34.000000000 -0600
@@ -371,7 +371,13 @@ intelfbhw_pan_display(struct fb_var_scre
 
 	offset += dinfo->fb.offset << 12;
 
-	OUTREG(DSPABASE, offset);
+	dinfo->vsync.pan_offset = offset;
+	if ((var->activate & FB_ACTIVATE_VBL) && !intelfbhw_enable_irq(dinfo, 0)) {
+		dinfo->vsync.pan_display = 1;
+	} else {
+		dinfo->vsync.pan_display = 0;
+		OUTREG(DSPABASE, offset);
+	}
 
 	return 0;
 }
@@ -2013,6 +2019,10 @@ intelfbhw_irq(int irq, void *dev_id, str
 
 	if (tmp & VSYNC_PIPE_A_INTERRUPT) {
 		dinfo->vsync.count++;
+		if (dinfo->vsync.pan_display) {
+			dinfo->vsync.pan_display = 0;
+			OUTREG(DSPABASE, dinfo->vsync.pan_offset);
+		}
 		wake_up_interruptible(&dinfo->vsync.wait);
 		handled = 1;
 	}
@@ -2055,6 +2065,10 @@ intelfbhw_disable_irq(struct intelfb_inf
 	u16 tmp;
 
 	if (test_and_clear_bit(0, &dinfo->irq_flags)) {
+		if (dinfo->vsync.pan_display) {
+			dinfo->vsync.pan_display = 0;
+			OUTREG(DSPABASE, dinfo->vsync.pan_offset);
+		}
 		spin_lock_irq(&dinfo->int_lock);
 		OUTREG16(HWSTAM, 0xffff);
 		OUTREG16(IMR, 0xffff);
