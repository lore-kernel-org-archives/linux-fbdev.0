From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 06 Jul 2014 18:24:53 +0000
Subject: [PATCH] video: fbdev: aty: atyfb_base.c:  Cleaning up variable that is never used
Message-Id: <1404671093-17590-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562522-18911-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562522-18911-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Mikulas Patocka <mpatocka@redhat.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/aty/atyfb_base.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index c3d0074..46188a4 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3088,7 +3088,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 	if (dp = of_console_device) {
 		struct fb_var_screeninfo *var = &default_var;
 		unsigned int N, P, Q, M, T, R;
-		u32 v_total, h_total;
 		struct crtc crtc;
 		u8 pll_regs[16];
 		u8 clock_cntl;
@@ -3104,9 +3103,6 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, struct fb_info *info,
 		crtc.gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, par);
 		aty_crtc_to_var(&crtc, var);
 
-		h_total = var->xres + var->right_margin + var->hsync_len + var->left_margin;
-		v_total = var->yres + var->lower_margin + var->vsync_len + var->upper_margin;
-
 		/*
 		 * Read the PLL to figure actual Refresh Rate.
 		 */
-- 
1.7.10.4

