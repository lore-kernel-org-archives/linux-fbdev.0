From: William Katsak <william.katsak@alcatel-lucent.com>
Date: Thu, 23 Jun 2011 13:16:29 +0000
Subject: [PATCH] This patch fixes a problem where a DisplayLink device autoselects a suboptimal framebuffer r
Message-Id: <1308834989-28712-1-git-send-email-william.katsak@alcatel-lucent.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The situation in which the problem occurred was with a Plugable UGA-2K-A
connected to a Samsung EX2220X display. The driver indicates that
1920x1080 is a valid mode (the first mode available, in fact), but
proceeds to set the framebuffer size to 1600x1200.

The patch corrects what seems to be a logic error, regarding unsetting
the FB_MISC_1ST_DETAIL flag, if the first (top/best) mode is invalid.
The existing code unset the flag if ANY mode was invalid.

Signed-off-by: William Katsak <william.katsak@alcatel-lucent.com>
---
 drivers/video/udlfb.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 52b0f3e..816a4fd 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1233,8 +1233,12 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 			if (dlfb_is_valid_mode(&info->monspecs.modedb[i], info))
 				fb_add_videomode(&info->monspecs.modedb[i],
 					&info->modelist);
-			else /* if we've removed top/best mode */
-				info->monspecs.misc &= ~FB_MISC_1ST_DETAIL;
+			else {
+				if (i = 0)
+					/* if we've removed top/best mode */
+					info->monspecs.misc
+						&= ~FB_MISC_1ST_DETAIL;
+			}
 		}
 
 		default_vmode = fb_find_best_display(&info->monspecs,
-- 
1.7.3.4

