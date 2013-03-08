From: Devendra Naga <devendra.aaru@gmail.com>
Date: Fri, 08 Mar 2013 19:31:08 +0000
Subject: [PATCH 2/3] video: backlight: lp855x_bl: fix compiler warning in lp855x_probe
Message-Id: <1362771069-16345-2-git-send-email-devendra.aaru@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

while doing with make W=1 gcc (gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8))

found

drivers/video/backlight/lp855x_bl.c: In function ‘lp855x_probe’:
drivers/video/backlight/lp855x_bl.c:342:35: warning: variable ‘mode’ set but not used [-Wunused-but-set-variable]

fixed by removing it as since its not used anywhere

Cc: Milo(Woogyom) Kim <milo.kim@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 7ae9ae6..20111ef 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -339,7 +339,6 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
 	struct lp855x *lp;
 	struct lp855x_platform_data *pdata = cl->dev.platform_data;
-	enum lp855x_brightness_ctrl_mode mode;
 	int ret;
 
 	if (!pdata) {
@@ -354,7 +353,6 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	if (!lp)
 		return -ENOMEM;
 
-	mode = pdata->mode;
 	lp->client = cl;
 	lp->dev = &cl->dev;
 	lp->pdata = pdata;
-- 
1.8.1.2

