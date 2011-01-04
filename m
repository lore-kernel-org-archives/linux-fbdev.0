From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Tue, 04 Jan 2011 11:42:06 +0000
Subject: [PATCH] via-camera: check viafb_find_i2c_adapter() result to NULL
Message-Id: <4D23078E.8070801@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If viafb_find_i2c_adapter() patch still useful - via-camera.c must be fixed too.

Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
---
--- b/drivers/media/video/via-camera.c	2011-01-04 13:08:18.000000000 +0200
+++ c/drivers/media/video/via-camera.c	2011-01-04 13:35:45.000000000 +0200
@@ -1344,8 +1344,9 @@ static __devinit int viacam_probe(struct
 	 * is OLPC-specific.  0x42 assumption is ov7670-specific.
 	 */
 	sensor_adapter = viafb_find_i2c_adapter(VIA_PORT_31);
-	cam->sensor = v4l2_i2c_new_subdev(&cam->v4l2_dev, sensor_adapter,
-			"ov7670", 0x42 >> 1, NULL);
+	if (sensor_adapter != NULL)
+		cam->sensor = v4l2_i2c_new_subdev(&cam->v4l2_dev,
+			sensor_adapter, "ov7670", 0x42 >> 1, NULL);
 	if (cam->sensor = NULL) {
 		dev_err(&pdev->dev, "Unable to find the sensor!\n");
 		ret = -ENODEV;
--
