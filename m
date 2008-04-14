From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 3/3] OLPC: gxfb/lxfb: add DCON panel
 modes to framebuffer drivers
Date: Mon, 14 Apr 2008 03:53:02 -0400
Message-ID: <20080414035302.794dcd7a@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlJT1-0007Ru-Af for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 00:51:07 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JlJSv-0004JS-NE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 00:51:02 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com


Since there's no way to autodetect panel modes, we're forced to hardcode
them in the driver and add a big fat #ifdef.  The OLPC DCON needs a
specific mode line (at 1200x900).  This adds it to both gxfb and lxfb.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/gxfb_core.c |   35 ++++++++++++++++++++++++++++++++++-
 drivers/video/geode/lxfb_core.c |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 988c8e4..3e76e06 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -108,6 +108,35 @@ static const struct fb_videomode gx_modedb[] __initdata = {
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 
+#ifdef CONFIG_OLPC
+#include <asm/olpc.h>
+
+static const struct fb_videomode gx_dcon_modedb[] __initdata = {
+	/* The only mode the DCON has is 1200x900 */
+	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, 0 }
+};
+
+static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
+{
+	if (olpc_has_dcon()) {
+		*modedb = (struct fb_videomode *) gx_dcon_modedb;
+		*size = ARRAY_SIZE(gx_dcon_modedb);
+	} else {
+		*modedb = (struct fb_videomode *) gx_modedb;
+		*size = ARRAY_SIZE(gx_modedb);
+	}
+}
+
+#else
+static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
+{
+	*modedb = (struct fb_videomode *) gx_modedb;
+	*size = ARRAY_SIZE(gx_modedb);
+}
+#endif
+
 static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	if (var->xres > 1600 || var->yres > 1200)
@@ -356,6 +385,9 @@ static int __init gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	int ret;
 	unsigned long val;
 
+	struct fb_videomode *modedb_ptr;
+	unsigned int modedb_size;
+
 	info = gxfb_init_fbinfo(&pdev->dev);
 	if (!info)
 		return -ENOMEM;
@@ -375,8 +407,9 @@ static int __init gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	else
 		par->enable_crt = 1;
 
+	get_modedb(&modedb_ptr, &modedb_size);
 	ret = fb_find_mode(&info->var, info, mode_option,
-			   gx_modedb, ARRAY_SIZE(gx_modedb), NULL, 16);
+			   modedb_ptr, modedb_size, NULL, 16);
 	if (ret == 0 || ret == 4) {
 		dev_err(&pdev->dev, "could not find valid video mode\n");
 		ret = -EINVAL;
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index e290981..28fa3c4 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -217,6 +217,35 @@ static const struct fb_videomode geode_modedb[] __initdata = {
 	  0, FB_VMODE_NONINTERLACED, 0 },
 };
 
+#ifdef CONFIG_OLPC
+#include <asm/olpc.h>
+
+const struct fb_videomode olpc_dcon_modedb[] __initdata = {
+	/* The only mode the DCON has is 1200x900 */
+	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, 0 }
+};
+
+static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
+{
+	if (olpc_has_dcon()) {
+		*modedb = (struct fb_videomode *) olpc_dcon_modedb;
+		*size = ARRAY_SIZE(olpc_dcon_modedb);
+	} else {
+		*modedb = (struct fb_videomode *) geode_modedb;
+		*size = ARRAY_SIZE(geode_modedb);
+	}
+}
+
+#else
+static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
+{
+	*modedb = (struct fb_videomode *) geode_modedb;
+	*size = ARRAY_SIZE(geode_modedb);
+}
+#endif
+
 static int lxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	if (var->xres > 1920 || var->yres > 1440)
@@ -480,7 +509,7 @@ static int __init lxfb_probe(struct pci_dev *pdev,
 	int ret;
 
 	struct fb_videomode *modedb_ptr;
-	int modedb_size;
+	unsigned int modedb_size;
 
 	info = lxfb_init_fbinfo(&pdev->dev);
 
@@ -505,9 +534,7 @@ static int __init lxfb_probe(struct pci_dev *pdev,
 
 	/* Set up the mode database */
 
-	modedb_ptr = (struct fb_videomode *) geode_modedb;
-	modedb_size = ARRAY_SIZE(geode_modedb);
-
+	get_modedb(&modedb_ptr, &modedb_size);
 	ret = fb_find_mode(&info->var, info, mode_option,
 			   modedb_ptr, modedb_size, NULL, 16);
 
-- 
1.5.4.4



-- 
Need a kernel or Debian developer?  Contact me, I'm looking for contracts.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
