From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Aug 2016 15:25:43 +0000
Subject: [PATCH 2/5] video: ARM CLCD: fix endpoint lookup logic
Message-Id: <20160826152546.604384-3-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826152546.604384-1-arnd@arndb.de>
In-Reply-To: <20160826152546.604384-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The addition of the Nomadik support in this driver introduced
a bug in clcdfb_of_init_display(), which now calls init_panel
with an uninitialized 'endpoint' pointer, as "gcc -Wmaybe-uninitialized"
warns:

drivers/video/fbdev/amba-clcd.c: In function 'clcdfb_of_init_display':
drivers/video/fbdev/amba-clcd.c:785:5: error: 'endpoint' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This reverts the broken part of the function to what it was before
the patch, which is the best guess I have to what it should be.
I assume this was left over from an attempted rework of the
code that was partially backed out.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 046ad6cdeb3f ("video: ARM CLCD: support Nomadik variant")
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Cc: linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
 drivers/video/fbdev/amba-clcd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index c342ff370108..ec2671d98abc 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -782,12 +782,9 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	/*
 	 * Fetch the panel endpoint.
 	 */
-	if (!endpoint) {
-		endpoint = of_graph_get_next_endpoint(fb->dev->dev.of_node,
-						      NULL);
-		if (!endpoint)
-			return -ENODEV;
-	}
+	endpoint = of_graph_get_next_endpoint(fb->dev->dev.of_node, NULL);
+	if (!endpoint)
+		return -ENODEV;
 
 	if (fb->vendor->init_panel) {
 		err = fb->vendor->init_panel(fb, endpoint);
-- 
2.9.0

