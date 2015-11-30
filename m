From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 30 Nov 2015 11:24:23 +0000
Subject: [PATCH] backlight: adp8860: fix another uninitialized variable use
Message-Id: <3284846.T0rzz6n1As@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A recent patch I did fixed two potential uses of uninitialized
variables in the adp8870 and adp8860 drivers. Unfortunately,
I missed another one:

drivers/video/backlight/adp8860_bl.c: In function 'adp8860_bl_ambient_light_level_show':
drivers/video/backlight/adp8860_bl.c:570:11: warning: 'reg_val' may be used uninitialized in this function

This does the same change as before in one additional function,
and also changes the check for the return value in a way that
avoids another false positive warning with a similar message.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6be3a5a9cd91 ("backlight: adp88x0: Fix uninitialized variable use")
---
Sorry for missing this third hunk the first time around.

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index f0d4c0324580..510e559c060e 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -566,11 +566,13 @@ static ssize_t adp8860_bl_ambient_light_level_show(struct device *dev,
 
 	mutex_lock(&data->lock);
 	error = adp8860_read(data->client, ADP8860_PH1LEVL, &reg_val);
-	ret_val = reg_val;
-	error |= adp8860_read(data->client, ADP8860_PH1LEVH, &reg_val);
+	if (!error) {
+		ret_val = reg_val;
+		error = adp8860_read(data->client, ADP8860_PH1LEVH, &reg_val);
+	}
 	mutex_unlock(&data->lock);
 
-	if (error < 0)
+	if (error)
 		return error;
 
 	/* Return 13-bit conversion value for the first light sensor */

