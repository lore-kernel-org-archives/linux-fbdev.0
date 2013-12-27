From: Wang YanQing <udknight@gmail.com>
Date: Fri, 27 Dec 2013 02:39:18 +0000
Subject: [PATCH] fbcon: trivial optimization for fbcon_exit
Message-Id: <20131227023917.GA3908@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, airlied@redhat.com, gregkh@linuxfoundation.org, akpm@linux-foundation.org, kamal@whence.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Break out as soon as we find a mapped entry con2fb_map.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/console/fbcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index cd8a802..f39931f 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3547,8 +3547,10 @@ static void fbcon_exit(void)
 			"no"));
 
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
-			if (con2fb_map[j] = i)
+			if (con2fb_map[j] = i) {
 				mapped = 1;
+				break;
+			}
 		}
 
 		if (mapped) {
-- 
1.8.3.4.8.g69490f3.dirty
