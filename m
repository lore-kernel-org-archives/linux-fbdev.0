From: Colin King <colin.king@canonical.com>
Date: Fri, 12 Oct 2018 22:47:10 +0000
Subject: [PATCH] fbdev/via: fix spelling mistake "Expandsion" -> "Expansion"
Message-Id: <20181012224710.26867-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in MODULE_PARM_DESC text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 7bb7e90b8f00..bdf5a0ea876d 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -2110,7 +2110,7 @@ MODULE_PARM_DESC(viafb_lcd_panel_id,
 
 module_param(viafb_lcd_dsp_method, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_lcd_dsp_method,
-	"Set Flat Panel display scaling method.(Default=Expandsion)");
+	"Set Flat Panel display scaling method.(Default=Expansion)");
 
 module_param(viafb_SAMM_ON, int, S_IRUSR);
 MODULE_PARM_DESC(viafb_SAMM_ON,
-- 
2.17.1
