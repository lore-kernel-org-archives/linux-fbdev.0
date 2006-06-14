From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2/5 2.6.17-rc6-mm2] add vsync interrupt
	support to intelfb driver
Date: Wed, 14 Jun 2006 09:10:26 -0400
Message-ID: <B3454014-3930-44CE-A6B5-F1B76D976849@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqV6E-0006xc-98 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:58 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqV6A-0004AM-SU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 06:07:55 -0700
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
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Eric Hustvedt <ehustvedt@cecropia.com>

[02/05] intelfb: Add interrupt related register definitions

Add constants for accessing HWSTAM, IER, IIR, and IMR registers.
Add constants for interrupt types supported by the 8xx and 9xx chipsets.
The registers are also stored in the hwstate struct and dumped in the
debug routine.

Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
---

drivers/video/intelfb/intelfb.h   |    4 ++++
drivers/video/intelfb/intelfbhw.c |    9 +++++++++
drivers/video/intelfb/intelfbhw.h |   13 +++++++++++++
3 files changed, 26 insertions(+)

diff -X linux-2.6.17-rc4-16bit/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfb.h linux-2.6.17- 
rc4-hwstam/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfb.h	2006-06-09  
09:29:59.000000000 -0600
+++ linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfb.h	 
2006-06-09 09:43:18.000000000 -0600
@@ -195,6 +195,10 @@ struct intelfb_hwstate {
	u32 mem_mode;
	u32 fw_blc_0;
	u32 fw_blc_1;
+	u16 hwstam;
+	u16 ier;
+	u16 iir;
+	u16 imr;
};
struct intelfb_heap_data {
diff -X linux-2.6.17-rc4-16bit/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfbhw.c linux-2.6.17- 
rc4-hwstam/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfbhw.c	 
2006-06-09 09:29:59.000000000 -0600
+++ linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.c	 
2006-06-09 09:43:18.000000000 -0600
@@ -587,6 +587,11 @@ intelfbhw_read_hw_state(struct intelfb_i
	hw->fw_blc_0 = INREG(FW_BLC_0);
	hw->fw_blc_1 = INREG(FW_BLC_1);
+	hw->hwstam = INREG16(HWSTAM);
+	hw->ier = INREG16(IER);
+	hw->iir = INREG16(IIR);
+	hw->imr = INREG16(IMR);
+
	return 0;
}
@@ -840,6 +845,10 @@ intelfbhw_print_hw_state(struct intelfb_
	printk("	FW_BLC_0		0x%08x\n", hw->fw_blc_0);
	printk("	FW_BLC_1		0x%08x\n", hw->fw_blc_1);
+	printk("	HWSTAM			0x%04x\n", hw->hwstam);
+	printk("	IER			0x%04x\n", hw->ier);
+	printk("	IIR			0x%04x\n", hw->iir);
+	printk("	IMR			0x%04x\n", hw->imr);
	printk("hw state dump end\n");
#endif
}
diff -X linux-2.6.17-rc4-16bit/Documentation/dontdiff -Naurp  
linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfbhw.h linux-2.6.17- 
rc4-hwstam/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc4-16bit/drivers/video/intelfb/intelfbhw.h	 
2006-06-09 09:40:48.000000000 -0600
+++ linux-2.6.17-rc4-hwstam/drivers/video/intelfb/intelfbhw.h	 
2006-06-09 10:04:37.000000000 -0600
@@ -88,6 +88,19 @@
#define INSTDONE		0x2090
#define PRI_RING_EMPTY			1
+#define HWSTAM			0x2098
+#define IER			0x20A0
+#define IIR			0x20A4
+#define IMR			0x20A8
+#define VSYNC_PIPE_A_INTERRUPT		(1 << 7)
+#define PIPE_A_EVENT_INTERRUPT		(1 << 4)
+#define VSYNC_PIPE_B_INTERRUPT		(1 << 5)
+#define PIPE_B_EVENT_INTERRUPT		(1 << 4)
+#define HOST_PORT_EVENT_INTERRUPT	(1 << 3)
+#define CAPTURE_EVENT_INTERRUPT		(1 << 2)
+#define USER_DEFINED_INTERRUPT		(1 << 1)
+#define BREAKPOINT_INTERRUPT		1
+
#define INSTPM			0x20c0
#define SYNC_FLUSH_ENABLE		(1 << 5)
