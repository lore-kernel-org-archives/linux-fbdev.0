From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 07 Jul 2011 10:20:37 +0000
Subject: [PATCH] video: s3c2410: remove unused variable
Message-Id: <1310034037-5090-1-git-send-email-w.sang@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes:

drivers/video/s3c2410fb.c: In function 's3c2410fb_cpufreq_transition':
drivers/video/s3c2410fb.c:770:24: warning: unused variable 'freqs'

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/video/s3c2410fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 0aa1376..798144a 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -767,7 +767,6 @@ static irqreturn_t s3c2410fb_irq(int irq, void *dev_id)
 static int s3c2410fb_cpufreq_transition(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
-	struct cpufreq_freqs *freqs = data;
 	struct s3c2410fb_info *info;
 	struct fb_info *fbinfo;
 	long delta_f;
-- 
1.7.5.4

