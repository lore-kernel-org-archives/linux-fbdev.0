From: Max Perepelitsyn <mperepelitsyn@gmail.com>
Date: Tue, 03 Feb 2015 08:44:28 +0000
Subject: [PATCH] staging: sm7xxfb: make smtc_scr_info static
Message-Id: <1422953068-12072-1-git-send-email-mperepelitsyn@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Max Perepelitsyn <mperepelitsyn@gmail.com>

This symbol is never used anywhere else besides sm7xxfb.c

Signed-off-by: Max Perepelitsyn <mperepelitsyn@gmail.com>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 2ae9fd0..72036c2 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -111,7 +111,7 @@ static struct vesa_mode vesa_mode_table[] = {
 	{"0x31B", 1280, 1024, 24},
 };
 
-struct screen_info smtc_scr_info;
+static struct screen_info smtc_scr_info;
 
 /* process command line options, get vga parameter */
 static int __init sm7xx_vga_setup(char *options)
-- 
2.2.2

