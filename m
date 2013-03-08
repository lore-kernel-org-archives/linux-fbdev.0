From: Devendra Naga <devendra.aaru@gmail.com>
Date: Fri, 08 Mar 2013 19:31:09 +0000
Subject: [PATCH 3/3] drivers: video: console: fbcon_cw: fix compiler warning in cw_update_attr
Message-Id: <1362771069-16345-3-git-send-email-devendra.aaru@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

with make W=1

saw

drivers/video/console/fbcon_cw.c: In function ‘cw_update_attr’:
drivers/video/console/fbcon_cw.c:30:8: warning: variable ‘t’ set but not used [-Wunused-but-set-variable]

fixed by removing as since its used nowhere

Cc: Antonino A. Daplas <adaplas@gmail.com>
Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/video/console/fbcon_cw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index 6a73782..a93670e 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -27,7 +27,7 @@ static void cw_update_attr(u8 *dst, u8 *src, int attribute,
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
 	int width = (vc->vc_font.height + 7) >> 3;
-	u8 c, t = 0, msk = ~(0xff >> offset);
+	u8 c, msk = ~(0xff >> offset);
 
 	for (i = 0; i < vc->vc_font.width; i++) {
 		for (j = 0; j < width; j++) {
@@ -40,7 +40,6 @@ static void cw_update_attr(u8 *dst, u8 *src, int attribute,
 				c = ~c;
 			src++;
 			*dst++ = c;
-			t = c;
 		}
 	}
 }
-- 
1.8.1.2

