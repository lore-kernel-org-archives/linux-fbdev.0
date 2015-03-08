From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 17:52:11 +0000
Subject: [PATCH 3/3] staging: sm7xxfb: change return of sm7xx_vga_setup
Message-Id: <1425836411-15481-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

change return type of sm7xx_vga_setup() to void as we are not using
the return type anywhere. if this function fails we fall back to the
default configuration.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index e93563f..abdb021 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -116,12 +116,12 @@ static struct screen_info smtc_scr_info;
 static char *mode_option;
 
 /* process command line options, get vga parameter */
-static int __init sm7xx_vga_setup(char *options)
+static void __init sm7xx_vga_setup(char *options)
 {
 	int i;
 
 	if (!options || !*options)
-		return -EINVAL;
+		return;
 
 	smtc_scr_info.lfb_width = 0;
 	smtc_scr_info.lfb_height = 0;
@@ -135,11 +135,9 @@ static int __init sm7xx_vga_setup(char *options)
 			smtc_scr_info.lfb_height  						vesa_mode_table[i].lfb_height;
 			smtc_scr_info.lfb_depth  = vesa_mode_table[i].lfb_depth;
-			return 0;
+			return;
 		}
 	}
-
-	return -1;
 }
 
 static void sm712_setpalette(int regno, unsigned red, unsigned green,
-- 
1.9.1

