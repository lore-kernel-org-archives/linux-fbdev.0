From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:36:44 +0000
Subject: [PATCH] video: fbdev: nvidia: nv_setup.c:  Cleaning up variable that is never used
Message-Id: <1404563804-20770-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
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
 drivers/video/fbdev/nvidia/nv_setup.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2f2e162..37cdde6 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -89,9 +89,7 @@ u8 NVReadSeq(struct nvidia_par *par, u8 index)
 }
 void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
@@ -101,9 +99,7 @@ void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 }
 u8 NVReadAttr(struct nvidia_par *par, u8 index)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
-- 
1.7.10.4

