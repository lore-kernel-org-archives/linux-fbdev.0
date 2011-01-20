From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 20 Jan 2011 03:50:51 +0000
Subject: [PATCH] video: da8xx-fb: fix fb_probe error path
Message-Id: <1295495451.20884.3.camel@mola>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Current implementation puts CONFIG_CPU_FREQ at wrong place, CONFIG_CPU_FREQ
is for lcd_da8xx_cpufreq_deregister not for unregister_framebuffer.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/da8xx-fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index c265aed..520047a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1092,9 +1092,10 @@ static int __init fb_probe(struct platform_device *device)
 
 irq_freq:
 #ifdef CONFIG_CPU_FREQ
+	lcd_da8xx_cpufreq_deregister(par);
+#endif
 err_cpu_freq:
 	unregister_framebuffer(da8xx_fb_info);
-#endif
 
 err_dealloc_cmap:
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
-- 
1.7.2



