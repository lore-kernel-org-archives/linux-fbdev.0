From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Jul 2016 20:32:15 +0000
Subject: [PATCH] fbmon: remove unused function argument
Message-Id: <20160715203229.1771162-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When building with "make W=1", we get a warning about an
empty stub function that does nothing but reassign its one
of its arguments:

drivers/video/fbdev/core/fbmon.c: In function 'fb_edid_to_monspecs':
drivers/video/fbdev/core/fbmon.c:1497:67: error: parameter 'specs' set but not used [-Werror=unused-but-set-parameter]

We can simply make that function completely empty to avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
I sent this patch on June 16 when this warning was only for "make W=1", but
never got a reply from the fbdev maintainers.

Now Andrew merged a patch to have the warning at the default level,
maybe he can apply this as well.
---
 drivers/video/fbdev/core/fbmon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 55e39e822b79..eaa6bab21839 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1496,7 +1496,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 }
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
-	specs = NULL;
 }
 void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
-- 
2.9.0

