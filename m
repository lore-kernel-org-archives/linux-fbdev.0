From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 11:08:17 +0000
Subject: [patch] fb: adv7393: off by one in probe function
Message-Id: <20160715110817.GD9258@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

This should be >= instead of >.  It's a little bit clearer if we just
get rid of the temporary variable and just use ARRAY_SIZE() directly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev/bfin_adv7393fb.c
index 8fe41ca..c846021 100644
--- a/drivers/video/fbdev/bfin_adv7393fb.c
+++ b/drivers/video/fbdev/bfin_adv7393fb.c
@@ -373,7 +373,6 @@ static int bfin_adv7393_fb_probe(struct i2c_client *client,
 {
 	int ret = 0;
 	struct proc_dir_entry *entry;
-	int num_modes = ARRAY_SIZE(known_modes);
 
 	struct adv7393fb_device *fbdev = NULL;
 
@@ -382,7 +381,7 @@ static int bfin_adv7393_fb_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	if (mode > num_modes) {
+	if (mode >= ARRAY_SIZE(known_modes)) {
 		dev_err(&client->dev, "mode %d: not supported", mode);
 		return -EFAULT;
 	}
