From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 04:34:56 +0000
Subject: [PATCH 3/3] Drivers: video: controlfb: fixed a brace coding style issue
Message-Id: <1321590896-8249-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/video/controlfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index 7b2c40a..0c189b3 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -420,7 +420,7 @@ static int __init init_control(struct fb_info_control *p)
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #ifdef CONFIG_NVRAM
-	if (default_cmode = CMODE_NVRAM){
+	if (default_cmode = CMODE_NVRAM) {
 		cmode = nvram_read_byte(NV_CMODE);
 		if(cmode < CMODE_8 || cmode > CMODE_32)
 			cmode = CMODE_8;
-- 
1.7.7.3

