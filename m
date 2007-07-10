From: Ben Dooks <ben-linux@fluff.org>
Subject: SM501: Ensure panel interface is not tristated
	when setup
Date: Tue, 10 Jul 2007 10:02:30 +0100
Message-ID: <20070710090230.GA3691@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8BcI-0000yy-D8 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:02:42 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I8BcH-0004Oy-KQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:02:42 -0700
Content-Disposition: inline
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

When we setup the panel interface whilst configuring the
framebuffer, we should ensure the panel interface is not
in tristate, in case the bootloader or previous setup has
not enabled it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.21-quilt9/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.21-quilt9.orig/drivers/video/sm501fb.c	2007-06-20 14:25:59.000000000 +0100
+++ linux-2.6.21-quilt9/drivers/video/sm501fb.c	2007-06-20 14:37:06.000000000 +0100
@@ -777,6 +777,11 @@ static int sm501fb_set_par_pnl(struct fb
 	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
 	sm501fb_sync_regs(fbi);
 
+	/* ensure the panel interface is not tristated at this point */
+
+	sm501_modify_reg(fbi->dev->parent, SM501_SYSTEM_CONTROL,
+			 0, SM501_SYSCTRL_PANEL_TRISTATE);
+
 	/* power the panel up */
 	sm501fb_panel_power(fbi, 1);
 	return 0;
Index: linux-2.6.21-quilt9/include/linux/sm501-regs.h
===================================================================
--- linux-2.6.21-quilt9.orig/include/linux/sm501-regs.h	2007-06-20 14:25:59.000000000 +0100
+++ linux-2.6.21-quilt9/include/linux/sm501-regs.h	2007-06-20 14:36:27.000000000 +0100
@@ -15,6 +15,24 @@
 
 /* config 1 */
 #define SM501_SYSTEM_CONTROL 		(0x000000)
+
+#define SM501_SYSCTRL_PANEL_TRISTATE	(1<<0)
+#define SM501_SYSCTRL_MEM_TRISTATE	(1<<1)
+#define SM501_SYSCTRL_CRT_TRISTATE	(1<<2)
+
+#define SM501_SYSCTRL_PCI_SLAVE_BURST_MASK (3<<4)
+#define SM501_SYSCTRL_PCI_SLAVE_BURST_1	(0<<4)
+#define SM501_SYSCTRL_PCI_SLAVE_BURST_2	(1<<4)
+#define SM501_SYSCTRL_PCI_SLAVE_BURST_4	(2<<4)
+#define SM501_SYSCTRL_PCI_SLAVE_BURST_8	(3<<4)
+
+#define SM501_SYSCTRL_PCI_CLOCK_RUN_EN	(1<<6)
+#define SM501_SYSCTRL_PCI_RETRY_DISABLE	(1<<7)
+#define SM501_SYSCTRL_PCI_SUBSYS_LOCK	(1<<11)
+#define SM501_SYSCTRL_PCI_BURST_READ_EN	(1<<15)
+
+/* miscellaneous control */
+
 #define SM501_MISC_CONTROL		(0x000004)
 
 #define SM501_MISC_BUS_SH		(0x0)



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
