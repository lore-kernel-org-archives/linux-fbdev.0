From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 12 Oct 2013 06:25:23 +0000
Subject: [PATCH] fbdev: fix error return code in metronomefb_probe()
Message-Id: <CAPgLHd-FgU-512ivq_eRPqefqb8-7qGY8aoOATiFNZYn-P_4rg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/metronomefb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index f30150d..0b36160 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -690,7 +690,8 @@ static int metronomefb_probe(struct platform_device *dev)
 		goto err_csum_table;
 	}
 
-	if (board->setup_irq(info))
+	retval = board->setup_irq(info);
+	if (retval)
 		goto err_csum_table;
 
 	retval = metronome_init_regs(par);

