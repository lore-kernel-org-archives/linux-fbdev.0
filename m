From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 31 Aug 2016 15:56:29 +0000
Subject: [PATCH] video: fbdev: intelfb: remove impossible condition
Message-Id: <1472658269-1234-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maik Broemme <mbroemme@plusserver.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

xoffset and yoffset of struct fb_var_screeninfo are unsigned and so
they can never be less than 0.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index bf20744..ff2a5d2 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -1301,11 +1301,6 @@ static int intelfb_check_var(struct fb_var_screeninfo *var,
 		break;
 	}
 
-	if (v.xoffset < 0)
-		v.xoffset = 0;
-	if (v.yoffset < 0)
-		v.yoffset = 0;
-
 	if (v.xoffset > v.xres_virtual - v.xres)
 		v.xoffset = v.xres_virtual - v.xres;
 	if (v.yoffset > v.yres_virtual - v.yres)
-- 
1.9.1

