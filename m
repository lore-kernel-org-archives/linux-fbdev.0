From: Wolfram Sang <wsa-dev@sang-engineering.com>
Date: Tue, 09 Aug 2016 11:27:39 +0000
Subject: [PATCH] video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding adapter fails
Message-Id: <1470742059-12341-2-git-send-email-wsa-dev@sang-engineering.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
In-Reply-To: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xx-i2c.c b/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
index c87e17afb3e2c9..76d206857e3e2c 100644
--- a/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
+++ b/drivers/video/fbdev/mb862xx/mb862xx-i2c.c
@@ -162,12 +162,7 @@ int mb862xx_i2c_init(struct mb862xxfb_par *par)
 	mb862xx_i2c_adapter.algo_data = par;
 	par->adap = &mb862xx_i2c_adapter;
 
-	ret = i2c_add_adapter(par->adap);
-	if (ret < 0) {
-		dev_err(par->dev, "failed to add %s\n",
-			mb862xx_i2c_adapter.name);
-	}
-	return ret;
+	return i2c_add_adapter(par->adap);
 }
 
 void mb862xx_i2c_exit(struct mb862xxfb_par *par)
-- 
2.8.1

