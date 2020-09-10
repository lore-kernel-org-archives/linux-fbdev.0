From: Jason Yan <yanaijie@huawei.com>
Date: Thu, 10 Sep 2020 14:05:58 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: remove unneeded variable 'res'
Message-Id: <20200910140558.1191423-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180629184655.GA37391@beast>
In-Reply-To: <20180629184655.GA37391@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: timur@kernel.org, b.zolnierkie@samsung.com, gustavoars@kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>

Eliminate the following coccicheck warning:

drivers/video/fbdev/fsl-diu-fb.c:1428:5-8: Unneeded variable: "res".
Return "0" on line 1450

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index a547c21c7e92..e332017c6af6 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1425,7 +1425,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
 static int fsl_diu_release(struct fb_info *info, int user)
 {
 	struct mfb_info *mfbi = info->par;
-	int res = 0;
 
 	spin_lock(&diu_lock);
 	mfbi->count--;
@@ -1447,7 +1446,7 @@ static int fsl_diu_release(struct fb_info *info, int user)
 	}
 
 	spin_unlock(&diu_lock);
-	return res;
+	return 0;
 }
 
 static const struct fb_ops fsl_diu_ops = {
-- 
2.25.4
