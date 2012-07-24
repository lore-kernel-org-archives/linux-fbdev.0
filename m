From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 24 Jul 2012 01:00:25 +0000
Subject: [PATCH 3/4] fbcon: continue parsing parameters after an error.
Message-Id: <1343091626-11435-3-git-send-email-paul@crapouillou.net>
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
 drivers/video/console/fbcon.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3ffab97..9b83b75 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -481,9 +481,9 @@ static int __init fb_console_setup(char *this_opt)
 				}
 
 				fbcon_map_override();
+			} else {
+				pr_warn("fbcon: map: incorrect value.\n");
 			}
-
-			return 1;
 		}
 
 		if (!strncmp(options, "vc:", 3)) {
-- 
1.7.10.4

