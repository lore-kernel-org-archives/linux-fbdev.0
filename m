From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 16 Jun 2015 13:54:05 +0000
Subject: [PATCH 2/8] staging: sm7xxfb: remove numvgamodes
Message-Id: <1434462131-15191-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1434462131-15191-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

numvgamodes was only used in one place, so remove the #define
and use its defined value.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xx.h   | 2 --
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index c5d6253..4dabda4 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -775,5 +775,3 @@ static struct ModeInit vgamode[] = {
 	  },
 	 },
 };
-
-#define numvgamodes		ARRAY_SIZE(vgamode)
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 4d9b69d..5667fbf 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -477,7 +477,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		"sfb->width=%d sfb->height=%d sfb->fb->var.bits_per_pixel=%d sfb->hz=%d\n",
 		sfb->width, sfb->height, sfb->fb->var.bits_per_pixel, sfb->hz);
 
-	for (j = 0; j < numvgamodes; j++) {
+	for (j = 0; j < ARRAY_SIZE(vgamode); j++) {
 		if (vgamode[j].mmsizex = sfb->width &&
 		    vgamode[j].mmsizey = sfb->height &&
 		    vgamode[j].bpp = sfb->fb->var.bits_per_pixel &&
-- 
1.8.1.2

