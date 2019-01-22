From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 22 Jan 2019 15:21:15 +0000
Subject: [PATCH] fbdev: mbx: fix up debugfs file creation
Message-Id: <20190122152151.16139-16-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

There is no need to keep the dentries around for the individual debugfs
files, just delete the whole directory all at once at shutdown instead.

This also fixes a tiny memory leak where the memory for the pointers to
the file dentries was never freed when the device shut down, as well as
making the logic of the code a lot simpler.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/mbx/mbxdebugfs.c | 40 +++++++++-------------------
 drivers/video/fbdev/mbx/mbxfb.c      |  2 +-
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
index 2bd328883178..52cfe0132b25 100644
--- a/drivers/video/fbdev/mbx/mbxdebugfs.c
+++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
@@ -211,36 +211,22 @@ static const struct file_operations misc_fops = {
 static void mbxfb_debugfs_init(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
-	struct mbxfb_debugfs_data *dbg;
-
-	dbg = kzalloc(sizeof(struct mbxfb_debugfs_data), GFP_KERNEL);
-	mfbi->debugfs_data = dbg;
-
-	dbg->dir = debugfs_create_dir("mbxfb", NULL);
-	dbg->sysconf = debugfs_create_file("sysconf", 0444, dbg->dir,
-				      fbi, &sysconf_fops);
-	dbg->clock = debugfs_create_file("clock", 0444, dbg->dir,
-				    fbi, &clock_fops);
-	dbg->display = debugfs_create_file("display", 0444, dbg->dir,
-				      fbi, &display_fops);
-	dbg->gsctl = debugfs_create_file("gsctl", 0444, dbg->dir,
-				    fbi, &gsctl_fops);
-	dbg->sdram = debugfs_create_file("sdram", 0444, dbg->dir,
-					fbi, &sdram_fops);
-	dbg->misc = debugfs_create_file("misc", 0444, dbg->dir,
-					fbi, &misc_fops);
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("mbxfb", NULL);
+	mbfi->debugfs_dir = dir;
+
+	debugfs_create_file("sysconf", 0444, dir, fbi, &sysconf_fops);
+	debugfs_create_file("clock", 0444, dir, fbi, &clock_fops);
+	debugfs_create_file("display", 0444, dir, fbi, &display_fops);
+	debugfs_create_file("gsctl", 0444, dir, fbi, &gsctl_fops);
+	debugfs_create_file("sdram", 0444, dir, fbi, &sdram_fops);
+	debugfs_create_file("misc", 0444, dir, fbi, &misc_fops);
 }
 
 static void mbxfb_debugfs_remove(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
-	struct mbxfb_debugfs_data *dbg = mfbi->debugfs_data;
-
-	debugfs_remove(dbg->misc);
-	debugfs_remove(dbg->sdram);
-	debugfs_remove(dbg->gsctl);
-	debugfs_remove(dbg->display);
-	debugfs_remove(dbg->clock);
-	debugfs_remove(dbg->sysconf);
-	debugfs_remove(dbg->dir);
+
+	debugfs_remove_recursive(mfbi->debugfs_dir);
 }
diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 539b85da0897..6ded480a69b4 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -74,7 +74,7 @@ struct mbxfb_info {
 
 	u32 pseudo_palette[MAX_PALETTES];
 #ifdef CONFIG_FB_MBX_DEBUG
-	void *debugfs_data;
+	struct dentry *debugfs_dir;
 #endif
 
 };
-- 
2.20.1
