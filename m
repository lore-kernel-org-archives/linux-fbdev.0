From: Wang YanQing <udknight@gmail.com>
Date: Wed, 15 Aug 2012 09:33:52 +0000
Subject: [PATCH] video:uvesafb: reduce the double check
Message-Id: <20120815093352.GA32425@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org


uvesafb_open had checked the par->vbe_state_size,
so we don't need to check it again in uvesafb_vbe_state_save,
this patch just can reduce a few lines of code.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/uvesafb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2f8f82d..b064a3e 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -357,9 +357,6 @@ static u8 *uvesafb_vbe_state_save(struct uvesafb_par *par)
 	u8 *state;
 	int err;
 
-	if (!par->vbe_state_size)
-		return NULL;
-
 	state = kmalloc(par->vbe_state_size, GFP_KERNEL);
 	if (!state)
 		return ERR_PTR(-ENOMEM);
-- 
1.7.11.1.116.g8228a23
