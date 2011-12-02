From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 02 Dec 2011 10:07:17 +0000
Subject: [PATCH] video: s3c-fb: set missing bitmask of enabled hardware window
Message-Id: <1322820437-20079-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch set missing bitmask of enabled hardware window which
should be checked whenever the hardware window is enabled.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 12eaee0..fc3df1d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -574,6 +574,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	}
 
 	data = WINCONx_ENWIN;
+	sfb->enabled |= (1 << win->index);
 
 	/* note, since we have to round up the bits-per-pixel, we end up
 	 * relying on the bitfield information for r/g/b/a to work out
-- 
1.7.1

