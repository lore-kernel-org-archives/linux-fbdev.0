From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Thu, 22 Jun 2017 21:43:34 +0000
Subject: [PATCH] vmlfb: Fix error handling in cr_pll_init()
Message-Id: <1498167814-5178-1-git-send-email-khoroshilov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is an error path, where iomemory is left mapped.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/video/fbdev/vermilion/cr_pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vermilion/cr_pll.c b/drivers/video/fbdev/vermilion/cr_pll.c
index ebc6e6e0dd0f..ba105c876bed 100644
--- a/drivers/video/fbdev/vermilion/cr_pll.c
+++ b/drivers/video/fbdev/vermilion/cr_pll.c
@@ -185,6 +185,7 @@ static int __init cr_pll_init(void)
 	if (err) {
 		printk(KERN_ERR
 		       "Carillo Ranch failed to initialize vml_sys.\n");
+		iounmap(mch_regs_base);
 		pci_dev_put(mch_dev);
 		return err;
 	}
-- 
2.7.4

