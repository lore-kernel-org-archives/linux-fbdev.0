From: Kees Cook <keescook@chromium.org>
Date: Sat, 17 Dec 2016 01:03:09 +0000
Subject: [PATCH] video: use designated initializers
Message-Id: <20161217010309.GA140492@beast>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org

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
index a01147fdf270..5d896f879ff9 100644
--- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
@@ -1088,14 +1088,20 @@ static void MGAG100_restore(struct matrox_fb_info *minfo)
 
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 struct matrox_switch matrox_mystique = {
-	MGA1064_preinit, MGA1064_reset, MGA1064_init, MGA1064_restore,
+	.preinit = MGA1064_preinit,
+	.reset = MGA1064_reset,
+	.init = MGA1064_init,
+	.restore = MGA1064_restore,
 };
 EXPORT_SYMBOL(matrox_mystique);
 #endif
 
 #ifdef CONFIG_FB_MATROX_G
 struct matrox_switch matrox_G100 = {
-	MGAG100_preinit, MGAG100_reset, MGAG100_init, MGAG100_restore,
+	.preinit = MGAG100_preinit,
+	.reset = MGAG100_reset,
+	.init = MGAG100_init,
+	.restore = MGAG100_restore,
 };
 EXPORT_SYMBOL(matrox_G100);
 #endif
diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
index 68fa037d8cbc..0273351b2342 100644
--- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
@@ -738,7 +738,10 @@ static int Ti3026_preinit(struct matrox_fb_info *minfo)
 }
 
 struct matrox_switch matrox_millennium = {
-	Ti3026_preinit, Ti3026_reset, Ti3026_init, Ti3026_restore
+	.preinit = Ti3026_preinit,
+	.reset = Ti3026_reset,
+	.init = Ti3026_init,
+	.restore = Ti3026_restore
 };
 EXPORT_SYMBOL(matrox_millennium);
 #endif
-- 
2.7.4


-- 
Kees Cook
Nexus Security
