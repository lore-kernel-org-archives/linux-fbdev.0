From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 18 Apr 2012 20:07:11 +0000
Subject: [PATCH] drivers/video/mbx/mbxfb.c: correct ioremap_nocache test
Message-Id: <1334779631-4361-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The test tested not the most recently allocated value but a previously
allocated one.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/mbx/mbxfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 55bf619..ab0a8e5 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -950,7 +950,7 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
 
 	mfbi->fb_virt_addr = ioremap_nocache(mfbi->fb_phys_addr,
 					     res_size(mfbi->fb_req));
-	if (!mfbi->reg_virt_addr) {
+	if (!mfbi->fb_virt_addr) {
 		dev_err(&dev->dev, "failed to ioremap frame buffer\n");
 		ret = -EINVAL;
 		goto err4;

