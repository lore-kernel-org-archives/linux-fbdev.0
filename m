From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 17 May 2017 20:55:07 +0000
Subject: [PATCH v5] backlight: report error on failure
Message-Id: <1495054507-9988-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

It is possible to update the backlight power and the brightness using
the sysfs and on writing it either returns the count or if the callback
function does not exist then returns the error code 'ENXIO'.

We have a situation where the userspace client is writing to the sysfs
to update the power and since the callback function exists the client
receives the return value as count and considers the operation to be
successful. That is correct as the write to the sysfs was successful.
But there is no way to know if the actual operation was done or not.

backlight_update_status() returns the error code if it fails. Pass that
to the userspace client who is trying to update the power so that the
client knows that the operation failed.

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

v5: dropped the ternary condition
v4: ABI comment removed from commit message
v3: remove rc = 0, and update rc with count in else condition.
v2: update power with old value on failure.

 drivers/video/backlight/backlight.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 288318a..8049e76 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -134,7 +134,7 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
 {
 	int rc;
 	struct backlight_device *bd = to_backlight_device(dev);
-	unsigned long power;
+	unsigned long power, old_power;
 
 	rc = kstrtoul(buf, 0, &power);
 	if (rc)
@@ -145,10 +145,16 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
 	if (bd->ops) {
 		pr_debug("set power to %lu\n", power);
 		if (bd->props.power != power) {
+			old_power = bd->props.power;
 			bd->props.power = power;
-			backlight_update_status(bd);
+			rc = backlight_update_status(bd);
+			if (rc)
+				bd->props.power = old_power;
+			else
+				rc = count;
+		} else {
+			rc = count;
 		}
-		rc = count;
 	}
 	mutex_unlock(&bd->ops_lock);
 
@@ -176,8 +182,7 @@ int backlight_device_set_brightness(struct backlight_device *bd,
 		else {
 			pr_debug("set brightness to %lu\n", brightness);
 			bd->props.brightness = brightness;
-			backlight_update_status(bd);
-			rc = 0;
+			rc = backlight_update_status(bd);
 		}
 	}
 	mutex_unlock(&bd->ops_lock);
-- 
1.9.1

