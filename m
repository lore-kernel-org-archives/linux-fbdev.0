From: Arnd Hannemann <arnd@arndnet.de>
Date: Mon, 15 Nov 2010 21:43:22 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: fix bug in reconfig()
Message-Id: <1289857402-27180-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The function sh_mobile_fb_reconfig() contained a bug,
which caused the line_length to be set wrongly, if a mode
with a different X-resolution than the default one was chosen.
This caused 1080p24 mode to not work on AP4EVB.
Additionally the notifier chain was also called with the wrong 
mode.

This patch fixes this, by using the X-resolution of the new
mode instead of the old one to calculate line length and
hands over the correct mode to the notifier chain.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 993be38..7c2c314 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -860,7 +860,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
-	info->fix.line_length = mode2.xres * (ch->cfg.bpp / 8);
+	info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
 
 	/*
 	 * fb_set_var() calls the notifier change internally, only if
@@ -868,7 +868,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	 * user event, we have to call the chain ourselves.
 	 */
 	event.info = info;
-	event.data = &mode2;
+	event.data = &mode1;
 	fb_notifier_call_chain(evnt, &event);
 }
 
-- 
1.7.0.4

