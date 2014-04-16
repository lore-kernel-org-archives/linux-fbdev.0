From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Wed, 16 Apr 2014 09:40:40 +0000
Subject: [PATCH] fbdev: fix possible NULL pointer derefernce
Message-Id: <20140416094034.GA18082@devel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, jg1.han@samsung.com, laurent.pinchart@ideasonboard.com, daeseok.youn@gmail.com, robdclark@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The spec->modedb can be NULL by fb_create_modedb().

And also smatch says:
drivers/video/fbdev/core/fbmon.c:975 fb_edid_to_monspecs() error:
potential null dereference 'specs->modedb'.
(fb_create_modedb returns null)

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/video/fbdev/core/fbmon.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index c204ebe..db274ca 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -966,6 +966,9 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 
 	specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
 
+	if (!specs->modedb)
+		return;
+
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
 	 * detailed timing is preferred but has not detailed
-- 
1.7.4.4

