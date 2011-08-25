From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 25 Aug 2011 10:54:12 +0000
Subject: [PATCH] video/backlight: Remove obsolete cleanup for clientdata
Message-Id: <1314269652-18702-1-git-send-email-w.sang@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/backlight/adp8870_bl.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 05a8832..71d90f4 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -932,7 +932,6 @@ out:
 out1:
 	backlight_device_unregister(bl);
 out2:
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return ret;
@@ -952,7 +951,6 @@ static int __devexit adp8870_remove(struct i2c_client *client)
 			&adp8870_bl_attr_group);
 
 	backlight_device_unregister(data->bl);
-	i2c_set_clientdata(client, NULL);
 	kfree(data);
 
 	return 0;
-- 
1.7.5.4

