From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 30 Jan 2019 10:16:25 +0000
Subject: [PATCH -next] video: fbdev: Fix potential NULL pointer dereference
Message-Id: <20190130101625.20048-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, keescook@chromium.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>

There is a potential NULL pointer dereference in case
fb_create_modedb() fails and returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/core/fbmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index dd31289..3558a70 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -978,6 +978,8 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	get_monspecs(edid, specs);
 
 	specs->modedb = fb_create_modedb(edid, &specs->modedb_len, specs);
+	if (!specs->modedb)
+		return;
 
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
-- 
2.7.0
