From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 07 Jul 2015 08:26:34 +0000
Subject: [PATCH 2/5] staging: sm7xxfb: fix error handling
Message-Id: <1436256877-10754-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

We were checking smtc_regbaseaddress and that too at a place where it
can never be NULL. Real check should be on sfb->lfb immediately after
we do ioremap.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 2ff4fe7..8fb62af 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -1456,6 +1456,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 #else
 		sfb->lfb = ioremap(mmio_base, 0x00800000);
 #endif
+		if (!sfb->lfb) {
+			dev_err(&pdev->dev,
+				"%s: unable to map memory mapped IO!\n",
+				sfb->fb->fix.id);
+			err = -ENOMEM;
+			goto failed_fb;
+		}
+
 		sfb->mmio = (smtc_regbaseaddress  		    sfb->lfb + 0x00700000);
 		sfb->dp_regs = sfb->lfb + 0x00408000;
@@ -1466,13 +1474,6 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 			dev_info(&pdev->dev, "sfb->lfb=%p\n", sfb->lfb);
 		}
 #endif
-		if (!smtc_regbaseaddress) {
-			dev_err(&pdev->dev,
-				"%s: unable to map memory mapped IO!\n",
-				sfb->fb->fix.id);
-			err = -ENOMEM;
-			goto failed_fb;
-		}
 
 		/* set MCLK = 14.31818 * (0x16 / 0x2) */
 		smtc_seqw(0x6a, 0x16);
-- 
1.8.1.2

