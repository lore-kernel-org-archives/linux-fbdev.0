From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 24 Jul 2020 06:27:35 +0000
Subject: [PATCH] newport_con: vc_color is now in state
Message-Id: <20200724062735.18229-1-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <202007241318.wXYkumEO%lkp@intel.com>
In-Reply-To: <202007241318.wXYkumEO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

Since commit 28bc24fc46f9 (vc: separate state), vc->vc_color is known as
vc->state.color. Somehow both me and 0-day bot missed this driver during
the conversion.

So fix the driver now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-mips@vger.kernel.org
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
2.27.0
