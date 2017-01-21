From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 21 Jan 2017 15:16:21 +0000
Subject: [PATCH 1/3] fbdev: omap/lcd: Remove no-op driver callbacks
Message-Id: <1485011783-22521-1-git-send-email-lars@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Every single one of the OMAP fbdev LCD drivers implements no-op remove,
suspend and resume callbacks for their platform_driver. This is not
necessary as the driver core handles the case where the callbacks are not
set just fine. So they are just unnecessary boilerplate that can be
removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 19 -------------------
 drivers/video/fbdev/omap/lcd_h3.c        | 18 ------------------
 drivers/video/fbdev/omap/lcd_htcherald.c | 19 -------------------
 drivers/video/fbdev/omap/lcd_inn1510.c   | 19 -------------------
 drivers/video/fbdev/omap/lcd_inn1610.c   | 19 -------------------
 drivers/video/fbdev/omap/lcd_osk.c       | 18 ------------------
 drivers/video/fbdev/omap/lcd_palmte.c    | 18 ------------------
 drivers/video/fbdev/omap/lcd_palmtt.c    | 18 ------------------
 drivers/video/fbdev/omap/lcd_palmz71.c   | 19 -------------------
 9 files changed, 167 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index f912a20..ef0ed74 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -195,27 +195,8 @@ static int ams_delta_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ams_delta_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int ams_delta_panel_suspend(struct platform_device *pdev,
-		pm_message_t mesg)
-{
-	return 0;
-}
-
-static int ams_delta_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver ams_delta_panel_driver = {
 	.probe		= ams_delta_panel_probe,
-	.remove		= ams_delta_panel_remove,
-	.suspend	= ams_delta_panel_suspend,
-	.resume		= ams_delta_panel_resume,
 	.driver		= {
 		.name	= "lcd_ams_delta",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index 21512b0..a38af2f 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -98,26 +98,8 @@ static int h3_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int h3_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int h3_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int h3_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver h3_panel_driver = {
 	.probe		= h3_panel_probe,
-	.remove		= h3_panel_remove,
-	.suspend	= h3_panel_suspend,
-	.resume		= h3_panel_resume,
 	.driver		= {
 		.name	= "lcd_h3",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_htcherald.c b/drivers/video/fbdev/omap/lcd_htcherald.c
index 8b4dfa0..a2ca5e9 100644
--- a/drivers/video/fbdev/omap/lcd_htcherald.c
+++ b/drivers/video/fbdev/omap/lcd_htcherald.c
@@ -88,27 +88,8 @@ static int htcherald_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int htcherald_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int htcherald_panel_suspend(struct platform_device *pdev,
-						pm_message_t mesg)
-{
-	return 0;
-}
-
-static int htcherald_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver htcherald_panel_driver = {
 	.probe		= htcherald_panel_probe,
-	.remove		= htcherald_panel_remove,
-	.suspend	= htcherald_panel_suspend,
-	.resume		= htcherald_panel_resume,
 	.driver		= {
 		.name	= "lcd_htcherald",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index 49907fa..a549337 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -83,27 +83,8 @@ static int innovator1510_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int innovator1510_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int innovator1510_panel_suspend(struct platform_device *pdev,
-				       pm_message_t mesg)
-{
-	return 0;
-}
-
-static int innovator1510_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver innovator1510_panel_driver = {
 	.probe		= innovator1510_panel_probe,
-	.remove		= innovator1510_panel_remove,
-	.suspend	= innovator1510_panel_suspend,
-	.resume		= innovator1510_panel_resume,
 	.driver		= {
 		.name	= "lcd_inn1510",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
index 8b42894..7319563 100644
--- a/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c
@@ -104,27 +104,8 @@ static int innovator1610_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int innovator1610_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int innovator1610_panel_suspend(struct platform_device *pdev,
-				       pm_message_t mesg)
-{
-	return 0;
-}
-
-static int innovator1610_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver innovator1610_panel_driver = {
 	.probe		= innovator1610_panel_probe,
-	.remove		= innovator1610_panel_remove,
-	.suspend	= innovator1610_panel_suspend,
-	.resume		= innovator1610_panel_resume,
 	.driver		= {
 		.name	= "lcd_inn1610",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index b56886c..3f4a18b 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -103,26 +103,8 @@ static int osk_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int osk_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int osk_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int osk_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver osk_panel_driver = {
 	.probe		= osk_panel_probe,
-	.remove		= osk_panel_remove,
-	.suspend	= osk_panel_suspend,
-	.resume		= osk_panel_resume,
 	.driver		= {
 		.name	= "lcd_osk",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
index 2713fed..c0cee37 100644
--- a/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c
@@ -81,26 +81,8 @@ static int palmte_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int palmte_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int palmte_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int palmte_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver palmte_panel_driver = {
 	.probe		= palmte_panel_probe,
-	.remove		= palmte_panel_remove,
-	.suspend	= palmte_panel_suspend,
-	.resume		= palmte_panel_resume,
 	.driver		= {
 		.name	= "lcd_palmte",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
index 1a936d5..621952b 100644
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -87,26 +87,8 @@ static int palmtt_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int palmtt_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int palmtt_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int palmtt_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver palmtt_panel_driver = {
 	.probe		= palmtt_panel_probe,
-	.remove		= palmtt_panel_remove,
-	.suspend	= palmtt_panel_suspend,
-	.resume		= palmtt_panel_resume,
 	.driver		= {
 		.name	= "lcd_palmtt",
 	},
diff --git a/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
index a20db4f..ccb556d 100644
--- a/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c
@@ -82,27 +82,8 @@ static int palmz71_panel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int palmz71_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int palmz71_panel_suspend(struct platform_device *pdev,
-				 pm_message_t mesg)
-{
-	return 0;
-}
-
-static int palmz71_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver palmz71_panel_driver = {
 	.probe		= palmz71_panel_probe,
-	.remove		= palmz71_panel_remove,
-	.suspend	= palmz71_panel_suspend,
-	.resume		= palmz71_panel_resume,
 	.driver		= {
 		.name	= "lcd_palmz71",
 	},
-- 
2.1.4

