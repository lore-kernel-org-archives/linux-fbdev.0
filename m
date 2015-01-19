From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 19 Jan 2015 18:34:58 +0000
Subject: [PATCH 4/9] video: Add check for return value of ioremap() in cirrusfb_pci_register()
Message-Id: <54BD4E52.7000308@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <54BD44F0.3040705@users.sourceforge.net>
In-Reply-To: <54BD44F0.3040705@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 19 Jan 2015 13:18:50 +0100

The return value from a call of the ioremap() function was not checked
by the implementation of the cirrusfb_pci_register() function.
Let us complete the corresponding error detection and exception handling
at this source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/cirrusfb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index d8b3359..aa4050c 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2111,6 +2111,10 @@ static int cirrusfb_pci_register(struct pci_dev *pdev,
 	/* FIXME: this forces VGA.  alternatives? */
 	cinfo->regbase = NULL;
 	cinfo->laguna_mmio = ioremap(info->fix.mmio_start, 0x1000);
+	if (!cinfo->laguna_mmio) {
+		ret = -EIO;
+		goto err_release_fb;
+	}
 
 	dev_dbg(info->device, "Board address: 0x%lx, register address: 0x%lx\n",
 		board_addr, info->fix.mmio_start);
@@ -2122,7 +2126,7 @@ static int cirrusfb_pci_register(struct pci_dev *pdev,
 	if (ret < 0) {
 		dev_err(info->device, "cannot reserve region 0x%lx, abort\n",
 			board_addr);
-		goto err_release_fb;
+		goto io_unmap_laguna;
 	}
 #if 0 /* if the system didn't claim this region, we would... */
 	if (!request_mem_region(0xA0000, 65535, "cirrusfb")) {
@@ -2163,8 +2167,9 @@ err_release_legacy:
 err_release_regions:
 #endif
 	pci_release_regions(pdev);
-err_release_fb:
+io_unmap_laguna:
 	iounmap(cinfo->laguna_mmio);
+err_release_fb:
 	framebuffer_release(info);
 err_out:
 	return ret;
-- 
2.2.2

