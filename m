From: Andrea Ghittino <aghittino@gmail.com>
Date: Sun, 27 Nov 2016 16:11:38 +0000
Subject: [PATCH] staging: sm750fb: fix permission style warning
Message-Id: <20161127161131.GA7504@myhd3>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes sm750fb user/groups permission style warning
found by checkpatch.pl tool

Signed-off-by: Andrea Ghittino <aghittino at gmail.com>
---
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 2d22c51..2d33b80 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1228,7 +1228,7 @@ static void __exit lynxfb_exit(void)
 }
 module_exit(lynxfb_exit);
 
-module_param(g_option, charp, S_IRUGO);
+module_param(g_option, charp, 0444);
 
 MODULE_PARM_DESC(g_option,
 		 "\n\t\tCommon options:\n"
