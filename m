From: Archit Taneja <archit@ti.com>
Date: Thu, 30 Aug 2012 11:52:41 +0000
Subject: [PATCH v2 19/23] OMAPDSS/OMAPFB: Change dssdev->manager references
Message-Id: <1346326845-16583-20-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

To retrieve the manager pointer via a device, we need to now access it via the
output to which the device is connected. Make this change in the places where
such a reference is made.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/display.c         |   11 +++++++++--
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    7 +++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 5bd957e..07fd1c7 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -349,8 +349,15 @@ void dss_uninit_device(struct platform_device *pdev,
 	while ((attr = display_sysfs_attrs[i++]) != NULL)
 		device_remove_file(&dssdev->dev, attr);
 
-	if (dssdev->manager)
-		dssdev->manager->unset_device(dssdev->manager);
+	if (dssdev->output) {
+		if (dssdev->output->manager) {
+			struct omap_overlay_manager *mgr +					dssdev->output->manager;
+
+			mgr->unset_output(mgr);
+		}
+		dssdev->output->unset_device(dssdev->output);
+	}
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index c6cf372..606b89f 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -599,6 +599,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omap_dss_device *display = fb2display(fbi);
+	struct omap_overlay_manager *mgr;
 
 	union {
 		struct omapfb_update_window_old	uwnd_o;
@@ -786,12 +787,14 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
-		if (!display) {
+		if (!display && !display->output && !display->output->manager) {
 			r = -EINVAL;
 			break;
 		}
 
-		r = display->manager->wait_for_vsync(display->manager);
+		mgr = display->output->manager;
+
+		r = mgr->wait_for_vsync(mgr);
 		break;
 
 	case OMAPFB_WAITFORGO:
-- 
1.7.9.5

