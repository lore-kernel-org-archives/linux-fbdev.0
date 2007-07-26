From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 26/33] sm501fb: Ensure panel interface
 is not tristated when setup
Date: Thu, 26 Jul 2007 20:31:49 +0800
Message-ID: <46A89435.1060704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2vs-0001GQ-0I for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:08 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2vr-0000Ts-P8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:08 -0700
Received: by wa-out-1112.google.com with SMTP id k22so615223waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:59:07 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>

From: Ben Dooks <ben-linux@fluff.org>

When we setup the panel interface whilst configuring the
framebuffer, we should ensure the panel interface is not
in tristate, in case the bootloader or previous setup has
not enabled it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sm501fb.c    |    5 +++++
 include/linux/sm501-regs.h |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index d97edd7..1be95a6 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
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
diff --git a/include/linux/sm501-regs.h b/include/linux/sm501-regs.h
index 014e73b..df7620d 100644
--- a/include/linux/sm501-regs.h
+++ b/include/linux/sm501-regs.h
@@ -15,6 +15,24 @@ #define SM501_SYS_CONFIG		(0x000000)
 
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
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
