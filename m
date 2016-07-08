From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 08 Jul 2016 22:19:51 +0000
Subject: [PATCH] backlight: adp5520: fix error handling in adp5520_bl_probe()
Message-Id: <1468016392-6061-1-git-send-email-khoroshilov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If adp5520_bl_setup() fails, sysfs group left unremoved.

By the way, fix overcomplicated assignement of error code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/video/backlight/adp5520_bl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index dd88ba1d71ce..35373e2065b2 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -332,10 +332,18 @@ static int adp5520_bl_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, bl);
-	ret |= adp5520_bl_setup(bl);
+	ret = adp5520_bl_setup(bl);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup\n");
+		if (data->pdata->en_ambl_sens)
+			sysfs_remove_group(&bl->dev.kobj,
+					&adp5520_bl_attr_group);
+		return ret;
+	}
+
 	backlight_update_status(bl);
 
-	return ret;
+	return 0;
 }
 
 static int adp5520_bl_remove(struct platform_device *pdev)
-- 
1.9.1

