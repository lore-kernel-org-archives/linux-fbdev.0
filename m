From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 23 May 2015 17:32:35 +0000
Subject: [patch] fbdev: ssd1307fb: potential ERR_PTR dereference
Message-Id: <20150523173235.GA31595@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The error handling got shifted down a few lines from where it was
supposed to be for some reason.

Fixes: a14a7ba8cb0f ('fbdev: ssd1307fb: add backlight controls for setting the contrast')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8fc224c..9c28a77 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -655,15 +655,16 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
 	bl = backlight_device_register(bl_name, &client->dev, par,
 				       &ssd1307fb_bl_ops, NULL);
-	bl->props.brightness = par->contrast;
-	bl->props.max_brightness = MAX_CONTRAST;
-	info->bl_dev = bl;
-
 	if (IS_ERR(bl)) {
 		dev_err(&client->dev, "unable to register backlight device: %ld\n",
 			PTR_ERR(bl));
 		goto bl_init_error;
 	}
+
+	bl->props.brightness = par->contrast;
+	bl->props.max_brightness = MAX_CONTRAST;
+	info->bl_dev = bl;
+
 	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
 
 	return 0;
