From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Jul 2015 15:41:41 +0000
Subject: [PATCH] video: fbdev: atmel: fix warning for const return value
Message-Id: <1438011701-18423-1-git-send-email-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

A const on a return value is meaningless and generates a warning on some
versions of gcc:

drivers/video/fbdev/atmel_lcdfb.c:1003: warning: type qualifiers ignored on function return type

This was found on 0-day with avr32 builds with CONFIG_OF enabled, but
it doesn't seem to generate warnings for other arches.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index abadc49..66f4b70 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -999,7 +999,7 @@ static const char *atmel_lcdfb_wiring_modes[] = {
 	[ATMEL_LCDC_WIRING_RGB]	= "RGB",
 };
 
-const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
+int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
 {
 	const char *mode;
 	int err, i;
-- 
2.1.0

