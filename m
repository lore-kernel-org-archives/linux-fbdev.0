From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 28 Mar 2015 09:15:40 +0000
Subject: [PATCH 1/2] staging: sm7xxfb: reserve PCI resource
Message-Id: <1427533421-9751-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

before starting to access any address inside the PCI region we should
reserve the resource and release the resource when the module exits.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 5b3e614..149286e 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -776,6 +776,12 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
+	err = pci_request_region(pdev, 0, "sm7xxfb");
+	if (err < 0) {
+		dev_err(&pdev->dev, "cannot reserve framebuffer region\n");
+		goto failed_regions;
+	}
+
 	sprintf(smtcfb_fix.id, "sm%Xfb", ent->device);
 
 	sfb = smtc_alloc_fb_info(pdev);
@@ -905,6 +911,9 @@ failed_fb:
 	smtc_free_fb_info(sfb);
 
 failed_free:
+	pci_release_region(pdev, 0);
+
+failed_regions:
 	pci_disable_device(pdev);
 
 	return err;
@@ -933,6 +942,7 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
 	smtc_unmap_mmio(sfb);
 	unregister_framebuffer(&sfb->fb);
 	smtc_free_fb_info(sfb);
+	pci_release_region(pdev, 0);
 }
 
 #ifdef CONFIG_PM
-- 
1.8.1.2

