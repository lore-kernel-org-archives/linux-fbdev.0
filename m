From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:10 +0000
Subject: [PATCH 17/21] udlfb: set line_length in dlfb_ops_set_par
Message-Id: <20180603144225.065615205@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Set the variable "line_length" in the function dlfb_ops_set_par. Without
this, we get garbage if we select different videomode with fbset.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/udlfb.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-05-31 14:50:00.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-05-31 14:50:00.000000000 +0200
@@ -1057,6 +1057,7 @@ static int dlfb_ops_set_par(struct fb_in
 		return result;
 
 	dlfb->current_mode = fvs;
+	info->fix.line_length = info->var.xres * (info->var.bits_per_pixel / 8);
 
 	if (dlfb->fb_count = 0) {
 

