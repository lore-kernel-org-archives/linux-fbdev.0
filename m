From: Jason Yan <yanaijie@huawei.com>
Date: Fri, 17 Apr 2020 08:59:12 +0000
Subject: [PATCH] video: fbdev: aty128fb: remove unused 'sdr_64'
Message-Id: <20200417092318.13978-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: paulus@samba.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>

Fix the following gcc warning:

drivers/video/fbdev/aty/aty128fb.c:337:36: warning: ‘sdr_64’ defined but
not used [-Wunused-const-variable=]
 static const struct aty128_meminfo sdr_64 = {
                                    ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index d7e41c8dd533..d05d4195acad 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -334,20 +334,6 @@ static const struct aty128_meminfo sdr_128 = {
 	.name = "128-bit SDR SGRAM (1:1)",
 };
 
-static const struct aty128_meminfo sdr_64 = {
-	.ML = 4,
-	.MB = 8,
-	.Trcd = 3,
-	.Trp = 3,
-	.Twr = 1,
-	.CL = 3,
-	.Tr2w = 1,
-	.LoopLatency = 17,
-	.DspOn = 46,
-	.Rloop = 17,
-	.name = "64-bit SDR SGRAM (1:1)",
-};
-
 static const struct aty128_meminfo sdr_sgram = {
 	.ML = 4,
 	.MB = 4,
-- 
2.21.1
