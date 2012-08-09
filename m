From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 09 Aug 2012 01:54:55 +0000
Subject: [PATCHv2 3/8] serial: vt8500: Add devicetree support for vt8500-serial
Message-Id: <1344477300-25251-4-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..dee6715 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * UART Register offsets
@@ -603,12 +604,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "via,vt8500-uart", },
+	{}
+};
+
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
 	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
@@ -642,4 +649,4 @@ module_exit(vt8500_serial_exit);
 
 MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("Driver for vt8500 serial device");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

