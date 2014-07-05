From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:27:02 +0000
Subject: [PATCH] video: fbdev: kyro: STG4000OverlayDevice.c:  Cleaning up variable that is never used
Message-Id: <1404563222-19941-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 0aeeaa1..9fde0e3 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -331,7 +331,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	u32 ulScale;
 	u32 ulLeft, ulRight;
 	u32 ulSrcLeft, ulSrcRight;
-	u32 ulScaleLeft, ulScaleRight;
+	u32 ulScaleLeft;
 	u32 ulhDecim;
 	u32 ulsVal;
 	u32 ulVertDecFactor;
@@ -470,7 +470,6 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		 * round down the pixel pos to the nearest 8 pixels.
 		 */
 		ulScaleLeft = ulSrcLeft;
-		ulScaleRight = ulSrcRight;
 
 		/* shift fxscale until it is in the range of the scaler */
 		ulhDecim = 0;
-- 
1.7.10.4

