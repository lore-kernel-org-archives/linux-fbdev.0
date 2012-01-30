From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Mon, 30 Jan 2012 22:00:17 +0000
Subject: [PATCH 13/16] riva/fbdev: fix several -Wuninitialized
Message-Id: <1327960820-11867-14-git-send-email-danny.kukawka@bisect.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327960820-11867-1-git-send-email-danny.kukawka@bisect.de>
In-Reply-To: <1327960820-11867-1-git-send-email-danny.kukawka@bisect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fix several -Wuninitialized compiler warnings by changing the
order of getting modedb in riva_update_default_var() to set
first the fallback and then the prefered timing.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/video/riva/fbdev.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 2f58cf9..90df1a6 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1816,6 +1816,8 @@ static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
 			     specs->modedb, specs->modedb_len,
 			     NULL, 8);
 	} else if (specs->modedb != NULL) {
+		/* get first mode in database as fallback */
+		modedb = specs->modedb[0];
 		/* get preferred timing */
 		if (info->monspecs.misc & FB_MISC_1ST_DETAIL) {
 			int i;
@@ -1826,9 +1828,6 @@ static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
 					break;
 				}
 			}
-		} else {
-			/* otherwise, get first mode in database */
-			modedb = specs->modedb[0];
 		}
 		var->bits_per_pixel = 8;
 		riva_update_var(var, &modedb);
-- 
1.7.7.3

