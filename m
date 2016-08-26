From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Aug 2016 15:32:33 +0000
Subject: [PATCH] video: fbdev: mb862xx: remove unused variable
Message-Id: <20160826153252.722636-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

A cleanup patch that removed some code left behind an unused
variable:

drivers/video/fbdev/mb862xx/mb862xx-i2c.c: In function 'mb862xx_i2c_init':
drivers/video/fbdev/mb862xx/mb862xx-i2c.c:160:6: error: unused variable 'ret' [-Werror=unused-variable]

This removes that variable as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding adapter fails")
---
 drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xx-i2c.c b/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
index 76d206857e3e..ba96c44f2761 100644
--- a/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
+++ b/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
@@ -157,8 +157,6 @@ static struct i2c_adapter mb862xx_i2c_adapter = {
 
 int mb862xx_i2c_init(struct mb862xxfb_par *par)
 {
-	int ret;
-
 	mb862xx_i2c_adapter.algo_data = par;
 	par->adap = &mb862xx_i2c_adapter;
 
-- 
2.9.0

