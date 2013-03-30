From: Wang YanQing <udknight@gmail.com>
Date: Sat, 30 Mar 2013 02:53:30 +0000
Subject: [PATCH]video:uvesafb: Fix dereference NULL pointer code path
Message-Id: <20130330025330.GA25246@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: spock@gentoo.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, linux-kernel@vger.kernel.org

platform_device_alloc could failed and return NULL,
we should check this before call platform_device_put.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/uvesafb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2f8f82d..230bd45 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1975,7 +1975,8 @@ static int __devinit uvesafb_init(void)
 			err = -ENOMEM;
 
 		if (err) {
-			platform_device_put(uvesafb_device);
+			if (uvesafb_device)
+				platform_device_put(uvesafb_device);
 			platform_driver_unregister(&uvesafb_driver);
 			cn_del_callback(&uvesafb_cn_id);
 			return err;
-- 
1.7.11.1.116.g8228a23
