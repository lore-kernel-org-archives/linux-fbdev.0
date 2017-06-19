From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 19 Jun 2017 20:32:58 +0000
Subject: [PATCH 2/2] staging: sm750fb: change default screen resolution
Message-Id: <1497904378-4808-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

The previous patch which updated screen resolution was tested under
wrong environment. sm750 driver does not support 24bpp. It only
supports 8bpp, 16bpp and 32bpp.
Lets update the default screen resolution to use 32bpp for a better
screen performance.

Fixes: ac669251087d ("staging: sm750fb: change default screen resolution")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8199dbe..aa26280 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_noaccel;
 static int g_nomtrr;
 static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "1024x768-24@60";
+static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
 static char *g_option;
-- 
1.9.1

