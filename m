From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 23 Aug 2014 18:33:23 +0000
Subject: [PATCH 2/7] video: fbdev: intelfb: delete double assignment
Message-Id: <1408818808-18850-3-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408818808-18850-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1408818808-18850-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maik Broemme <mbroemme@plusserver.de>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete successive assignments to the same location.

In the second case, = is converted to |=, which looks appropriate based on
the values involved.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression i;
@@

*i = ...;
 i = ...;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The patches in this series do not depend on each other.

This changes the behavior of the code in the second case and is not tested.

 drivers/video/fbdev/intelfb/intelfbhw.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index fbad61d..d31ed4e 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -1191,7 +1191,6 @@ int intelfbhw_mode_to_hw(struct intelfb_info *dinfo,
 	vsync_end = vsync_start + var->vsync_len;
 	vtotal = vsync_end + var->upper_margin;
 	vblank_start = vactive;
-	vblank_end = vtotal;
 	vblank_end = vsync_end + 1;
 
 	DBG_MSG("V: act %d, ss %d, se %d, tot %d bs %d, be %d\n",
@@ -1859,7 +1858,7 @@ void intelfbhw_cursor_init(struct intelfb_info *dinfo)
 		tmp = INREG(CURSOR_CONTROL);
 		tmp &= ~(CURSOR_FORMAT_MASK | CURSOR_GAMMA_ENABLE |
 			 CURSOR_ENABLE | CURSOR_STRIDE_MASK);
-		tmp = CURSOR_FORMAT_3C;
+		tmp |= CURSOR_FORMAT_3C;
 		OUTREG(CURSOR_CONTROL, tmp);
 		OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.offset << 12);
 		tmp = (64 << CURSOR_SIZE_H_SHIFT) |

