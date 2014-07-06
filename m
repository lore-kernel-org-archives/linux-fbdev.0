From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:41:26 +0000
Subject: [PATCH] video: fbdev: mbx: mbxfb.c:  Cleaning up variable that is never used
Message-Id: <1404672086-18977-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563456-20273-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563456-20273-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/mbx/mbxfb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 2bd52ed..320f263 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -689,7 +689,6 @@ static struct fb_ops mbxfb_ops = {
 */
 static void setup_memc(struct fb_info *fbi)
 {
-	unsigned long tmp;
 	int i;
 
 	/* FIXME: use platform specific parameters */
@@ -714,7 +713,7 @@ static void setup_memc(struct fb_info *fbi)
 	write_reg_dly(LMPWR_MC_PWR_ACT, LMPWR);
 	/* perform dummy reads */
 	for ( i = 0; i < 16; i++ ) {
-		tmp = readl(fbi->screen_base);
+		readl(fbi->screen_base);
 	}
 }
 
-- 
1.7.10.4

