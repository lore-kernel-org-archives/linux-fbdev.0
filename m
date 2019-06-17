From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 12:47:36 +0000
Subject: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
Message-Id: <20190617124758.1252449-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mike Marshall <hubcap@omnibond.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Building an allmodconfig kernel now produces a harmless warning:

drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]

Shut this up the same way as we do for other unused functions
in the same file, using the __maybe_unused attribute.

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/pvr2fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 59c59b3a67cb..cf9cfdc5e685 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -723,8 +723,8 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
-			      int size)
+static int __maybe_unused pvr2_get_param_val(const struct pvr2_params *p,
+					     const char *s, int size)
 {
 	int i;
 
-- 
2.20.0
