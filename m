From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jun 2016 11:38:26 +0000
Subject: [PATCH 5/5] fbmon: remove unused function argument
Message-Id: <20160616113831.4108439-6-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160616113831.4108439-1-arnd@arndb.de>
In-Reply-To: <20160616113831.4108439-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When building with "make W=1", we get a warning about an
empty stub function that does nothing but reassign its one
of its arguments:

drivers/video/fbdev/core/fbmon.c: In function 'fb_edid_to_monspecs':
drivers/video/fbdev/core/fbmon.c:1497:67: error: parameter 'specs' set but not used [-Werror=unused-but-set-parameter]

We can simply make that function completely empty to avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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

