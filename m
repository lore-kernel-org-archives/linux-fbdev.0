From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32: uninorth-agp suspend support
Date: Tue, 01 Mar 2005 15:25:40 +1100
Message-ID: <1109651140.7669.17.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5yyk-000656-4Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:27:26 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D5yyi-000184-1v
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:27:26 -0800
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

(This is for -mm, to be merged along with the aty128fb and radeonfb
related patches).

This patch adds suspend/resume support to the Apple UniNorth AGP bridge
to make sure AGP is properly disabled when the machine goes to sleep.
Without this, the r300 based laptops will fail to wakeup from sleep when
using the new experimental r300 DRI driver. It should also improve
reliablility in general with other chips.

Unfortunately, uninorth-agp is just a "sibling" of the video chip on the
PCI bus, and thus ends up beeing called either before the video chip
suspend routine, or after, depending on the HW layout or other random
things.

To make sure the device side of AGP is always disabled first and that we
never touch the device after having put it into D2 state (which can be
deadly), I also need the separate patch to radeonfb and aty128fb which
will make them disabled their own side if not already done by the bridge
driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-work.orig/drivers/char/agp/uninorth-agp.c	2005-03-01 13:53:32.000000000 +1100
+++ linux-work/drivers/char/agp/uninorth-agp.c	2005-03-01 14:36:54.000000000 +1100
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
+#include <linux/delay.h>
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
 #include "agp.h"
@@ -51,6 +52,11 @@
 
 static void uninorth_cleanup(void)
 {
+	u32 tmp;
+
+	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, &tmp);
+	if (!(tmp & UNI_N_CFG_GART_ENABLE))
+		return;
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
 			UNI_N_CFG_GART_ENABLE | UNI_N_CFG_GART_INVAL);
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
@@ -155,6 +161,56 @@
 	uninorth_tlbflush(NULL);
 }
 
+#ifdef CONFIG_PM
+static int agp_uninorth_suspend(struct pci_dev *pdev, u32 state)
+{
+	u32 cmd;
+	u8 agp;
+	struct pci_dev *device = NULL;
+
+	/* turn off AGP on the video chip, if it was enabled */
+	for_each_pci_dev(device) {
+		/* Don't touch the bridge yet, device first */
+		if (device == pdev)
+			continue;
+		/* Only deal with devices on the same bus here, no Mac has a P2P
+		 * bridge on the AGP port, and mucking around the entire PCI tree
+		 * is source of problems on some machines because of a bug in
+		 * some versions of pci_find_capability() when hitting a dead device
+		 */
+		if (device->bus != pdev->bus)
+			continue;
+		agp = pci_find_capability(device, PCI_CAP_ID_AGP);
+		if (!agp)
+			continue;
+		pci_read_config_dword(device, agp + PCI_AGP_COMMAND, &cmd);
+		if (!(cmd & PCI_AGP_COMMAND_AGP))
+			continue;
+		printk("uninorth-agp: disabling AGP on device %s\n", pci_name(device));
+		cmd &= ~PCI_AGP_COMMAND_AGP;
+		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, cmd);
+	}
+	
+	/* turn off AGP on the bridge */
+	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
+	pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
+	if (cmd & PCI_AGP_COMMAND_AGP) {
+		printk("uninorth-agp: disabling AGP on bridge %s\n", pci_name(pdev));
+		cmd &= ~PCI_AGP_COMMAND_AGP;
+		pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND, cmd);
+	}
+	/* turn off the GART */
+	uninorth_cleanup();
+
+	return 0;
+}
+
+static int agp_uninorth_resume(struct pci_dev *pdev)
+{
+	return 0;
+}
+#endif
+
 static int uninorth_create_gatt_table(void)
 {
 	char *table;
@@ -369,6 +425,10 @@
 	.id_table	= agp_uninorth_pci_table,
 	.probe		= agp_uninorth_probe,
 	.remove		= agp_uninorth_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_uninorth_suspend,
+	.resume		= agp_uninorth_resume,
+#endif
 };
 
 static int __init agp_uninorth_init(void)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
