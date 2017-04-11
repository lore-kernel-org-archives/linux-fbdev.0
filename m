From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 11 Apr 2017 08:43:18 +0000
Subject: [PATCH] efifb: arm/arm64: validate fb BAR instead of claiming it
Message-Id: <1491900198-26187-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Claiming the BAR that matches the framebuffer base address in a PCI
header fixup quirk only works as expected when the PCI device is on
bus 0. If not, it will produce the following error:

pci 0000:01:01.0: can't claim BAR 0 [mem 0x10000000-0x10ffffff pref]:
                                                 no compatible bridge window
pci 0000:01:01.0: BAR 0: failed to claim resource for efifb!

Since claiming the entire path up to the root is non-trivial at this
point, and also undesirable given that we have no way of making sure
that the existing configuration is sound, let's not claim anything at
all, and simply record the resource so we can check that it did not
move when the EFI fb driver is probed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index b827a8113e26..21d635ef5be2 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -146,6 +146,8 @@ ATTRIBUTE_GROUPS(efifb);
 
 static bool pci_dev_disabled;	/* FB base matches BAR of a disabled device */
 
+static struct resource *pci_dev_bar_resource;
+
 static int efifb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
@@ -179,6 +181,20 @@ static int efifb_probe(struct platform_device *dev)
 	}
 	printk(KERN_INFO "efifb: probing for efifb\n");
 
+	if (pci_dev_bar_resource) {
+		u64 base = screen_info.lfb_base;
+		u64 size = screen_info.lfb_size;
+
+		if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+			base |= (u64)screen_info.ext_lfb_base << 32;
+
+		if (pci_dev_bar_resource->start > base ||
+		    pci_dev_bar_resource->end < base + size - 1) {
+			pr_err("efifb: PCI BAR has moved, disabling ...\n");
+			return -ENODEV;
+		}
+	}
+
 	/* just assume they're all unset if any are */
 	if (!screen_info.blue_size) {
 		screen_info.blue_size = 8;
@@ -383,12 +399,7 @@ static void claim_efifb_bar(struct pci_dev *dev, int idx)
 		return;
 	}
 
-	if (pci_claim_resource(dev, idx)) {
-		pci_dev_disabled = true;
-		dev_err(&dev->dev,
-			"BAR %d: failed to claim resource for efifb!\n", idx);
-		return;
-	}
+	pci_dev_bar_resource = dev->resource + idx;
 
 	dev_info(&dev->dev, "BAR %d: assigned to efifb\n", idx);
 }
-- 
2.7.4

