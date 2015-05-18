From: Fabian Frederick <fabf@skynet.be>
Date: Mon, 18 May 2015 17:31:04 +0000
Subject: [PATCH 1/1 linux-next] video: fbdev: matrox: use swap() in matroxfb_decode_var()
Message-Id: <1431970264-16195-1-git-send-email-fabf@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Use kernel.h macro definition.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 62539ca..2ba4e54 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -591,12 +591,8 @@ static int matroxfb_decode_var(const struct matrox_fb_info *minfo,
 			unsigned int max_yres;
 
 			while (m1) {
-				int t;
-
 				while (m2 >= m1) m2 -= m1;
-				t = m1;
-				m1 = m2;
-				m2 = t;
+				swap(m1, m2);
 			}
 			m2 = linelen * PAGE_SIZE / m2;
 			*ydstorg = m2 = 0x400000 % m2;
-- 
2.4.0

