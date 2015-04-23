From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 23 Apr 2015 13:50:17 +0000
Subject: [PATCH 2/2] staging: sm7xxfb: remove unused functions
Message-Id: <1429796297-11750-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429796297-11750-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1429796297-11750-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

removed the smtc_alloc_fb_info() and smtc_free_fb_info() functions which
were not used anymore.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 27f339f..5db26f1 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -675,38 +675,6 @@ static struct fb_ops smtcfb_ops = {
 };
 
 /*
- * alloc struct smtcfb_info and assign default values
- */
-static struct smtcfb_info *smtc_alloc_fb_info(struct pci_dev *pdev)
-{
-	struct smtcfb_info *sfb;
-
-	sfb = kzalloc(sizeof(*sfb), GFP_KERNEL);
-
-	if (!sfb)
-		return NULL;
-
-	sfb->pdev = pdev;
-
-	sfb->fb->flags          = FBINFO_FLAG_DEFAULT;
-	sfb->fb->fbops          = &smtcfb_ops;
-	sfb->fb->fix            = smtcfb_fix;
-	sfb->fb->var            = smtcfb_var;
-	sfb->fb->pseudo_palette = sfb->colreg;
-	sfb->fb->par            = sfb;
-
-	return sfb;
-}
-
-/*
- * free struct smtcfb_info
- */
-static void smtc_free_fb_info(struct smtcfb_info *sfb)
-{
-	kfree(sfb);
-}
-
-/*
  * Unmap in the memory mapped IO registers
  */
 
-- 
1.8.1.2

