From: Evgeny Novikov <novikov@ispras.ru>
Date: Mon, 13 Jul 2020 08:05:32 +0000
Subject: [PATCH] fbdev: sm712fb: handle ioremap() errors in probe
Message-Id: <20200713080532.15504-1-novikov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Evgeny Novikov <novikov@ispras.ru>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

smtcfb_pci_probe() does not handle ioremap() errors for case 0x720. The
patch fixes that exactly like for case 0x710/2.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/sm712fb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9e..0171b23fa211 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1602,6 +1602,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		sfb->fb->fix.mmio_start = mmio_base;
 		sfb->fb->fix.mmio_len = 0x00200000;
 		sfb->dp_regs = ioremap(mmio_base, 0x00200000 + smem_size);
+		if (!sfb->dp_regs) {
+			dev_err(&pdev->dev,
+				"%s: unable to map memory mapped IO!\n",
+				sfb->fb->fix.id);
+			err = -ENOMEM;
+			goto failed_fb;
+		}
+
 		sfb->lfb = sfb->dp_regs + 0x00200000;
 		sfb->mmio = (smtc_regbaseaddress  		    sfb->dp_regs + 0x000c0000);
-- 
2.16.4
