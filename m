From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/11] fbdev: Fix incorrect timings in
	some modedb entries
Date: Wed, 01 Aug 2007 15:45:22 +0800
Message-ID: <46B03A12.2000905@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9Nn-0003Fn-Gh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:39 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9Nn-0004jH-6h
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:39 -0700
Received: by wa-out-1112.google.com with SMTP id k22so151532waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:39 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: John Lumby <johnlumby@hotmail.com>

Some of the entries in the mode database does not match the comments and/or
the refresh field.  Adjust the timings so they match with both the comments
and the refresh rate.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/modedb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index d351eed..f7f9c08 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -72,7 +72,7 @@ static const struct fb_videomode modedb[
 	0, FB_VMODE_NONINTERLACED
     }, {
 	/* 1152x864 @ 89 Hz interlaced, 44 kHz hsync */
-	NULL, 69, 1152, 864, 15384, 96, 16, 110, 1, 216, 10,
+	NULL, 89, 1152, 864, 15384, 96, 16, 110, 1, 216, 10,
 	0, FB_VMODE_INTERLACED
     }, {
 	/* 800x600 @ 72 Hz, 48.0 kHz hsync */
@@ -120,11 +120,11 @@ static const struct fb_videomode modedb[
 	0, FB_VMODE_NONINTERLACED
     }, {
 	/* 1400x1050 @ 60Hz, 63.9 kHz hsync */
-	NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
+	NULL, 60, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
 	0, FB_VMODE_NONINTERLACED   	
     }, {
 	/* 1400x1050 @ 75,107 Hz, 82,392 kHz +hsync +vsync*/
-	NULL, 75, 1400, 1050, 9271, 120, 56, 13, 0, 112, 3,
+	NULL, 75, 1400, 1050, 7190, 120, 56, 23, 10, 112, 13,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
 	/* 1400x1050 @ 60 Hz, ? kHz +hsync +vsync*/
@@ -253,7 +253,7 @@ static const struct fb_videomode modedb[
 	FB_VMODE_NONINTERLACED
     }, {
 	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
-	NULL, 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	NULL, 60, 1152, 768, 14047, 158, 26, 29, 3, 136, 6,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
 	/* 1366x768, 60 Hz, 47.403 kHz hsync, WXGA 16:9 aspect ratio */
@@ -306,7 +306,7 @@ const struct fb_videomode vesa_modes[] =
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
         /* 12 1024x768i-43 VESA */
-	{ NULL, 53, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,
+	{ NULL, 43, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_INTERLACED, FB_MODE_IS_VESA },
 	/* 13 1024x768-60 VESA */
@@ -383,7 +383,7 @@ const struct fb_videomode vesa_modes[] =
 	{ NULL, 60, 1920, 1440, 4273, 344, 128, 56, 1, 200, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 	/* 33 1920x1440-75 VESA */
-	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
+	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 EXPORT_SYMBOL(vesa_modes);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
