From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: Disable AGP on suspend
Date: Tue, 01 Mar 2005 15:18:54 +1100
Message-ID: <1109650735.7670.8.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5ysC-0005e5-Th
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:20:40 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D5ysB-0008ST-93
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:20:40 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

(for -mm only for now, need feedback from x86 users)

This patch improves reliability of suspend/resume by making sure AGP is
disabled on the radeon chip before putting it into a suspend state. It
works in conjunction with the uninorth-agp suspend patch, but should
be harmless on machines with a different AGP bridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2005-03-01 14:37:10.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2005-03-01 14:58:44.000000000 +1100
@@ -2400,7 +2400,8 @@
 	 * including PCI config registers, clocks, AGP conf, ...)
 	 */
 	if (suspend) {
-		printk(KERN_DEBUG "radeonfb: switching to D2 state...\n");
+		printk(KERN_DEBUG "radeonfb (%s): switching to D2 state...\n",
+		       pci_name(rinfo->pdev));
 
 		/* Disable dynamic power management of clocks for the
 		 * duration of the suspend/resume process
@@ -2453,7 +2454,8 @@
 			mdelay(500);
 		}
 	} else {
-		printk(KERN_DEBUG "radeonfb: switching to D0 state...\n");
+		printk(KERN_DEBUG "radeonfb (%s): switching to D0 state...\n",
+		       pci_name(rinfo->pdev));
 
 		/* Switch back PCI powermanagment to D0 */
 		mdelay(200);
@@ -2507,6 +2509,7 @@
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
+	u8 agp;
 	int i;
 
 	if (state == pdev->dev.power.power_state)
@@ -2523,7 +2526,8 @@
 	if (state != PM_SUSPEND_MEM)
 		goto done;
 	if (susdisking) {
-		printk("suspending to disk but state = %d\n", state);
+		printk("radeonfb (%s): suspending to disk but state = %d\n",
+		       pci_name(pdev), state);
 		goto done;
 	}
 
@@ -2546,6 +2550,28 @@
 	rinfo->lock_blank = 1;
 	del_timer_sync(&rinfo->lvds_timer);
 
+	/* Disable AGP. The AGP host should have done it, but since ordering
+	 * isn't always properly guaranteed in this specific case, let's make
+	 * sure it's disabled on card side now. Ultimately, when merging fbdev
+	 * and dri into some common infrastructure, this will be handled
+	 * more nicely. The host bridge side will (or will not) be dealt with
+	 * by the bridge AGP driver, we don't attempt to touch it here.
+	 */
+	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
+	if (agp) {
+		u32 cmd;
+
+		pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
+		if (cmd & PCI_AGP_COMMAND_AGP) {
+			printk(KERN_INFO "radeonfb (%s): AGP was enabled, "
+			       "disabling ...\n",
+			       pci_name(pdev));
+			cmd &= ~PCI_AGP_COMMAND_AGP;
+			pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND,
+					       cmd);
+		}
+	}
+
 	/* If we support wakeup from poweroff, we save all regs we can including cfg
 	 * space
 	 */
@@ -2569,12 +2595,11 @@
 			OUTREG(LVDS_PLL_CNTL, (INREG(LVDS_PLL_CNTL) & ~30000) | 0x20000);
 			mdelay(20);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
-
-			// FIXME: Use PCI layer
-			for (i = 0; i < 64; ++i)
-				pci_read_config_dword(rinfo->pdev, i * 4,
-						      &rinfo->cfg_save[i]);
 		}
+		// FIXME: Use PCI layer
+		for (i = 0; i < 64; ++i)
+			pci_read_config_dword(pdev, i * 4, &rinfo->cfg_save[i]);
+		pci_disable_device(pdev);
 	}
 	/* If we support D2, we go to it (should be fixed later with a flag forcing
 	 * D3 only for some laptops)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
