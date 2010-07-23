From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:55:52 +0000
Subject: [PATCH 11/11] viafb: fix accel_flags check_var bug
Message-Id: <1279900553-4525-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: fix accel_flags check_var bug

In check_var we should check and modify the var given and not the
one which is currently active. So this code was obviously wrong.
Probably this was doing no harm because all acceleration functions
also check whether acceleration is possible. (otherwise I would
expect this to lead to a null pointer dereference)

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/viafbdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 0f56eb2..bdd0e41 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -216,9 +216,9 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
 
 	/* Adjust var according to our driver's own table */
 	viafb_fill_var_timing_info(var, viafb_refresh, vmode_entry);
-	if (info->var.accel_flags & FB_ACCELF_TEXT &&
+	if (var->accel_flags & FB_ACCELF_TEXT &&
 		!ppar->shared->vdev->engine_mmio)
-		info->var.accel_flags = 0;
+		var->accel_flags = 0;
 
 	return 0;
 }
-- 
1.6.3.2

