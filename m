From: Colin King <colin.king@canonical.com>
Date: Thu, 01 Sep 2016 08:52:23 +0000
Subject: [PATCH] video: fbdev: mb862xx: remove unused variable 'ret'
Message-Id: <20160901085223.8596-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826153252.722636-1-arnd@arndb.de>
In-Reply-To: <20160826153252.722636-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ret is not being used, fixes warning:

drivers/video/fbdev/mb862xx/mb862xx-i2c.c:160:6: warning:
  unused variable ‘ret’ [-Wunused-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xx-i2c.c b/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
index 76d2068..ba96c44 100644
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
2.9.3

