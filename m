From: Colin King <colin.king@canonical.com>
Date: Thu, 21 May 2020 13:50:38 +0000
Subject: [PATCH] staging: fbtft: fb_st7789v: make HSD20_IPS numeric and not a string
Message-Id: <20200521135038.345878-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oliver Graute <oliver.graute@kococonnector.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently HSD20_IPS is defined as "true" and will always result in a
non-zero result even if it is defined as "false" because it is an array
and that will never be zero. Fix this by defining it as an integer 1
rather than a literal string.

Addessses-Coverity: ("Array compared against 0")
Fixes: f03c9b788472 ("staging: fbtft: fb_st7789v: Initialize the Display")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index ebc17e05ecd0..3a280cc1892c 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -24,7 +24,7 @@
 	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
 	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
 
-#define HSD20_IPS "true"
+#define HSD20_IPS 1
 
 /**
  * enum st7789v_command - ST7789V display controller commands
-- 
2.25.1
