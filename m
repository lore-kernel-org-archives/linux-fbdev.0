From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: fbdev: Add FB_EVENT_BLANK to notify listeners of a blanking status change
Date: Mon, 29 Nov 2004 22:36:59 -0000
Message-ID: <01f301c4d664$5c950440$0f01a8c0@max>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411280824.01338.adaplas@hotpop.com> <02cc01c4d4e5$75e4e170$0f01a8c0@max> <200411280914.40352.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYuBa-0008LX-91
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 14:39:58 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CYuBZ-0001eI-28
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 14:39:58 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, zap@homelink.ru

Add FB_EVENT_BLANK to notify listeners of a blanking status change. This 
allows backlight drivers to be implemented completely separately from any 
framebuffer driver. The new blanking mode is passed in event.data.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

--- linux-2.6.10-rc2/drivers/video/fbmem.c~fb_blank
+++ linux-2.6.10-rc2/drivers/video/fbmem.c
@@ -744,9 +744,14 @@
 fb_blank(struct fb_info *info, int blank)
 {
  int err = -EINVAL;
+ struct fb_event event;

   if (blank > FB_BLANK_POWERDOWN)
    blank = FB_BLANK_POWERDOWN;
+
+ event.info = info;
+ event.data = &blank;
+ notifier_call_chain(&fb_notifier_list, FB_EVENT_BLANK, &event);

  if (info->fbops->fb_blank)
    err = info->fbops->fb_blank(blank, info);
--- linux-2.6.10-rc2/include/linux/fb.h~fb_blank
+++ linux-2.6.10-rc2/include/linux/fb.h
@@ -488,6 +488,8 @@
 #define FB_EVENT_GET_CONSOLE_MAP        0x06
 /*      set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x07
+/*      Blanking on the display on this fb_info has changed */
+#define FB_EVENT_BLANK                  0x08


 struct fb_event {
--- linux-2.6.10-rc2/drivers/video/console/fbcon.c~fb_blank
+++ linux-2.6.10-rc2/drivers/video/console/fbcon.c
@@ -2063,8 +2063,7 @@
    fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
    ops->cursor_flash = (!blank);

-   if (info->fbops->fb_blank)
-    ret = info->fbops->fb_blank(blank, info);
+  ret = fb_blank(info, blank);

    if (ret)
     fbcon_generic_blank(vc, info, blank);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
