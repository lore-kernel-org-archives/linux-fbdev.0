From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Fri, 02 Apr 2010 11:59:34 +0000
Subject: [PATCH v2 5/5] fbdev: section cleanup in w100fb
Message-Id: <1270209574-31890-5-git-send-email-henne@nachtwindheim.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch cleans up the section in the w100fb driver, by moving:

*	w100fb_remove() from .text to .devexit.text

*	w100_get_xtal_table() from .text to .devinit.text

*	w100fb_init() from .devinit.text to .init.text

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---
 drivers/video/w100fb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 5d22395..a37a46c 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -52,7 +52,7 @@ static void w100_update_enable(void);
 static void w100_update_disable(void);
 static void calc_hsync(struct w100fb_par *par);
 static void w100_init_graphic_engine(struct w100fb_par *par);
-struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
+struct w100_pll_info *w100_get_xtal_table(unsigned int freq) __devinit;
 
 /* Pseudo palette size */
 #define MAX_PALETTES      16
@@ -781,7 +781,7 @@ out:
 }
 
 
-static int w100fb_remove(struct platform_device *pdev)
+static int __devexit w100fb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
@@ -1019,7 +1019,7 @@ static struct pll_entries {
 	{ 0 },
 };
 
-struct w100_pll_info *w100_get_xtal_table(unsigned int freq)
+struct w100_pll_info __devinit *w100_get_xtal_table(unsigned int freq)
 {
 	struct pll_entries *pll_entry = w100_pll_tables;
 
@@ -1610,7 +1610,7 @@ static void w100_vsync(void)
 
 static struct platform_driver w100fb_driver = {
 	.probe		= w100fb_probe,
-	.remove		= w100fb_remove,
+	.remove		= __devexit_p(w100fb_remove),
 	.suspend	= w100fb_suspend,
 	.resume		= w100fb_resume,
 	.driver		= {
@@ -1618,7 +1618,7 @@ static struct platform_driver w100fb_driver = {
 	},
 };
 
-int __devinit w100fb_init(void)
+int __init w100fb_init(void)
 {
 	return platform_driver_register(&w100fb_driver);
 }
-- 
1.7.0

