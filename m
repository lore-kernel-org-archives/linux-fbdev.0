From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 05 Jan 2010 22:59:57 +0000
Subject: [PATCH 2/4] viafb: fix LCD hardware cursor regression
Message-Id: <1262732399-3416-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262732399-3416-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1262732399-3416-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: fix LCD hardware cursor regression

Although I'd consider this a hardware bug, as there is hardware out
that for whatever reason does not support hardware cursors on LCD
output we have to care about it in the driver.
This fixes a regression (invisible cursor) introduced by:
    viafb: cleanup viafb_cursor

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Reported-by: Julian Wollrath <jwollrath@web.de>
Tested-by: Julian Wollrath <jwollrath@web.de>
---
 drivers/video/via/viafbdev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 02ed2f6..e16df84 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -869,7 +869,9 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	if (info->flags & FBINFO_HWACCEL_DISABLED || info != viafbinfo)
 		return -ENODEV;
 
-	if (chip_name = UNICHROME_CLE266 && viapar->iga_path = IGA2)
+	/* LCD ouput does not support hw cursors (at least on VN896) */
+	if ((chip_name = UNICHROME_CLE266 && viapar->iga_path = IGA2) ||
+		viafb_LCD_ON)
 		return -ENODEV;
 
 	viafb_show_hw_cursor(info, HW_Cursor_OFF);
-- 
1.6.3.2

