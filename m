From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Apr 2017 12:03:03 +0000
Subject: [GIT PULL] fbdev fixes for v4.11-rc6
Message-Id: <2635631.Mn9kkJb8Ue@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170414120309epcas5p2701f4ac334e1281359bfa05f6f82eae2@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev fixes for v4.11-rc6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://github.com/bzolnier/linux.git tags/fbdev-v4.11-rc6

for you to fetch changes up to e68d490def9f7d726eea6dc62ebd692af64ec8b5:

  fbdev: omapfb: delete check_required_callbacks() (2017-04-14 13:38:32 +0200)

----------------------------------------------------------------
fbdev fixes for v4.11-rc6:

- fix probing time checks in omapfb driver (regression fix)
- fix optional VBAT support in ssd1307fb driver (regression fix)
- fix connecting to backend in xen-fbfront driver

----------------------------------------------------------------
Aaro Koskinen (1):
      fbdev: omapfb: delete check_required_callbacks()

Bastian Stender (1):
      fbdev/ssd1307fb: fix optional VBAT support

Juergen Gross (1):
      xen, fbfront: fix connecting to backend

 drivers/video/fbdev/omap/omapfb_main.c | 15 ---------------
 drivers/video/fbdev/ssd1307fb.c        | 24 ++++++++++++++++--------
 drivers/video/fbdev/xen-fbfront.c      |  4 ++--
 3 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 1abba07..f4cbfb3 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1608,19 +1608,6 @@ static int omapfb_find_ctrl(struct omapfb_device *fbdev)
 	return 0;
 }
 
-static void check_required_callbacks(struct omapfb_device *fbdev)
-{
-#define _C(x) (fbdev->ctrl->x != NULL)
-#define _P(x) (fbdev->panel->x != NULL)
-	BUG_ON(fbdev->ctrl = NULL || fbdev->panel = NULL);
-	BUG_ON(!(_C(init) && _C(cleanup) && _C(get_caps) &&
-		 _C(set_update_mode) && _C(setup_plane) && _C(enable_plane) &&
-		 _P(init) && _P(cleanup) && _P(enable) && _P(disable) &&
-		 _P(get_caps)));
-#undef _P
-#undef _C
-}
-
 /*
  * Called by LDM binding to probe and attach a new device.
  * Initialization sequence:
@@ -1705,8 +1692,6 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		omapfb_ops.fb_mmap = omapfb_mmap;
 	init_state++;
 
-	check_required_callbacks(fbdev);
-
 	r = planes_init(fbdev);
 	if (r)
 		goto cleanup;
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index bd017b5..f599520 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -578,10 +578,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	par->vbat_reg = devm_regulator_get_optional(&client->dev, "vbat");
 	if (IS_ERR(par->vbat_reg)) {
-		dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
-			PTR_ERR(par->vbat_reg));
 		ret = PTR_ERR(par->vbat_reg);
-		goto fb_alloc_error;
+		if (ret = -ENODEV) {
+			par->vbat_reg = NULL;
+		} else {
+			dev_err(&client->dev, "failed to get VBAT regulator: %d\n",
+				ret);
+			goto fb_alloc_error;
+		}
 	}
 
 	if (of_property_read_u32(node, "solomon,width", &par->width))
@@ -668,10 +672,13 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		udelay(4);
 	}
 
-	ret = regulator_enable(par->vbat_reg);
-	if (ret) {
-		dev_err(&client->dev, "failed to enable VBAT: %d\n", ret);
-		goto reset_oled_error;
+	if (par->vbat_reg) {
+		ret = regulator_enable(par->vbat_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VBAT: %d\n",
+				ret);
+			goto reset_oled_error;
+		}
 	}
 
 	ret = ssd1307fb_init(par);
@@ -710,7 +717,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		pwm_put(par->pwm);
 	};
 regulator_enable_error:
-	regulator_disable(par->vbat_reg);
+	if (par->vbat_reg)
+		regulator_disable(par->vbat_reg);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
 fb_alloc_error:
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index d0115a7..3ee309c 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -643,7 +643,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-InitWait:
 		xenbus_switch_state(dev, XenbusStateConnected);
 		break;
 
@@ -654,7 +653,8 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 		 * get Connected twice here.
 		 */
 		if (dev->state != XenbusStateConnected)
-			goto InitWait; /* no InitWait seen yet, fudge it */
+			/* no InitWait seen yet, fudge it */
+			xenbus_switch_state(dev, XenbusStateConnected);
 
 		if (xenbus_read_unsigned(info->xbdev->otherend,
 					 "request-update", 0))

