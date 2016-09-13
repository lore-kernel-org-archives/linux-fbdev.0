From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 13 Sep 2016 05:53:46 +0000
Subject: [PATCH] video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device
Message-Id: <1473746026-11695-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently the offb module will use the PCI VGA device as frame
buffer device without calling something like pci_enable_device().
However, this would cause some problem if we disable memory
decoding of the upstream bridge before. When the console driver
issued memory access to the VGA device, the access cannot be
supported by the bridge which will cause EEH error on Power machine.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/video/fbdev/offb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index fb60a8f..906c6e7 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -625,6 +625,21 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	if (address = OF_BAD_ADDR && addr_prop)
 		address = (u64)addr_prop;
 	if (address != OF_BAD_ADDR) {
+#ifdef CONFIG_PCI
+		const __be32 *vidp, *didp;
+		u32 vid, did;
+		struct pci_dev *pdev;
+
+		vidp = of_get_property(dp, "vendor-id", NULL);
+		didp = of_get_property(dp, "device-id", NULL);
+		if (vidp && didp) {
+			vid = be32_to_cpup(vidp);
+			did = be32_to_cpup(didp);
+			pdev = pci_get_device(vid, did, NULL);
+			if (!pdev || pci_enable_device(pdev))
+				return;
+		}
+#endif
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") = 0)
 			address += 0x1000;
-- 
1.8.3.1

