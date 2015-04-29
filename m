From: Huacai Chen <chenhc@lemote.com>
Date: Wed, 29 Apr 2015 02:14:46 +0000
Subject: [PATCH V3] staging: sm750: Fix lynxfb_ops_imageblit() if image->depth != 1
Message-Id: <1430273686-21682-1-git-send-email-chenhc@lemote.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If image->depth != 1, lynxfb_ops_imageblit() should fallback to call
cfb_imageblit(), not return directly. Otherwise it can't display the
boot logo.

Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 V2: Coding style ajustment.
 V3: Add TODO comments.

 drivers/staging/sm750fb/TODO    |    1 +
 drivers/staging/sm750fb/sm750.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index bc16172..f8698498 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -2,6 +2,7 @@ TODO:
 - lots of clechpatch cleanup
 - use kernel coding style
 - refine the code and remove unused code
+- Implement hardware acceleration for imageblit if image->depth > 1
 - check on hardware effects of removal of USE_HW_I2C and USE_DVICHIP (these two
 	are supposed to be sample code which is given here if someone wants to
 	use those functionalities)
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3c7ea95..6f78de3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -279,7 +279,10 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 		}
 		goto _do_work;
 	}
+	/* TODO: Implement hardware acceleration for image->depth > 1 */
+	cfb_imageblit(info, image);
 	return;
+
 _do_work:
 	/*
 	 * If not use spin_lock, system will die if user load driver
-- 
1.7.7.3




