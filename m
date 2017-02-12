From: Derek Robson <robsonde@gmail.com>
Date: Sun, 12 Feb 2017 07:13:42 +0000
Subject: [PATCH] Staging: sm750fb: sm750.c - style fix
Message-Id: <20170212071342.29876-1-robsonde@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Derek Robson <robsonde@gmail.com>

Change permissions to octal style.
Found using checkpatch

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index ee741c012b92..e49f8845f923 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1229,7 +1229,7 @@ static void __exit lynxfb_exit(void)
 }
 module_exit(lynxfb_exit);
 
-module_param(g_option, charp, S_IRUGO);
+module_param(g_option, charp, 0444);
 
 MODULE_PARM_DESC(g_option,
 		 "\n\t\tCommon options:\n"
-- 
2.11.1

