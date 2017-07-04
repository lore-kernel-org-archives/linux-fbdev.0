From: Lynn Lei <lynnl.yet@gmail.com>
Date: Tue, 04 Jul 2017 15:24:38 +0000
Subject: [PATCH 4/4] video: fbdev: sm712fb.c: fixed constant-left comparison warning
Message-Id: <20170704152438.GA30443@lynnl.yet>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed a constant-left comparison warning issue check by
scripts/checkpatch.pl:
  WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 172e94146878..502d0de2feec 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1478,7 +1478,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* can support 32 bpp */
-	if (15 = sfb->fb->var.bits_per_pixel)
+	if (sfb->fb->var.bits_per_pixel = 15)
 		sfb->fb->var.bits_per_pixel = 16;
 
 	sfb->fb->var.xres_virtual = sfb->fb->var.xres;
-- 
2.13.2

