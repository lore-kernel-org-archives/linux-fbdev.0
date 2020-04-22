From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 22 Apr 2020 07:18:54 +0000
Subject: [PATCH] fbdev: aty: use true,false for bool variables in atyfb_base.c
Message-Id: <20200422071854.513-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, arnd@arndb.de, jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

drivers/video/fbdev/aty/atyfb_base.c:3822:3-10: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/aty/atyfb_base.c:3824:3-9: WARNING: Assignment of
0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 49d192869cf5..b0ac895e5ac9 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3819,9 +3819,9 @@ static int __init atyfb_setup(char *options)
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "noaccel", 7)) {
-			noaccel = 1;
+			noaccel = true;
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
-			nomtrr = 1;
+			nomtrr = true;
 		} else if (!strncmp(this_opt, "vram:", 5))
 			vram = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
-- 
2.21.1
