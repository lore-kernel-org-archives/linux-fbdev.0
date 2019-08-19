From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Mon, 19 Aug 2019 07:52:49 +0000
Subject: [PATCH] udlfb: Make dlfb_ops constant
Message-Id: <20190819075236.1051-1-nishkadg.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bernie@plugable.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>

Static structure dlfb_ops, of type fb_ops, is not used except to be
copied into another variable. Hence make dlfb_ops constant to protect it
from unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index c328e8265cb1..fe373b63ddd6 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1183,7 +1183,7 @@ static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 	return 0;
 }
 
-static struct fb_ops dlfb_ops = {
+static const struct fb_ops dlfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_read = fb_sys_read,
 	.fb_write = dlfb_ops_write,
-- 
2.19.1
