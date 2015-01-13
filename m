From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 13 Jan 2015 16:26:59 +0000
Subject: [PATCH] video: hgafb: remove unneeded comparison
Message-Id: <1421165699-9033-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-nvidia@lists.surfsouth.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

var->yoffset is of the type __u32, hence the comparison will always
be false.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/hgafb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 5ff9fe2..15d3ccf 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -417,8 +417,7 @@ static int hgafb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 || 
-		    var->yoffset >= info->var.yres_virtual ||
+		if (var->yoffset >= info->var.yres_virtual ||
 		    var->xoffset)
 			return -EINVAL;
 	} else {
-- 
1.8.1.2

