From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 03 Oct 2016 09:07:33 +0000
Subject: [PATCH -resend 3/6] mdacon: replace MDA_ADDR macro by inline function
Message-Id: <20161003090736.19926-3-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161003090736.19926-1-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

MDA_ADDR is one of those macros which could be an inline function. So
convert MDA_ADDR to mda_addr.

Note that we take x and y as unsigned now. But they are absolute
coordinates, so this is no problem.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
---
 drivers/video/console/mdacon.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 814606bd26d1..24fe55134eb5 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -420,17 +420,20 @@ static void mdacon_invert_region(struct vc_data *c, u16 *p, int count)
 	}
 }
 
-#define MDA_ADDR(x, y)  (mda_vram_base + (y)*mda_num_columns + (x))
+static inline u16 *mda_addr(unsigned int x, unsigned int y)
+{
+	return mda_vram_base + y * mda_num_columns + x;
+}
 
 static void mdacon_putc(struct vc_data *c, int ch, int y, int x)
 {
-	scr_writew(mda_convert_attr(ch), MDA_ADDR(x, y));
+	scr_writew(mda_convert_attr(ch), mda_addr(x, y));
 }
 
 static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
 		         int count, int y, int x)
 {
-	u16 *dest = MDA_ADDR(x, y);
+	u16 *dest = mda_addr(x, y);
 
 	for (; count > 0; count--) {
 		scr_writew(mda_convert_attr(scr_readw(s++)), dest++);
@@ -440,7 +443,7 @@ static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
 static void mdacon_clear(struct vc_data *c, int y, int x, 
 			  int height, int width)
 {
-	u16 *dest = MDA_ADDR(x, y);
+	u16 *dest = mda_addr(x, y);
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
 	if (width <= 0 || height <= 0)
@@ -511,16 +514,16 @@ static int mdacon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
 	switch (dir) {
 
 	case SM_UP:
-		scr_memmovew(MDA_ADDR(0,t), MDA_ADDR(0,t+lines),
+		scr_memmovew(mda_addr(0, t), mda_addr(0, t + lines),
 				(b-t-lines)*mda_num_columns*2);
-		scr_memsetw(MDA_ADDR(0,b-lines), eattr,
+		scr_memsetw(mda_addr(0, b - lines), eattr,
 				lines*mda_num_columns*2);
 		break;
 
 	case SM_DOWN:
-		scr_memmovew(MDA_ADDR(0,t+lines), MDA_ADDR(0,t),
+		scr_memmovew(mda_addr(0, t + lines), mda_addr(0, t),
 				(b-t-lines)*mda_num_columns*2);
-		scr_memsetw(MDA_ADDR(0,t), eattr, lines*mda_num_columns*2);
+		scr_memsetw(mda_addr(0, t), eattr, lines*mda_num_columns*2);
 		break;
 	}
 
-- 
2.10.0

