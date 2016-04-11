From: Alan <alan@linux.intel.com>
Date: Mon, 11 Apr 2016 13:30:24 +0000
Subject: [PATCH 2/4] goldfish: Enable ACPI-based enumeration for goldfish framebuffer
Message-Id: <20160411133023.23962.51777.stgit@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Yu Ning <yu.ning@intel.com>

Enable ACPI bindings for the Goldfish framebuffer device.

Signed-off-by: Yu Ning <yu.ning@intel.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan <alan@linux.intel.com>
---
 drivers/video/fbdev/goldfishfb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index f0e651b..58b33e4 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 enum {
 	FB_GET_WIDTH        = 0x00,
@@ -310,6 +311,12 @@ static const struct of_device_id goldfish_fb_of_match[] = {
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
@@ -317,6 +324,7 @@ static struct platform_driver goldfish_fb_driver = {
 		.name = "goldfish_fb",
 		.owner = THIS_MODULE,
 		.of_match_table = goldfish_fb_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_fb_acpi_match),
 	}
 };
 

