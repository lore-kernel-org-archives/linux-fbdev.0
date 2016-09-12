From: Colin King <colin.king@canonical.com>
Date: Mon, 12 Sep 2016 10:24:21 +0000
Subject: [PATCH] video: fbdev: add missing \n at end of printk error message
Message-Id: <20160912102421.25926-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The message is missing a \n, add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/s1d13xxxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 96aa46d..6a271d8 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -929,7 +929,7 @@ static int s1d13xxxfb_suspend(struct platform_device *dev, pm_message_t state)
 		s1dfb->disp_save = kmalloc(info->fix.smem_len, GFP_KERNEL);
 
 	if (!s1dfb->disp_save) {
-		printk(KERN_ERR PFX "no memory to save screen");
+		printk(KERN_ERR PFX "no memory to save screen\n");
 		return -ENOMEM;
 	}
 
-- 
2.9.3

