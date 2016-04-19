From: Eric Anholt <eric@anholt.net>
Date: Tue, 19 Apr 2016 19:19:25 +0000
Subject: [PATCH] simplefb: Disable at runtime when a native driver (vc4) is present.
Message-Id: <1461093565-18631-1-git-send-email-eric@anholt.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

With simplefb and vc4 both enabled, simplefb would probe first and be
fb0, displaying for a moment before vc4 probed fb1 and reconfigured
the graphics hardware so that only its fbdev worked.

Cc: javier@osg.samsung.com

Signed-off-by: Eric Anholt <eric@anholt.net>
---

Ccing Javier, since it looks like Exynos has also had this trouble,
and may want to get some compatible string in the list.

 drivers/video/fbdev/simplefb.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index e9cf19977285..a2971aa686f5 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -512,11 +512,44 @@ static struct platform_driver simplefb_driver = {
 	.remove = simplefb_remove,
 };
 
+/* Returns true if a simplefb node that's present should be ignored.
+ *
+ * The U-Boot bootloader, and possibly others, may add a simplefb
+ * device node to the existing device tree based on the video
+ * configuration initialized by the firmware.  If we have a native
+ * driver for graphics, then simplefb would just be writing into
+ * memory that's no longer being scanned out.
+ */
+static bool
+simplefb_superseded(void)
+{
+	static const char *compats[] __initconst = {
+#ifdef CONFIG_DRM_VC4
+		"brcm,bcm2835-vc4",
+#endif
+	};
+	struct device_node *node;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(compats); i++) {
+		node = of_find_compatible_node(NULL, NULL, compats[i]);
+		if (node) {
+			of_node_put(node);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int __init simplefb_init(void)
 {
 	int ret;
 	struct device_node *np;
 
+	if (simplefb_superseded())
+		return 0;
+
 	ret = platform_driver_register(&simplefb_driver);
 	if (ret)
 		return ret;
-- 
2.8.0.rc3

