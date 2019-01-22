From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 22 Jan 2019 15:21:14 +0000
Subject: [PATCH] fbdev: omap2: no need to check return value of debugfs_create functions
Message-Id: <20190122152151.16139-15-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-omap@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 31 ++++-----------------
 drivers/video/fbdev/omap2/omapfb/dss/dss.h  |  2 +-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index b4bcf3a4a647..7e6a3eb266d0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -110,19 +110,12 @@ DEFINE_SHOW_ATTRIBUTE(dss);
 
 static struct dentry *dss_debugfs_dir;
 
-static int dss_initialize_debugfs(void)
+static void dss_initialize_debugfs(void)
 {
 	dss_debugfs_dir = debugfs_create_dir("omapdss", NULL);
-	if (IS_ERR(dss_debugfs_dir)) {
-		int err = PTR_ERR(dss_debugfs_dir);
-		dss_debugfs_dir = NULL;
-		return err;
-	}
 
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
 			&dss_debug_dump_clocks, &dss_fops);
-
-	return 0;
 }
 
 static void dss_uninitialize_debugfs(void)
@@ -130,24 +123,18 @@ static void dss_uninitialize_debugfs(void)
 	debugfs_remove_recursive(dss_debugfs_dir);
 }
 
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
-	struct dentry *d;
-
-	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
-			write, &dss_fops);
-
-	return PTR_ERR_OR_ZERO(d);
+	debugfs_create_file(name, S_IRUGO, dss_debugfs_dir, write, &dss_fops);
 }
 #else /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
-static inline int dss_initialize_debugfs(void)
+static inline void dss_initialize_debugfs(void)
 {
-	return 0;
 }
 static inline void dss_uninitialize_debugfs(void)
 {
 }
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
 	return 0;
 }
@@ -188,9 +175,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	dss_features_init(omapdss_get_version());
 
-	r = dss_initialize_debugfs();
-	if (r)
-		goto err_debugfs;
+	dss_initialize_debugfs();
 
 	if (def_disp_name)
 		core.default_display_name = def_disp_name;
@@ -198,10 +183,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	register_pm_notifier(&omap_dss_pm_notif_block);
 
 	return 0;
-
-err_debugfs:
-
-	return r;
 }
 
 static int omap_dss_remove(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.h b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
index a3cc0ca8f9d2..b1a354494144 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
@@ -214,7 +214,7 @@ struct platform_device *dss_get_core_pdev(void);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
-int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
+void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
 /* display */
 int dss_suspend_all_devices(void);
-- 
2.20.1
