From: Enric Balletbo i Serra <eballetbo@gmail.com>
Date: Sun, 29 Nov 2015 16:29:46 +0000
Subject: [PATCH v2] backlight: tps65217_bl: Add MODULE_DEVICE_TABLE.
Message-Id: <1448814586-17117-1-git-send-email-enric.balletbo@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The device table is required to load modules based on modaliases.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since last version:
- Use of_match_ptr (Lee Jones)

 drivers/video/backlight/tps65217_bl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
index 61d72bf..fd524ad 100644
--- a/drivers/video/backlight/tps65217_bl.c
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -320,10 +320,19 @@ static int tps65217_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id tps65217_bl_of_match[] = {
+	{ .compatible = "ti,tps65217-bl", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, tps65217_bl_of_match);
+#endif
+
 static struct platform_driver tps65217_bl_driver = {
 	.probe		= tps65217_bl_probe,
 	.driver		= {
 		.name	= "tps65217-bl",
+		.of_match_table = of_match_ptr(tps65217_bl_of_match),
 	},
 };
 
-- 
2.1.0

