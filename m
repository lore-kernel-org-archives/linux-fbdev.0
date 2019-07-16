From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jul 2019 10:06:47 +0000
Subject: [PATCH 03/10] video: pxafb: Remove cpufreq policy notifier
Message-Id: <e69d47b1d497bdbd8c988754d98714e78ddc0a80.1563270828.git.viresh.kumar@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
get removed soon.

The notifier callback pxafb_freq_policy() isn't doing anything apart
from printing a debug message on CPUFREQ_ADJUST notification. There is
no point in keeping an otherwise empty callback and registering the
notifier.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/pxafb.c | 21 ---------------------
 drivers/video/fbdev/pxafb.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4282cb117b92..f70c9f79622e 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1678,24 +1678,6 @@ pxafb_freq_transition(struct notifier_block *nb, unsigned long val, void *data)
 	}
 	return 0;
 }
-
-static int
-pxafb_freq_policy(struct notifier_block *nb, unsigned long val, void *data)
-{
-	struct pxafb_info *fbi = TO_INF(nb, freq_policy);
-	struct fb_var_screeninfo *var = &fbi->fb.var;
-	struct cpufreq_policy *policy = data;
-
-	switch (val) {
-	case CPUFREQ_ADJUST:
-		pr_debug("min dma period: %d ps, "
-			"new clock %d kHz\n", pxafb_display_dma_period(var),
-			policy->max);
-		/* TODO: fill in min/max values */
-		break;
-	}
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -2400,11 +2382,8 @@ static int pxafb_probe(struct platform_device *dev)
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = pxafb_freq_transition;
-	fbi->freq_policy.notifier_call = pxafb_freq_policy;
 	cpufreq_register_notifier(&fbi->freq_transition,
 				CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_register_notifier(&fbi->freq_policy,
-				CPUFREQ_POLICY_NOTIFIER);
 #endif
 
 	/*
diff --git a/drivers/video/fbdev/pxafb.h b/drivers/video/fbdev/pxafb.h
index b641289c8a99..86b1e9ab1a38 100644
--- a/drivers/video/fbdev/pxafb.h
+++ b/drivers/video/fbdev/pxafb.h
@@ -162,7 +162,6 @@ struct pxafb_info {
 
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	struct notifier_block	freq_policy;
 #endif
 
 	struct regulator *lcd_supply;
-- 
2.21.0.rc0.269.g1a574e7a288b
