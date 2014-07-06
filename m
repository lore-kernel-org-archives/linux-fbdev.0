From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:58:14 +0000
Subject: [PATCH] video: fbdev: savage: savagefb_driver.c:  Cleaning up variable that is never used
Message-Id: <1404673094-20329-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564449-21633-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404564449-21633-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/savage/savagefb_driver.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 4dbf45f..5c7620e 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -951,8 +951,6 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 	if (memlen > vramlen) {
 		var->yres_virtual = vramlen * 8 /
 			(var->xres_virtual * var->bits_per_pixel);
-		memlen = var->xres_virtual * var->bits_per_pixel *
-			var->yres_virtual / 8;
 	}
 
 	/* we must round yres/xres down, we already rounded y/xres_virtual up
-- 
1.7.10.4

