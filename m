From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 02 Mar 2017 01:31:01 +0000
Subject: [PATCH] video: fbdev: i810: remove incorrect __exit markups
Message-Id: <20170302013101.GA2047@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index 483ab2592d0c..2488baab7c89 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -81,7 +81,7 @@ static u32 voffset;
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 static int i810fb_init_pci(struct pci_dev *dev,
 			   const struct pci_device_id *entry);
-static void __exit i810fb_remove_pci(struct pci_dev *dev);
+static void i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
 static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
 
@@ -128,7 +128,7 @@ static struct pci_driver i810fb_driver = {
 	.name     =	"i810fb",
 	.id_table =	i810fb_pci_tbl,
 	.probe    =	i810fb_init_pci,
-	.remove   =	__exit_p(i810fb_remove_pci),
+	.remove   =	i810fb_remove_pci,
 	.suspend  =     i810fb_suspend,
 	.resume   =     i810fb_resume,
 };
@@ -2123,7 +2123,7 @@ static void i810fb_release_resource(struct fb_info *info,
 
 }
 
-static void __exit i810fb_remove_pci(struct pci_dev *dev)
+static void i810fb_remove_pci(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry
