From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Thu, 09 Feb 2012 05:16:38 +0000
Subject: [PATCH] video: da8xx-fb: Fix build warning on unused label
Message-Id: <1328763879-16345-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Patch fixes build warning on label "err_cpu_freq" when CONFIG_CPU_FREQ
is not defined.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 29577bf..f360d62 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1264,8 +1264,8 @@ static int __devinit fb_probe(struct platform_device *device)
 irq_freq:
 #ifdef CONFIG_CPU_FREQ
 	lcd_da8xx_cpufreq_deregister(par);
-#endif
 err_cpu_freq:
+#endif
 	unregister_framebuffer(da8xx_fb_info);
 
 err_dealloc_cmap:
-- 
1.7.1

