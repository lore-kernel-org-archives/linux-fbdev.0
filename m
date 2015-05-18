From: Fabian Frederick <fabf@skynet.be>
Date: Mon, 18 May 2015 17:32:09 +0000
Subject: [PATCH 1/1 linux-next] video: fbdev: use swap() in ami_set_sprite()
Message-Id: <1431970330-16443-1-git-send-email-fabf@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Use kernel.h macro definition.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/fbdev/amifb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index 35f7900..a171bd9 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -2052,7 +2052,7 @@ static void ami_set_sprite(const struct amifb_par *par)
 {
 	copins *copl, *cops;
 	u_short hs, vs, ve;
-	u_long pl, ps, pt;
+	u_long pl, ps;
 	short mx, my;
 
 	cops = copdisplay.list[currentcop][0];
@@ -2078,7 +2078,7 @@ static void ami_set_sprite(const struct amifb_par *par)
 			if (mod2(vs)) {
 				lofsprite[1 << par->crsr.fmode] = spr2hw_ctl(vs, hs, ve);
 				shfsprite[1 << par->crsr.fmode] = spr2hw_ctl(vs + 1, hs, ve + 1);
-				pt = pl; pl = ps; ps = pt;
+				swap(pl, ps);
 			} else {
 				lofsprite[1 << par->crsr.fmode] = spr2hw_ctl(vs, hs, ve + 1);
 				shfsprite[1 << par->crsr.fmode] = spr2hw_ctl(vs + 1, hs, ve);
-- 
2.4.0

