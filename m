From: Tormod Volden <lists.tormod@gmail.com>
Date: Sun, 10 Apr 2011 20:57:35 +0000
Subject: [PATCH 2/2] savagefb: Enable LCD detection on mobile Twister
Message-Id: <1302469055-3400-2-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

Copy and paste from the Xorg DDX. Tested on TwisterK (Compaq Presario 700).

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
---

 drivers/video/savage/savagefb_driver.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 0be3f31..0c64d2e 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1967,7 +1967,8 @@ static int savage_init_hw(struct savagefb_par *par)
 		}
 	}
 
-	if (S3_SAVAGE_MOBILE_SERIES(par->chip) && !par->crtonly)
+	if ((S3_SAVAGE_MOBILE_SERIES(par->chip) ||
+	     S3_MOBILE_TWISTER_SERIES(par->chip)) && !par->crtonly)
 		par->display_type = DISP_LCD;
 	else if (dvi || (par->chip = S3_SAVAGE4 && par->dvi))
 		par->display_type = DISP_DFP;
-- 
1.7.0.4

