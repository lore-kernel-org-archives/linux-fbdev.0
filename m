From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 14 Sep 2014 09:48:30 +0000
Subject: [PATCH] video: valkyriefb: Fix unused variable warning in set_valkyrie_clock()
Message-Id: <1410688110-11042-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_ADB_CUDA=n:

drivers/video/fbdev/valkyriefb.c: In function ‘set_valkyrie_clock’:
drivers/video/fbdev/valkyriefb.c:267: warning: unused variable ‘i’
drivers/video/fbdev/valkyriefb.c:266: warning: unused variable ‘req’

Move the variable declarations inside the existing #ifdef section to fix
this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/valkyriefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 97cb9bd1d1dd..b6ed09f16355 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -263,10 +263,10 @@ static inline int valkyrie_vram_reqd(int video_mode, int color_mode)
 
 static void set_valkyrie_clock(unsigned char *params)
 {
+#ifdef CONFIG_ADB_CUDA
 	struct adb_request req;
 	int i;
 
-#ifdef CONFIG_ADB_CUDA
 	for (i = 0; i < 3; ++i) {
 		cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC,
 			     0x50, i + 1, params[i]);
-- 
1.9.1

