From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 13 Aug 2016 18:39:13 +0000
Subject: [PATCH] video: fbdev: mb862xx: mb862xx-i2c: delete now unused "int ret" variable
Message-Id: <20160813183913.30635-1-paul.gortmaker@windriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563280-20023-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563280-20023-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

In commit 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't
print error when adding adapter fails") the users of the variable
were removed, resulting in:

drivers/video/fbdev/mb862xx/mb862xx-i2c.c: In function ‘mb862xx_i2c_init’:
drivers/video/fbdev/mb862xx/mb862xx-i2c.c:160:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^

...so here we remove the variable as well.

Fixes: 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding adapter fails)"
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Feel free to squash this into the original if you happen to be rebasing]

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
2.8.4

