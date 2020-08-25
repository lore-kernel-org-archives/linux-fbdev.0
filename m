From: Joe Perches <joe@perches.com>
Date: Tue, 25 Aug 2020 04:56:19 +0000
Subject: [PATCH 22/29] video: fbdev: Avoid comma separated statements
Message-Id: <3e56046e67e583ac93030297ff6d58c08ca54086.1598331149.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1598331148.git.joe@perches.com>
In-Reply-To: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/tgafb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index e9869135d833..666fbe2f671c 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -989,8 +989,10 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	/* We can fill 2k pixels per operation.  Notice blocks that fit
 	   the width of the screen so that we can take advantage of this
 	   and fill more than one line per write.  */
-	if (width = line_length)
-		width *= height, height = 1;
+	if (width = line_length) {
+		width *= height;
+		height = 1;
+	}
 
 	/* The write into the frame buffer must be aligned to 4 bytes,
 	   but we are allowed to encode the offset within the word in
@@ -1171,8 +1173,10 @@ copyarea_8bpp(struct fb_info *info, u32 dx, u32 dy, u32 sx, u32 sy,
 	   More than anything else, these control how we do copies.  */
 	depos = dy * line_length + dx;
 	sepos = sy * line_length + sx;
-	if (backward)
-		depos += width, sepos += width;
+	if (backward) {
+		depos += width;
+		sepos += width;
+	}
 
 	/* Next copy full words at a time.  */
 	n32 = width / 32;
-- 
2.26.0
