From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 24 Jul 2012 01:00:26 +0000
Subject: [PATCH 4/4] fbcon: optimize parameters parsing loop.
Message-Id: <1343091626-11435-4-git-send-email-paul@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343091626-11435-1-git-send-email-paul@crapouillou.net>
In-Reply-To: <1343091626-11435-1-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>


Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/video/console/fbcon.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 9b83b75..1ecaf68 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -441,8 +441,10 @@ static int __init fb_console_setup(char *this_opt)
 		return 1;
 
 	while ((options = strsep(&this_opt, ",")) != NULL) {
-		if (!strncmp(options, "font:", 5))
+		if (!strncmp(options, "font:", 5)) {
 			strlcpy(fontname, options + 5, sizeof(fontname));
+			continue;
+		}
 		
 		if (!strncmp(options, "scrollback:", 11)) {
 			char *k;
@@ -468,6 +470,7 @@ static int __init fb_console_setup(char *this_opt)
 			/* (k && *k): Check for garbage after the suffix */
 			if (ret || (k && *k))
 				printk(KERN_WARNING "fbcon: scrollback: incorrect value.\n");
+			continue;
 		}
 		
 		if (!strncmp(options, "map:", 4)) {
@@ -484,6 +487,7 @@ static int __init fb_console_setup(char *this_opt)
 			} else {
 				printk(KERN_WARNING "fbcon: map: incorrect value.\n");
 			}
+			continue;
 		}
 
 		if (!strncmp(options, "vc:", 3)) {
@@ -513,6 +517,7 @@ static int __init fb_console_setup(char *this_opt)
 				fbcon_is_default = 0;
 			else
 				printk(KERN_WARNING "fbcon: vc: incorrect value.\n");
+			continue;
 		}
 
 		if (!strncmp(options, "rotate:", 7)) {
@@ -525,6 +530,7 @@ static int __init fb_console_setup(char *this_opt)
 			} else {
 				printk(KERN_WARNING "fbcon: rotate: incorrect value.\n");
 			}
+			continue;
 		}
 	}
 	return 1;
-- 
1.7.10.4

