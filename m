From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 04 Jun 2014 09:07:53 +0000
Subject: [PATCH 3/10] video: use safer test on the result of find_first_zero_bit
Message-Id: <1401872880-23685-4-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
return a larger number than the maximum position argument if that position
is not a multiple of BITS_PER_LONG.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2,e3;
statement S1,S2;
@@

e1 = find_first_zero_bit(e2,e3)
...
if (e1 
- =
+ >  e3)
S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/sh_mobile_meram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/video/fbdev/sh_mobile_meram.c b/drivers/video/fbdev/sh_mobile_meram.c
--- a/drivers/video/fbdev/sh_mobile_meram.c
+++ b/drivers/video/fbdev/sh_mobile_meram.c
@@ -222,7 +222,7 @@ static int meram_plane_alloc(struct sh_m
 	unsigned long idx;
 
 	idx = find_first_zero_bit(&priv->used_icb, 28);
-	if (idx = 28)
+	if (idx >= 28)
 		return -ENOMEM;
 	plane->cache = &priv->icbs[idx];
 

