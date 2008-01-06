From: Helge Deller <deller@gmx.de>
Subject: [PATCH] backlight.c: avoid unnecessarily
	calling backlight_update_status()
Date: Sun, 6 Jan 2008 15:29:19 +0100
Message-ID: <200801061529.19606.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JBWWb-0006Ro-1N for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Jan 2008 06:30:53 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JBWWX-0006Ok-Ck
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Jan 2008 06:30:52 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: rpurdie@rpsys.net, Andrew Zabolotny <zap@homelink.ru>, Jamey Hicks <jamey.hicks@hp.com>

Every write to the backlight control sysfs entries like (on a Sharp
Zaurus Poodle):
- /sys/class/backlight/locomo-bl/power
- /sys/class/backlight/locomo-bl/brightness
triggers a call of backlight_update_status(), even if the same
value is written multiple times in row into those entries.

In principle this is not critical, but e.g. on the SHARP Poodle everytime
backlight_update_status() is called, a lot of registers are reset
and this leads to screen distortions of a ~ 0.4 seconds time frame.
Esp. tools like some light control programs with controlling sliders 
for the light intensity happen to set those values more often 
which is really annoying and makes it nearly impossible to use them
because the reaction time is really slow and you see lots of screen
distortions.

The trivial patch below avoids this problem by comparing the 
new value with the already set value. In case they are the same,
it just avoids to call backlight_update_status() again.

It would be great if this patch could be applied to the fbdev git tree
for inclusion in later linux kernels.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4840fe2..3939475 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -94,8 +94,10 @@ static ssize_t backlight_store_power(struct device *dev,
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops) {
 		pr_debug("backlight: set power to %d\n", power);
-		bd->props.power = power;
-		backlight_update_status(bd);
+		if (bd->props.power != power) {
+			bd->props.power = power;
+			backlight_update_status(bd);
+		}
 		rc = count;
 	}
 	mutex_unlock(&bd->ops_lock);
@@ -132,8 +134,10 @@ static ssize_t backlight_store_brightness(struct device *dev,
 		else {
 			pr_debug("backlight: set brightness to %d\n",
 				 brightness);
-			bd->props.brightness = brightness;
-			backlight_update_status(bd);
+			if (bd->props.brightness != brightness) {
+				bd->props.brightness = brightness;
+				backlight_update_status(bd);
+			}
 			rc = count;
 		}
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
