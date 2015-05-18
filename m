From: Fabian Frederick <fabf@skynet.be>
Date: Mon, 18 May 2015 17:43:21 +0000
Subject: [PATCH 1/1 linux-next] video/console: use swap() in newport_bmove()
Message-Id: <1431971001-18967-1-git-send-email-fabf@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Use kernel.h macro definition.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/console/newport_con.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a6ab929..bb4e962 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -687,7 +687,7 @@ static int newport_scroll(struct vc_data *vc, int t, int b, int dir,
 static void newport_bmove(struct vc_data *vc, int sy, int sx, int dy,
 			  int dx, int h, int w)
 {
-	short xs, ys, xe, ye, xoffs, yoffs, tmp;
+	short xs, ys, xe, ye, xoffs, yoffs;
 
 	xs = sx << 3;
 	xe = ((sx + w) << 3) - 1;
@@ -701,9 +701,7 @@ static void newport_bmove(struct vc_data *vc, int sy, int sx, int dy,
 	yoffs = (dy - sy) << 4;
 	if (xoffs > 0) {
 		/* move to the right, exchange starting points */
-		tmp = xe;
-		xe = xs;
-		xs = tmp;
+		swap(xe, xs);
 	}
 	newport_wait(npregs);
 	npregs->set.drawmode0 = (NPORT_DMODE0_S2S | NPORT_DMODE0_BLOCK |
-- 
2.4.0

