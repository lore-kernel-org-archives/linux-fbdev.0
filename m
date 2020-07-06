From: Evgeny Novikov <novikov@ispras.ru>
Date: Mon, 06 Jul 2020 15:53:28 +0000
Subject: [PATCH] fbdev: sm712fb: set error code in probe
Message-Id: <20200706155328.8396-1-novikov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Evgeny Novikov <novikov@ispras.ru>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

If smtcfb_pci_probe() does not detect a valid chip it cleans up
everything and returns 0. This can result in various bad things later.
The patch sets the error code on the corresponding path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/sm712fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9e..fbe97340b8e0 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1614,7 +1614,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	default:
 		dev_err(&pdev->dev,
 			"No valid Silicon Motion display chip was detected!\n");
-
+		err = -ENODEV;
 		goto failed_fb;
 	}
 
-- 
2.16.4
