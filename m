From: Joe Perches <joe@perches.com>
Date: Fri, 20 Sep 2013 01:53:13 +0000
Subject: [PATCH 1/2] framebuffer: arkfb: Fix framebugger typo
Message-Id: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

s/framebugger/framebuffer/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/arkfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index ee0f1a1..b13f3f2 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1048,7 +1048,7 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	rc = register_framebuffer(info);
 	if (rc < 0) {
-		dev_err(info->device, "cannot register framebugger\n");
+		dev_err(info->device, "cannot register framebuffer\n");
 		goto err_reg_fb;
 	}
 
-- 
1.8.1.2.459.gbcd45b4.dirty

