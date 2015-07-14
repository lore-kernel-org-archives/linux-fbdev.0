From: Vinay Simha BN <simhavcs@gmail.com>
Date: Tue, 14 Jul 2015 13:57:28 +0000
Subject: [PATCH] staging: sm750fb: coding style global ERROR fixes
Message-Id: <1436881528-9977-1-git-send-email-simhavcs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Vinay Simha BN <simhavcs@gmail.com>

kernel coding style fixes for below messages from
scripts/checkpatch.pl

ERROR: do not initialise globals to 0 or NULL

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/staging/sm750fb/ddk750_help.c | 6 +++---
 drivers/staging/sm750fb/sm750.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index 1adcafc..f027df5 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -1,8 +1,8 @@
 #include "ddk750_help.h"
 
-void __iomem *mmio750 = NULL;
-char revId750 = 0;
-unsigned short devId750 = 0;
+void __iomem *mmio750;
+char revId750;
+unsigned short devId750;
 
 /* after driver mapped io registers, use this function first */
 void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8e201f1..4d165ca 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -24,7 +24,7 @@
 
 #include "modedb.h"
 
-int smi_indent = 0;
+int smi_indent;
 
 
 /*
@@ -47,9 +47,9 @@ static int g_noaccel;
 static int g_nomtrr;
 static const char *g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "800x600-16@60";
-static char *g_settings = NULL;
+static char *g_settings;
 static int g_dualview;
-static char *g_option = NULL;
+static char *g_option;
 
 
 static const struct fb_videomode lynx750_ext[] = {
-- 
2.1.2

