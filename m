From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:48 +0000
Subject: [PATCH 2/8] video: fbdev: au1200fb: Return an error code if a memory allocation fails
Message-Id: <54fd561213381c7cb5b29996544d7ef83539b018.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'ret' is known to be 0 at this point.
In case of memory allocation error in 'framebuffer_alloc()', return
-ENOMEM instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index a5facc2ad90b..7fa41026984d 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1680,8 +1680,10 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 		fbi = framebuffer_alloc(sizeof(struct au1200fb_device),
 					&dev->dev);
-		if (!fbi)
+		if (!fbi) {
+			ret = -ENOMEM;
 			goto failed;
+		}
 
 		_au1200fb_infos[plane] = fbi;
 		fbdev = fbi->par;
-- 
2.11.0

