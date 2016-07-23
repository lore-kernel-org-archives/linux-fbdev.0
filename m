From: Edward Lipinsky <ellipinsky@gmail.com>
Date: Sat, 23 Jul 2016 18:57:25 +0000
Subject: [PATCH] staging: sm750fb: Fix block comment style
Message-Id: <20160723185725.GA18355@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
In-Reply-To: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: Block comments use * on subsequent lines

Signed-off-by: Edward Lipinsky <ellipinsky@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index a4a2550..8252f77 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -6,9 +6,11 @@
 #include "ddk750_sii164.h"
 
 
-/* This global variable contains all the supported driver and its corresponding
-   function API. Please set the function pointer to NULL whenever the function
-   is not supported. */
+/*
+ * This global variable contains all the supported driver and its corresponding
+ * function API. Please set the function pointer to NULL whenever the function
+ * is not supported.
+ */
 static dvi_ctrl_device_t g_dcftSupportedDviController[] = {
 #ifdef DVI_CTRL_SII164
 	{
-- 
2.7.4

