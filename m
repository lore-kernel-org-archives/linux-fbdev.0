From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:27:59 +0000
Subject: [PATCH] video: fbdev: au1200fb.c:  Cleaning up variable that is never used
Message-Id: <1404671279-17856-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562699-19171-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562699-19171-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/au1200fb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 4cfba78..2249d3d 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -710,7 +710,7 @@ static int fbinfo2index (struct fb_info *fb_info)
 static int au1200_setlocation (struct au1200fb_device *fbdev, int plane,
 	int xpos, int ypos)
 {
-	uint32 winctrl0, winctrl1, winenable, fb_offset = 0;
+	uint32 winctrl0, winctrl1, winenable;
 	int xsz, ysz;
 
 	/* FIX!!! NOT CHECKING FOR COMPLETE OFFSCREEN YET */
@@ -738,7 +738,6 @@ static int au1200_setlocation (struct au1200fb_device *fbdev, int plane,
 	if (xpos < 0) {
 		/* Off-screen to the left */
 		xsz = win->w[plane].xres + xpos;
-		fb_offset += (((0 - xpos) * winbpp(lcd->window[plane].winctrl1))/8);
 		xpos = 0;
 		/*printk("off screen left\n");*/
 	}
-- 
1.7.10.4

