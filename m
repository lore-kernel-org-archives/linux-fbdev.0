From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Oct 2010 13:36:05 +0000
Subject: [PATCH] fbdev: extend fb_do_probe_ddc_edid() to read two EDID blocks,
Message-Id: <Pine.LNX.4.64.1010281534510.1257@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A simple extension of the fb_do_probe_ddc_edid() function allows reading of up
to two EDID blocks without changing the API. Two EDID blocks is also the usual
case for HDMI devices.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/fb_ddc.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fb_ddc.c b/drivers/video/fb_ddc.c
index 4a874c8..958035a 100644
--- a/drivers/video/fb_ddc.c
+++ b/drivers/video/fb_ddc.c
@@ -21,7 +21,7 @@
 static unsigned char *fb_do_probe_ddc_edid(struct i2c_adapter *adapter)
 {
 	unsigned char start = 0x0;
-	unsigned char *buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	unsigned char *buf = kmalloc(2 * EDID_LENGTH, GFP_KERNEL);
 	struct i2c_msg msgs[] = {
 		{
 			.addr	= DDC_ADDR,
@@ -42,12 +42,21 @@ static unsigned char *fb_do_probe_ddc_edid(struct i2c_adapter *adapter)
 		return NULL;
 	}
 
-	if (i2c_transfer(adapter, msgs, 2) = 2)
-		return buf;
+	if (i2c_transfer(adapter, msgs, 2) != 2) {
+		dev_warn(&adapter->dev, "unable to read EDID block.\n");
+		kfree(buf);
+		return NULL;
+	}
+
+	if (buf[126]) {
+		start = 0x80;
+		msgs[1].buf += EDID_LENGTH;
+		if (i2c_transfer(adapter, msgs, 2) != 2)
+			/* Indicate failed E-EDID */
+			buf[128] = 0xff;
+	}
 
-	dev_warn(&adapter->dev, "unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
+	return buf;
 }
 
 unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
-- 
1.7.1

