From: Lynn Lei <lynnl.yet@gmail.com>
Date: Tue, 04 Jul 2017 15:22:42 +0000
Subject: [PATCH 1/4] video: fbdev: sm712fb.c: using __func__ macro for pr_debug
Message-Id: <20170704152242.GA23851@lynnl.yet>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Inside function sm7xx_vga_setup()

Using a generic function macro for debug information display

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 73cb4ffff3c5..4d3684333b7b 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -785,7 +785,7 @@ static void __init sm7xx_vga_setup(char *options)
 	smtc_scr_info.lfb_height = 0;
 	smtc_scr_info.lfb_depth = 0;
 
-	pr_debug("sm7xx_vga_setup = %s\n", options);
+	pr_debug("%s = %s\n", __func__, options);
 
 	for (i = 0; i < ARRAY_SIZE(vesa_mode_table); i++) {
 		if (strstr(options, vesa_mode_table[i].index)) {
-- 
2.13.2

