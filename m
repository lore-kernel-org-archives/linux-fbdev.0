From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 23 Jul 2019 06:26:07 +0000
Subject: [PATCH V2 07/10] video: sa1100fb: Remove cpufreq policy notifier
Message-Id: <b8ed154787c6930c9d098fe549fcfe52c82ad762.1563862014.git.viresh.kumar@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Wysocki <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
get removed soon.

The notifier callback sa1100fb_freq_policy() isn't doing anything apart
from printing a debug message on CPUFREQ_ADJUST notification. There is
no point in keeping an otherwise empty callback and registering the
notifier.

Remove it.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/sa1100fb.c | 27 ---------------------------
 drivers/video/fbdev/sa1100fb.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index f7f8dee044b1..ae2bcfee338a 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1005,31 +1005,6 @@ sa1100fb_freq_transition(struct notifier_block *nb, unsigned long val,
 	}
 	return 0;
 }
-
-static int
-sa1100fb_freq_policy(struct notifier_block *nb, unsigned long val,
-		     void *data)
-{
-	struct sa1100fb_info *fbi = TO_INF(nb, freq_policy);
-	struct cpufreq_policy *policy = data;
-
-	switch (val) {
-	case CPUFREQ_ADJUST:
-		dev_dbg(fbi->dev, "min dma period: %d ps, "
-			"new clock %d kHz\n", sa1100fb_min_dma_period(fbi),
-			policy->max);
-		/* todo: fill in min/max values */
-		break;
-	case CPUFREQ_NOTIFY:
-		do {} while(0);
-		/* todo: panic if min/max values aren't fulfilled 
-		 * [can't really happen unless there's a bug in the
-		 * CPU policy verififcation process *
-		 */
-		break;
-	}
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -1242,9 +1217,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
-	fbi->freq_policy.notifier_call = sa1100fb_freq_policy;
 	cpufreq_register_notifier(&fbi->freq_transition, CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_register_notifier(&fbi->freq_policy, CPUFREQ_POLICY_NOTIFIER);
 #endif
 
 	/* This driver cannot be unloaded at the moment */
diff --git a/drivers/video/fbdev/sa1100fb.h b/drivers/video/fbdev/sa1100fb.h
index 7a1a9ca33cec..d0aa33b0b88a 100644
--- a/drivers/video/fbdev/sa1100fb.h
+++ b/drivers/video/fbdev/sa1100fb.h
@@ -64,7 +64,6 @@ struct sa1100fb_info {
 
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	struct notifier_block	freq_policy;
 #endif
 
 	const struct sa1100fb_mach_info *inf;
-- 
2.21.0.rc0.269.g1a574e7a288b
