From: Devendra Naga <devendra.aaru@gmail.com>
Date: Mon, 31 Dec 2012 18:18:31 +0000
Subject: [PATCH] backlight: lm3649_backlight: remove ret = -EIO at error paths of probe
Message-Id: <1356977911-13521-1-git-send-email-devendra.aaru@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

the APIs are returning correctly the err codes, no need of assigning -EIO to the
ret again

Cc: Daniel Jeong <daniel.jeong@ti.com>
Cc: G.Shark Jeong <gshark.jeong@gmail.com>
Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/video/backlight/lm3639_bl.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 7ab2d2a..053964d 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -350,14 +350,13 @@ static int lm3639_probe(struct i2c_client *client,
 				      &lm3639_bled_ops, &props);
 	if (IS_ERR(pchip->bled)) {
 		dev_err(&client->dev, "fail : backlight register\n");
-		ret = -EIO;
+		ret = PTR_ERR(pchip->bled);
 		goto err_out;
 	}
 
 	ret = device_create_file(&(pchip->bled->dev), &dev_attr_bled_mode);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed : add sysfs entries\n");
-		ret = -EIO;
 		goto err_bled_mode;
 	}
 
@@ -369,7 +368,6 @@ static int lm3639_probe(struct i2c_client *client,
 				    &client->dev, &pchip->cdev_flash);
 	if (ret < 0) {
 		dev_err(&client->dev, "fail : flash register\n");
-		ret = -EIO;
 		goto err_flash;
 	}
 
@@ -381,7 +379,6 @@ static int lm3639_probe(struct i2c_client *client,
 				    &client->dev, &pchip->cdev_torch);
 	if (ret < 0) {
 		dev_err(&client->dev, "fail : torch register\n");
-		ret = -EIO;
 		goto err_torch;
 	}
 
-- 
1.7.10.4

