From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 17 Jun 2015 11:36:42 +0000
Subject: [PATCH v2 3/9] staging: sm7xxfb: add newline
Message-Id: <1434540288-8289-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

new line was missing in some of the dev_* macros while printing
the debug and error messages.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 5667fbf..f18fef9 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -741,7 +741,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	int err;
 	unsigned long mmio_base;
 
-	dev_info(&pdev->dev, "Silicon Motion display driver.");
+	dev_info(&pdev->dev, "Silicon Motion display driver.\n");
 
 	err = pci_enable_device(pdev);	/* enable SMTC chip */
 	if (err)
@@ -815,12 +815,12 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 #ifdef __BIG_ENDIAN
 		if (sfb->fb->var.bits_per_pixel = 32) {
 			sfb->lfb += 0x800000;
-			dev_info(&pdev->dev, "sfb->lfb=%p", sfb->lfb);
+			dev_info(&pdev->dev, "sfb->lfb=%p\n", sfb->lfb);
 		}
 #endif
 		if (!smtc_regbaseaddress) {
 			dev_err(&pdev->dev,
-				"%s: unable to map memory mapped IO!",
+				"%s: unable to map memory mapped IO!\n",
 				sfb->fb->fix.id);
 			err = -ENOMEM;
 			goto failed_fb;
@@ -854,7 +854,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		break;
 	default:
 		dev_err(&pdev->dev,
-			"No valid Silicon Motion display chip was detected!");
+			"No valid Silicon Motion display chip was detected!\n");
 
 		goto failed_fb;
 	}
@@ -876,14 +876,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		goto failed;
 
 	dev_info(&pdev->dev,
-		 "Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init Complete.",
+		 "Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init Complete.\n",
 		 sfb->chip_id, sfb->chip_rev_id, sfb->fb->var.xres,
 		 sfb->fb->var.yres, sfb->fb->var.bits_per_pixel);
 
 	return 0;
 
 failed:
-	dev_err(&pdev->dev, "Silicon Motion, Inc. primary display init fail.");
+	dev_err(&pdev->dev, "Silicon Motion, Inc. primary display init fail.\n");
 
 	smtc_unmap_smem(sfb);
 	smtc_unmap_mmio(sfb);
-- 
1.8.1.2

