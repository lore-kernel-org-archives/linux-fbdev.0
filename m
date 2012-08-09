From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 09 Aug 2012 01:54:54 +0000
Subject: [PATCHv2 2/8] rtc: vt8500: Add devicetree support for vt8500-rtc
Message-Id: <1344477300-25251-3-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/rtc/rtc-vt8500.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index 9e94fb1..07bf193 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -23,6 +23,7 @@
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 /*
  * Register definitions
@@ -302,12 +303,18 @@ static int __devexit vt8500_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "via,vt8500-rtc", },
+	{}
+};
+
 static struct platform_driver vt8500_rtc_driver = {
 	.probe		= vt8500_rtc_probe,
 	.remove		= __devexit_p(vt8500_rtc_remove),
 	.driver		= {
 		.name	= "vt8500-rtc",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
@@ -315,5 +322,5 @@ module_platform_driver(vt8500_rtc_driver);
 
 MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("VIA VT8500 SoC Realtime Clock Driver (RTC)");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:vt8500-rtc");
-- 
1.7.9.5

