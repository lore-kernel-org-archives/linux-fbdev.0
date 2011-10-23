From: pavel@ucw.cz
Date: Sun, 23 Oct 2011 14:00:42 +0000
Subject: lxfb_core: support 800x480 panel
Message-Id: <20111023140042.GA3654@elf.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

(very old message; maybe it was fixed in the meantime) 

I need something like this to support full resolution of internal LCD
panel on Kohjinsha subnotebook.

(Note: I basically made up the numbers, if someone knows how to
generate them properly, let me know. It somehow works even on external
display, but last few columns are missing.)

Signed-off-by: Pavel Machek <pavel@ucw.cz>

index 889cbe3..2c04a01 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -37,6 +37,9 @@ static int vt_switch;
  */
 
 static struct fb_videomode geode_modedb[] __initdata = {
+	/* 800x480-?? */
+	{ NULL, 60, 800, 480, 25131, 72, 32, 29, 1, 136, 6,
+	  0, FB_VMODE_NONINTERLACED, 0 },
 	/* 640x480-60 */
 	{ NULL, 60, 640, 480, 39682, 48, 8, 25, 2, 88, 2,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
