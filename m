From: Kees Cook <keescook@chromium.org>
Date: Tue, 03 Jan 2017 23:24:33 +0000
Subject: [PATCH v2] video: fbdev: matroxfb: use designated initializers
Message-Id: <20170103232433.GA117659@beast>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 10 ++++++++--
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c  |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
index a01147fdf270..b380a393cbc3 100644
--- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
@@ -1088,14 +1088,20 @@ static void MGAG100_restore(struct matrox_fb_info *minfo)
 
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 struct matrox_switch matrox_mystique = {
-	MGA1064_preinit, MGA1064_reset, MGA1064_init, MGA1064_restore,
+	.preinit	= MGA1064_preinit,
+	.reset		= MGA1064_reset,
+	.init		= MGA1064_init,
+	.restore	= MGA1064_restore,
 };
 EXPORT_SYMBOL(matrox_mystique);
 #endif
 
 #ifdef CONFIG_FB_MATROX_G
 struct matrox_switch matrox_G100 = {
-	MGAG100_preinit, MGAG100_reset, MGAG100_init, MGAG100_restore,
+	.preinit	= MGAG100_preinit,
+	.reset		= MGAG100_reset,
+	.init		= MGAG100_init,
+	.restore	= MGAG100_restore,
 };
 EXPORT_SYMBOL(matrox_G100);
 #endif
diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
index 68fa037d8cbc..9ff9be85759e 100644
--- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
@@ -738,7 +738,10 @@ static int Ti3026_preinit(struct matrox_fb_info *minfo)
 }
 
 struct matrox_switch matrox_millennium = {
-	Ti3026_preinit, Ti3026_reset, Ti3026_init, Ti3026_restore
+	.preinit	= Ti3026_preinit,
+	.reset		= Ti3026_reset,
+	.init		= Ti3026_init,
+	.restore	= Ti3026_restore
 };
 EXPORT_SYMBOL(matrox_millennium);
 #endif
-- 
2.7.4


-- 
Kees Cook
Nexus Security
