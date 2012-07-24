From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 24 Jul 2012 01:00:24 +0000
Subject: [PATCH 2/4] fbcon: prevent possible buffer overflow.
Message-Id: <1343091626-11435-2-git-send-email-paul@crapouillou.net>
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
 drivers/video/console/fbcon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index a0b1818..3ffab97 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -442,7 +442,7 @@ static int __init fb_console_setup(char *this_opt)
 
 	while ((options = strsep(&this_opt, ",")) != NULL) {
 		if (!strncmp(options, "font:", 5))
-			strcpy(fontname, options + 5);
+			strlcpy(fontname, options + 5, sizeof(fontname));
 		
 		if (!strncmp(options, "scrollback:", 11)) {
 			char *k;
-- 
1.7.10.4

