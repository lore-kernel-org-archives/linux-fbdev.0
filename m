From: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH RFC] backlight/fbcon: Add
	FB_EVENT_CONBLANK
Date: Sun, 11 Feb 2007 00:39:39 +0000
Message-ID: <1171154379.5836.72.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HG2ku-0001jC-WA for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 16:39:49 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HG2kt-0008UY-8n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 16:39:48 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

I've added this patch to the backlight git tree since it allows the
removal of a powermac specific hack to chipsfb_blank and fixes the
backlight class to work with drivers with no hardware blanking. Can
anyone see any problems with this? 


The backlight class wants notification whenever the console is blanked
but doesn't get this when hardware blanking fails and software blanking
is used. Changing FB_EVENT_BLANK to report both would be a behaviour
change which could confuse the console layer so add a new event for
software blanking and have the backlight class listen for both.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
---

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4f987c4..5490b2a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -28,7 +28,7 @@ static int fb_notifier_callback(struct notifier_block *self,
 	struct fb_event *evdata = data;
 
 	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK)
+	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 31f476a..0b9954c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2234,6 +2234,8 @@ static int fbcon_switch(struct vc_data *vc)
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
+	struct fb_event event;
+
 	if (blank) {
 		unsigned short charmask = vc->vc_hi_font_mask ?
 			0x1ff : 0xff;
@@ -2244,6 +2246,11 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
+
+
+	event.info = info;
+	event.data = &blank;
+	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
 }
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 64177ec..8e197ce 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -509,13 +509,15 @@ struct fb_cursor_user {
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
-/*      A display blank is requested       */
+/*      A hardware display blank change occured */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
 #define FB_EVENT_NEW_MODELIST           0x0A
 /*	The resolution of the passed in fb_info about to change and
         all vc's should be changed         */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
+/*	A software display blank change occured */
+#define FB_EVENT_CONBLANK               0x0C
 
 struct fb_event {
 	struct fb_info *info;



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
