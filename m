From: Yue Haibing <yuehaibing@huawei.com>
Date: Fri, 01 Mar 2019 01:53:42 +0000
Subject: [PATCH -next] fbdev: omap2: omapfb: trivial code cleanup
Message-Id: <20190301015342.28888-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, trivial@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

From: YueHaibing <yuehaibing@huawei.com>

After commit 60d2fa0dad06 ("fbdev: omap2: no need to check
return value of debugfs_create functions"), there are corner
code need to be cleaned.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 7e6a3eb..b5956a1 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
 }
 void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
-	return 0;
 }
 #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
 
@@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
 
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	int r;
-
 	core.pdev = pdev;
 
 	dss_features_init(omapdss_get_version());
-- 
2.7.4
