From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:14:52 +0000
Subject: [PATCH 4/9] AUO-K190x: make memory check in check_var more flexible
Message-Id: <201303221514.53235.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Use only information from the new var to calculate the amount
of memory needed.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 954b781..9cd9b7e 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -375,6 +375,9 @@ static void auok190xfb_imageblit(struct fb_info *info,
 static int auok190xfb_check_var(struct fb_var_screeninfo *var,
 				   struct fb_info *info)
 {
+	struct device *dev =3D info->device;
+	int size;
+
 	if (info->var.xres !=3D var->xres || info->var.yres !=3D var->yres ||
 	    info->var.xres_virtual !=3D var->xres_virtual ||
 	    info->var.yres_virtual !=3D var->yres_virtual) {
@@ -387,9 +390,10 @@ static int auok190xfb_check_var(struct fb_var_screenin=
fo *var,
 	 *  Memory limit
 	 */
=20
-	if ((info->fix.line_length * var->yres_virtual) > info->fix.smem_len) {
-		pr_info("%s: Memory Limit requested yres_virtual =3D %u\n",
-			 __func__, var->yres_virtual);
+	size =3D var->xres_virtual * var->yres_virtual * var->bits_per_pixel / 8;
+	if (size > info->fix.smem_len) {
+		dev_err(dev, "Memory limit exceeded, requested %dK\n",
+			size >> 10);
 		return -ENOMEM;
 	}
=20
--=20
1.7.2.3

