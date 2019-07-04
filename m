From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 04 Jul 2019 08:46:14 +0000
Subject: [PATCH 08/11] video: fbdev: w100fb: convert platform driver to use dev_groups
Message-Id: <20190704084617.3602-9-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/w100fb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 696106ecdff0..4be3afcc1c93 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -168,6 +168,15 @@ static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *att
 
 static DEVICE_ATTR_RW(fastpllclk);
 
+static struct attribute *w100fb_attrs[] = {
+	&dev_attr_fastpllclk.attr,
+	&dev_attr_reg_read.attr,
+	&dev_attr_reg_write.attr,
+	&dev_attr_flip.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(w100fb);
+
 /*
  * Some touchscreens need hsync information from the video driver to
  * function correctly. We export it here.
@@ -756,14 +765,6 @@ int w100fb_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	err = device_create_file(&pdev->dev, &dev_attr_fastpllclk);
-	err |= device_create_file(&pdev->dev, &dev_attr_reg_read);
-	err |= device_create_file(&pdev->dev, &dev_attr_reg_write);
-	err |= device_create_file(&pdev->dev, &dev_attr_flip);
-
-	if (err != 0)
-		fb_warn(info, "failed to register attributes (%d)\n", err);
-
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 out:
@@ -788,11 +789,6 @@ static int w100fb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
 
-	device_remove_file(&pdev->dev, &dev_attr_fastpllclk);
-	device_remove_file(&pdev->dev, &dev_attr_reg_read);
-	device_remove_file(&pdev->dev, &dev_attr_reg_write);
-	device_remove_file(&pdev->dev, &dev_attr_flip);
-
 	unregister_framebuffer(info);
 
 	vfree(par->saved_intmem);
@@ -1630,6 +1626,7 @@ static struct platform_driver w100fb_driver = {
 	.driver		= {
 		.name	= "w100fb",
 	},
+	.dev_groups	= w100fb_groups,
 };
 
 module_platform_driver(w100fb_driver);
-- 
2.22.0
