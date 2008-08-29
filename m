From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 3/8] lcd: allow lcd device to handle
	mode change events
Date: Fri, 29 Aug 2008 15:26:46 +0800
Message-ID: <f17812d70808290026y39163cccy2d4b1fa3b30c8625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYyNb-0000zg-J6 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:26:47 -0700
Received: from yx-out-1718.google.com ([74.125.44.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYyNb-0000NH-5G
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:26:47 -0700
Received: by yx-out-1718.google.com with SMTP id 3so376193yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 00:26:46 -0700 (PDT)
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
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Some LCD panels are capable of different resolutions, and is allowed
to change at run-time, so to make "struct lcd_device" to be able to
handle mode change events here.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/backlight/lcd.c |   18 +++++++++++++++---
 drivers/video/fbmem.c         |    1 +
 include/linux/lcd.h           |    2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index b15b2b8..8e1731d 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -27,14 +27,26 @@ static int fb_notifier_callback(struct notifier_block *self,
 	struct fb_event *evdata = data;

 	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK)
+	switch (event) {
+	case FB_EVENT_BLANK:
+	case FB_EVENT_MODE_CHANGE:
+	case FB_EVENT_MODE_CHANGE_ALL:
+		break;
+	default:
 		return 0;
+	}

 	ld = container_of(self, struct lcd_device, fb_notif);
+	if (!ld->ops)
+		return 0;
+
 	mutex_lock(&ld->ops_lock);
-	if (ld->ops)
-		if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info))
+	if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info)) {
+		if (event == FB_EVENT_BLANK)
 			ld->ops->set_power(ld, *(int *)evdata->data);
+		else
+			ld->ops->set_mode(ld, evdata->data);
+	}
 	mutex_unlock(&ld->ops_lock);
 	return 0;
 }
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 6b48780..fdfb0e5 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -979,6 +979,7 @@ fb_set_var(struct fb_info *info, struct
fb_var_screeninfo *var)

 				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
+				event.data = &mode;
 				fb_notifier_call_chain(evnt, &event);
 			}
 		}
diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 173feba..f2d223b 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -45,6 +45,8 @@ struct lcd_ops {
 	int (*get_contrast)(struct lcd_device *);
 	/* Set LCD panel contrast */
         int (*set_contrast)(struct lcd_device *, int contrast);
+	/* Set LCD panel mode (resolutions ...) */
+	int (*set_mode)(struct lcd_device *, struct fb_videomode *);
 	/* Check if given framebuffer device is the one LCD is bound to;
 	   return 0 if not, !=0 if it is. If NULL, lcd always matches the fb. */
 	int (*check_fb)(struct lcd_device *, struct fb_info *);
-- 
1.5.4.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
