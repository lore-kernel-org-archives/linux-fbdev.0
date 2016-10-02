From: Edward Lipinsky <ellipinsky@gmail.com>
Date: Sun, 02 Oct 2016 18:05:05 +0000
Subject: [PATCH] staging: sm750fb: Fix printk() style warning
Message-Id: <20161002180505.GA19813@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, sudip@vectorindia.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: printk() should include KERN_ facility level

Signed-off-by: Edward Lipinsky <ellipinsky@gmail.com>
---
 drivers/staging/sm750fb/ddk750_help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index 9637dd3..e72a29c 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -11,7 +11,7 @@ void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
 	devId750 = devId;
 	revId750 = revId;
 	if (revId = 0xfe)
-		printk("found sm750le\n");
+		pr_info("found sm750le\n");
 }
 
 
-- 
2.7.4

