From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 12:43:25 +0000
Subject: [PATCH 3/4] staging: sm750fb: correctly define SM750LE_REVISION_ID
Message-Id: <1425817886-14387-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

check if it is already defined before defining SM750LE_REVISION_ID
again and at the same time mention correct data type.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 1c78875..e7d27e8 100644
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
-- 
1.8.1.2

