From: rkir@google.com
Date: Mon, 21 May 2018 18:10:15 +0000
Subject: [PATCH] goldfish: Enable ACPI-based enumeration for goldfish framebuffer
Message-Id: <20180521181015.147938-1-rkir@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Yu Ning <yu.ning@intel.com>

Follow the same way in which ACPI was enabled for goldfish battery. See
commit d3be10e for details.

Note that this patch also depends on commit af33cac.

Signed-off-by: Yu Ning <yu.ning@intel.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/video/fbdev/goldfishfb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index de29c4ff77e5..01732858b60d 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 enum {
 	FB_GET_WIDTH        = 0x00,
@@ -312,12 +313,19 @@ static const struct of_device_id goldfish_fb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
 
+static const struct acpi_device_id goldfish_fb_acpi_match[] = {
+	{ "GFSH0004", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_fb_acpi_match);
+
 static struct platform_driver goldfish_fb_driver = {
 	.probe		= goldfish_fb_probe,
 	.remove		= goldfish_fb_remove,
 	.driver = {
 		.name = "goldfish_fb",
 		.of_match_table = goldfish_fb_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_fb_acpi_match),
 	}
 };
 
-- 
2.17.0.441.gb46fe60e1d-goog

