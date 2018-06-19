From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 19 Jun 2018 17:22:21 +0000
Subject: [PATCH] video: fbdev: simplefb: Stop including <linux/clk-provider.h>
Message-Id: <20180619172221.20252-1-geert+renesas@glider.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org

Simplefb is not a clock provider, but it uses of_clk_get_parent_count(),
so it can just include <linux/of_clk.h> instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ecf4523e8ed..9a9d748b07f2777d 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -27,8 +27,8 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
 #include <linux/regulator/consumer.h>
-- 
2.17.1

