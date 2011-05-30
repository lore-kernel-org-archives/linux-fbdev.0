From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 30 May 2011 03:23:36 +0000
Subject: [PATCH] fbdev: bf537-lq035: add missing blacklight properties type
Message-Id: <1306725816-11120-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Steven Miao <realmz6@gmail.com>

Seems this new field was missed, probably due to this driver being merged
around the time this new backlight field was being added.  At any rate,
initial the type field to avoid ugly WARN() dumps.

Signed-off-by: Steven Miao <realmz6@gmail.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bf537-lq035.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index 47c21fb..bea53c1 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -789,6 +789,7 @@ static int __devinit bfin_lq035_probe(struct platform_device *pdev)
 	i2c_add_driver(&ad5280_driver);
 
 	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
 	props.max_brightness = MAX_BRIGHENESS;
 	bl_dev = backlight_device_register("bf537-bl", NULL, NULL,
 					   &bfin_lq035fb_bl_ops, &props);
-- 
1.7.5.rc3

