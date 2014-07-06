From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:31:06 +0000
Subject: [PATCH] video: fbdev: g364fb.c:  Cleaning up variable that is never used
Message-Id: <1404671466-18112-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562874-19440-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562874-19440-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
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
 drivers/video/fbdev/g364fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
index 223896c..f84a70e 100644
--- a/drivers/video/fbdev/g364fb.c
+++ b/drivers/video/fbdev/g364fb.c
@@ -194,11 +194,9 @@ static int g364fb_setcolreg(u_int regno, u_int red, u_int green,
  */
 int __init g364fb_init(void)
 {
-	volatile unsigned int *pal_ptr -	    (volatile unsigned int *) CLR_PAL_REG;
 	volatile unsigned int *curs_pal_ptr  	    (volatile unsigned int *) CURS_PAL_REG;
-	int mem, i, j;
+	int mem, i;
 
 	if (fb_get_options("g364fb", NULL))
 		return -ENODEV;
-- 
1.7.10.4

