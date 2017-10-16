From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:51 +0000
Subject: [PATCH 5/8] video: fbdev: au1200fb: Fix error handling path
Message-Id: <1c406b36210dc5e6e4443d52a3cbc2307f7b706e.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Rewrite the exit path based on 'au1200fb_drv_remove()'.
We can safely iterate for all already handled planes. Even if not
completely initialized, the functions that are called will silently accept
the 'fb_info' structure that is passed.

As soon as we find a NULL in the '_au1200fb_infos' array, we know that we
have released all what we needed to release. So we can 'break'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 0d8ed0ef9183..e531543bc707 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1760,11 +1760,19 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 	return 0;
 
 failed:
-	/* NOTE: This only does the current plane/window that failed; others are still active */
-	if (fbi) {
+	for (plane = 0; plane < device_count; ++plane) {
+		fbi = _au1200fb_infos[plane];
+		if (!fbi)
+			break;
+
+		/* Clean up all probe data */
+		unregister_framebuffer(fbi);
 		if (fbi->cmap.len != 0)
 			fb_dealloc_cmap(&fbi->cmap);
 		kfree(fbi->pseudo_palette);
+
+		framebuffer_release(fbi);
+		_au1200fb_infos[plane] = NULL;
 	}
 	return ret;
 }
-- 
2.11.0

