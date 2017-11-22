From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 22 Nov 2017 22:49:20 +0000
Subject: [PATCH V2 25/29] video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
Message-Id: <1511390964-9979-26-git-send-email-okaya@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Find the domain number from pdev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/intelfb/intelfbhw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index d31ed4e..f695867 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -181,7 +181,9 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
 		return 1;
 
 	/* Find the bridge device.  It is always 0:0.0 */
-	if (!(bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0)))) {
+	bridge_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus), 0,
+						 PCI_DEVFN(0, 0));
+	if (!bridge_dev) {
 		ERR_MSG("cannot find bridge device\n");
 		return 1;
 	}
-- 
1.9.1

