From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 27 Sep 2013 09:50:47 +0000
Subject: [PATCH -next] backlight: lm3630: add missing destroy_workqueue() on error in lm3630a_intr_config()
Message-Id: <CAPgLHd_Sqru87pYM3aB1_57hD0eWX4Rb3huPqjQxX93HRrCQzw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing destroy_workqueue() before return from
lm3630a_intr_config() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index c63f918..0e5d8d3 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -154,6 +154,7 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
 	    (pchip->irq, NULL, lm3630a_isr_func,
 	     IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "lm3630a_irq", pchip)) {
 		dev_err(pchip->dev, "request threaded irq fail\n");
+		destroy_workqueue(pchip->irqthread);
 		return -ENOMEM;
 	}
 	return rval;

