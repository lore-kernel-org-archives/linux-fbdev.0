From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 13:34:03 +0000
Subject: [PATCH v3 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <1415885645-24613-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
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
Changes in v3:
-Switch to for_each_child_of_node to loop over the nodes under chosen
---
 drivers/video/fbdev/simplefb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index cd96edd..223f230 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -27,6 +27,7 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/of_platform.h>
 
 static struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -385,7 +386,31 @@ static struct platform_driver simplefb_driver = {
 	.probe = simplefb_probe,
 	.remove = simplefb_remove,
 };
-module_platform_driver(simplefb_driver);
+
+static int __init simplefb_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	ret = platform_driver_register(&simplefb_driver);
+	if (ret)
+		return ret;
+
+	for_each_child_of_node(of_chosen, np) {
+		if (of_device_is_compatible(np, "simple-framebuffer"))
+			of_platform_device_create(np, NULL, NULL);
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

