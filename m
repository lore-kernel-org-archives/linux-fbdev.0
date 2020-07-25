From: Ming Li <limingming.li@huawei.com>
Date: Sat, 25 Jul 2020 07:47:43 +0000
Subject: [PATCH -next] vc: Fix build errors
Message-Id: <20200725074743.31740-1-limingming.li@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <98f7beee-8fab-6c56-7179-424b6bb45443@suse.cz>
In-Reply-To: <98f7beee-8fab-6c56-7179-424b6bb45443@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, john.wanghui@huawei.com, dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org, cuibixuan@huawei.com, jslaby@suse.cz

Build errors are seen on MIPS platforms because of
vc state separation and the following build erros
were reported.

../linux/drivers/video/console/newport_con.c: In function ‘newport_clear’:
../linux/drivers/video/console/newport_con.c:365:15: error:
‘struct vc_data’ has no member named ‘vc_color’; did you mean ‘vc_cols’?
          (vc->vc_color & 0xf0) >> 4);
               ^~~~~~~~
               vc_cols
../linux/drivers/video/console/newport_con.c:368:15: error:
‘struct vc_data’ has no member named ‘vc_color’; did you mean ‘vc_cols’?
          (vc->vc_color & 0xf0) >> 4);
               ^~~~~~~~
               vc_cols
../linux/drivers/video/console/newport_con.c:370:15: error:
‘struct vc_data’ has no member named ‘vc_color’; did you mean ‘vc_cols’?
          (vc->vc_color & 0xf0) >> 4);
               ^~~~~~~~
               vc_cols
../linux/drivers/video/console/newport_con.c: In function ‘newport_scroll’:
../linux/drivers/video/console/newport_con.c:594:15: error:
‘struct vc_data’ has no member named ‘vc_color’; did you mean ‘vc_cols’?
          (vc->vc_color & 0xf0) >> 4);
               ^~~~~~~~
               vc_cols
../linux/drivers/video/console/newport_con.c:598:15: error:
‘struct vc_data’ has no member named ‘vc_color’; did you mean ‘vc_cols’?
          (vc->vc_color & 0xf0) >> 4);
               ^~~~~~~~
               vc_cols
make[4]: *** [/scratch/linux/scripts/Makefile.build:280: drivers/video/console/newport_con.o] Error 1
make[3]: *** [/scratch/linux/scripts/Makefile.build:497: drivers/video/console] Error 2
make[3]: *** Waiting for unfinished jobs....

Fixes: 28bc24fc46f9 ("vc: separate state")
Signed-off-by: Ming Li <limingming.li@huawei.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/console/newport_con.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index df3c52d72159..72f146d047d9 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -362,12 +362,12 @@ static void newport_clear(struct vc_data *vc, int sy, int sx, int height,
 
 	if (ystart < yend) {
 		newport_clear_screen(sx << 3, ystart, xend, yend,
-				     (vc->vc_color & 0xf0) >> 4);
+				     (vc->state.color & 0xf0) >> 4);
 	} else {
 		newport_clear_screen(sx << 3, ystart, xend, 1023,
-				     (vc->vc_color & 0xf0) >> 4);
+				     (vc->state.color & 0xf0) >> 4);
 		newport_clear_screen(sx << 3, 0, xend, yend,
-				     (vc->vc_color & 0xf0) >> 4);
+				     (vc->state.color & 0xf0) >> 4);
 	}
 }
 
@@ -591,11 +591,11 @@ static bool newport_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			topscan = (topscan + (lines << 4)) & 0x3ff;
 			newport_clear_lines(vc->vc_rows - lines,
 					    vc->vc_rows - 1,
-					    (vc->vc_color & 0xf0) >> 4);
+					    (vc->state.color & 0xf0) >> 4);
 		} else {
 			topscan = (topscan + (-lines << 4)) & 0x3ff;
 			newport_clear_lines(0, lines - 1,
-					    (vc->vc_color & 0xf0) >> 4);
+					    (vc->state.color & 0xf0) >> 4);
 		}
 		npregs->cset.topscan = (topscan - 1) & 0x3ff;
 		return false;
-- 
2.17.1
