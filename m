From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 04 Jun 2017 19:36:54 +0000
Subject: [PATCH] staging: sm750fb: change default screen resolution
Message-Id: <1496605014-10358-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Update the default screen resolution and also use 24bpp for a better
screen performance.

Tested-by: Teddy Wang <teddy.wang@siliconmotion.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a7f722a..d5934f3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_noaccel;
 static int g_nomtrr;
 static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "800x600-16@60";
+static const char *g_def_fbmode = "1024x768-24@60";
 static char *g_settings;
 static int g_dualview;
 static char *g_option;
-- 
1.9.1

