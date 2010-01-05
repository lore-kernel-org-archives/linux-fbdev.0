From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 05 Jan 2010 22:59:58 +0000
Subject: [PATCH 3/4] viafb: do modesetting after updating variables
Message-Id: <1262732399-3416-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262732399-3416-1-git-send-email-FlorianSchandinat@gmx.de>
 <1262732399-3416-2-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1262732399-3416-2-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Erik-Jan Post <ej.lfs@xs4all.nl>

viafb: do modesetting after updating variables

Reorder viafb_set_par to allow using the updated variables in
viafb_setmode. This fixes a regression that prevented proper
runtime mode changes.

Signed-off-by: Erik-Jan Post <ej.lfs@xs4all.nl>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index e16df84..f7ff4ea 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -174,15 +174,15 @@ static int viafb_set_par(struct fb_info *info)
 	}
 
 	if (vmode_entry) {
-		viafb_setmode(vmode_entry, info->var.bits_per_pixel,
-			vmode_entry1, viafb_bpp1);
-
 		viafb_update_fix(info);
 		viafb_bpp = info->var.bits_per_pixel;
 		if (info->var.accel_flags & FB_ACCELF_TEXT)
 			info->flags &= ~FBINFO_HWACCEL_DISABLED;
 		else
 			info->flags |= FBINFO_HWACCEL_DISABLED;
+
+		viafb_setmode(vmode_entry, info->var.bits_per_pixel,
+			vmode_entry1, viafb_bpp1);
 	}
 
 	return 0;
-- 
1.6.3.2

