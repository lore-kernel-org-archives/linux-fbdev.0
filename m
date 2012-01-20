From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 20 Jan 2012 21:25:32 +0000
Subject: [PATCH 4/4] drivers/video/backlight/adp5520_bl.c: use devm_ functions
Message-Id: <1327094732-9050-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327094732-9050-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1327094732-9050-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: kernel-janitors@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, device-drivers-devel@blackfin.uclinux.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/backlight/adp5520_bl.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index 2e630bf..4911ea7 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -289,7 +289,7 @@ static int __devinit adp5520_bl_probe(struct platform_device *pdev)
 	struct adp5520_bl *data;
 	int ret = 0;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (data = NULL)
 		return -ENOMEM;
 
@@ -298,7 +298,6 @@ static int __devinit adp5520_bl_probe(struct platform_device *pdev)
 
 	if (data->pdata  = NULL) {
 		dev_err(&pdev->dev, "missing platform data\n");
-		kfree(data);
 		return -ENODEV;
 	}
 
@@ -314,7 +313,6 @@ static int __devinit adp5520_bl_probe(struct platform_device *pdev)
 				       &adp5520_bl_ops, &props);
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
-		kfree(data);
 		return PTR_ERR(bl);
 	}
 
@@ -326,7 +324,6 @@ static int __devinit adp5520_bl_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register sysfs\n");
 		backlight_device_unregister(bl);
-		kfree(data);
 	}
 
 	platform_set_drvdata(pdev, bl);
@@ -348,7 +345,6 @@ static int __devexit adp5520_bl_remove(struct platform_device *pdev)
 				&adp5520_bl_attr_group);
 
 	backlight_device_unregister(bl);
-	kfree(data);
 
 	return 0;
 }

