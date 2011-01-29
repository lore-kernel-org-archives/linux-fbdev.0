From: Axel Lin <axel.lin@gmail.com>
Date: Sat, 29 Jan 2011 09:35:45 +0000
Subject: [PATCH 2/2] video: sh7760fb: use resource_size()
Message-Id: <1296293745.13797.4.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296293628.13797.2.camel@phoenix>
In-Reply-To: <1296293628.13797.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

The size calculation is done incorrectly in request_mem_region because
it should include both the start and end (end - start + 1).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/sh7760fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index bea38fc..8fe1958 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -459,14 +459,14 @@ static int __devinit sh7760fb_probe(struct platform_device *pdev)
 	}
 
 	par->ioarea = request_mem_region(res->start,
-					 (res->end - res->start), pdev->name);
+					 resource_size(res), pdev->name);
 	if (!par->ioarea) {
 		dev_err(&pdev->dev, "mmio area busy\n");
 		ret = -EBUSY;
 		goto out_fb;
 	}
 
-	par->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	par->base = ioremap_nocache(res->start, resource_size(res));
 	if (!par->base) {
 		dev_err(&pdev->dev, "cannot remap\n");
 		ret = -ENODEV;
-- 
1.7.0.4



