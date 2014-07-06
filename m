From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 19:02:22 +0000
Subject: [PATCH] video: fbdev: valkyriefb.c:  Cleaning up variable that is never used
Message-Id: <1404673342-20672-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564740-22066-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404564740-22066-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Geert Uytterhoeven <geert@linux-m68k.org>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/valkyriefb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 97cb9bd..af708fe 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -416,18 +416,18 @@ static int read_valkyrie_sense(struct fb_info_valkyrie *p)
 
 	out_8(&p->valkyrie_regs->msense.r, 0);   /* release all lines */
 	__delay(20000);
-	sense = ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x70) << 4;
+	sense = ((in_8(&p->valkyrie_regs->msense.r)) & 0x70) << 4;
 	/* drive each sense line low in turn and collect the other 2 */
 	out_8(&p->valkyrie_regs->msense.r, 4);   /* drive A low */
 	__delay(20000);
-	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x30);
+	sense |= ((in_8(&p->valkyrie_regs->msense.r)) & 0x30);
 	out_8(&p->valkyrie_regs->msense.r, 2);   /* drive B low */
 	__delay(20000);
 	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x40) >> 3;
 	sense |= (in & 0x10) >> 2;
 	out_8(&p->valkyrie_regs->msense.r, 1);   /* drive C low */
 	__delay(20000);
-	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x60) >> 5;
+	sense |= ((in_8(&p->valkyrie_regs->msense.r)) & 0x60) >> 5;
 
 	out_8(&p->valkyrie_regs->msense.r, 7);
 
-- 
1.7.10.4

