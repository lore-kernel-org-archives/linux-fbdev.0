From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 08:50:08 +0000
Subject: [PATCH v2 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <1415868610-13297-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update simplefb to support the new preferred location for simplefb dt nodes
under /chosen.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--
Changes in v2:
-Make name array larger in case we ever encounter more then 10000 framebuffers
---
 drivers/video/fbdev/simplefb.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index cd96edd..2705af8 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -27,6 +27,7 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/of_platform.h>
 
 static struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -385,7 +386,37 @@ static struct platform_driver simplefb_driver = {
 	.probe = simplefb_probe,
 	.remove = simplefb_remove,
 };
-module_platform_driver(simplefb_driver);
+
+static int __init simplefb_init(void)
+{
+	int i, ret;
+	char name[32];
+	struct device_node *np;
+
+	ret = platform_driver_register(&simplefb_driver);
+	if (ret)
+		return ret;
+
+	for (i = 0; ; i++) {
+		snprintf(name, sizeof(name), "framebuffer%d", i);
+		np = of_find_node_by_name(of_chosen, name);
+		if (!np)
+			break;
+
+		/* of_platform_device_create will check status for us */
+		of_platform_device_create(np, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void __exit simplefb_exit(void)
+{
+	platform_driver_unregister(&simplefb_driver);
+}
+
+module_init(simplefb_init);
+module_exit(simplefb_exit);
 
 MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
 MODULE_DESCRIPTION("Simple framebuffer driver");
-- 
2.1.0

