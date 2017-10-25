From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:52 +0000
Subject: [RFC 04/14] bootsplash: Redraw on suspend/hibernate
Message-Id: <20171025124602.28292-5-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

When the system is woken from sleep or restored after hibernating, we
cannot expect the screen contents to still be present in VRAM. Thus,
we have to redraw the splash if we're currently active.

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/video/fbdev/core/bootsplash.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/video/fbdev/core/bootsplash.c b/drivers/video/fbdev/core/bootsplash.c
index 8f1c1c165401..e98c05dd8bc0 100644
--- a/drivers/video/fbdev/core/bootsplash.c
+++ b/drivers/video/fbdev/core/bootsplash.c
@@ -242,9 +242,31 @@ static struct attribute *splash_dev_attrs[] = {
 ATTRIBUTE_GROUPS(splash_dev);
 
 
+
+
+/*
+ * Power management fixup via platform device
+ */
+
+static int splash_resume(struct device *device)
+{
+	if (bootsplash_would_render_now())
+		queue_work(splash_global.wq, &splash_work_redraw_vc);
+
+	return 0;
+}
+
+
+static const struct dev_pm_ops splash_pm_ops = {
+	.thaw = splash_resume,
+	.restore = splash_resume,
+	.resume = splash_resume,
+};
+
 static struct platform_driver splash_driver = {
 	.driver = {
 		.name = "bootsplash",
+		.pm = &splash_pm_ops,
 	},
 };
 
-- 
2.12.3

