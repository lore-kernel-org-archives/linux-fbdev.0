From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 12 Jun 2017 08:36:47 +0000
Subject: [PATCH] video: fbdev: sh_mobile_lcdcfb: constify sh_mobile_lcdc_bl_ops.
Message-Id: <0628fdebc036ff76a6ff343aa0422498e6a0236f.1497255675.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161217010203.GA140420@beast>
In-Reply-To: <20161217010203.GA140420@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: geert+renesas@glider.be, keescook@chromium.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

File size before:
text	data	 bss    dec      hex filename
 17525	 952	   0  18477	482d drivers/video/fbdev/sh_mobile_lcdcfb.o

File size After adding 'const':
text	data	 bss	 dec	 hex filename
 17557	 920	   0   18477	482d drivers/video/fbdev/sh_mobile_lcdcfb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 885ee3a..c3a4650 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2301,7 +2301,7 @@ static int sh_mobile_lcdc_check_fb(struct backlight_device *bdev,
 	return (info->bl_dev = bdev);
 }
 
-static struct backlight_ops sh_mobile_lcdc_bl_ops = {
+static const struct backlight_ops sh_mobile_lcdc_bl_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= sh_mobile_lcdc_update_bl,
 	.get_brightness	= sh_mobile_lcdc_get_brightness,
-- 
1.9.1

