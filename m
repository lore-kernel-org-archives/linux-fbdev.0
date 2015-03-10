From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 08:57:37 +0000
Subject: [PATCH v3 3/5] staging: sm750fb: correctly define SM750LE_REVISION_ID
Message-Id: <1425977139-25285-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425977139-25285-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425977139-25285-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

check if it is already defined before defining SM750LE_REVISION_ID
again and at the same time mention correct data type.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: no change
v2: removed the redundant cast in sm750_hw.c

SM750LE_REVISION_ID is defined also in ddk750_chip.h.

 drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 1c78875..d761b72 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -1,7 +1,9 @@
 #ifndef DDK750_CHIP_H__
 #define DDK750_CHIP_H__
 #define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
-#define SM750LE_REVISION_ID (char)0xfe
+#ifndef SM750LE_REVISION_ID
+#define SM750LE_REVISION_ID ((unsigned char)0xfe)
+#endif
 
 /* This is all the chips recognized by this library */
 typedef enum _logical_chip_type_t
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ec2d499..a2b7fe2 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -277,7 +277,7 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc,struct fb_var_screeninfo* v
 		case 16:
 			break;
 		case 32:
-			if(share->revid = (unsigned char)SM750LE_REVISION_ID){
+			if (share->revid = SM750LE_REVISION_ID) {
 				pr_debug("750le do not support 32bpp\n");
 				return -EINVAL;
 			}
-- 
1.8.1.2

