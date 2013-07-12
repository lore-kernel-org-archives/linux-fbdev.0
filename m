From: Alexandru Juncu <alexj@rosedu.org>
Date: Fri, 12 Jul 2013 14:00:18 +0000
Subject: [PATCH] matroxfb: replace kmalloc and memset with kzalloc.
Message-Id: <1373637618-10529-1-git-send-email-alexj@rosedu.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, alexj@rosedu.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Alexandru Juncu <alexj@rosedu.org>
---
 drivers/video/matrox/matroxfb_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 401a56e..2456529 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -2029,10 +2029,9 @@ static int matroxfb_probe(struct pci_dev* pdev, const struct pci_device_id* dumm
 		return -1;
 	}
 
-	minfo = kmalloc(sizeof(*minfo), GFP_KERNEL);
+	minfo = kzalloc(sizeof(*minfo), GFP_KERNEL);
 	if (!minfo)
 		return -1;
-	memset(minfo, 0, sizeof(*minfo));
 
 	minfo->pcidev = pdev;
 	minfo->dead = 0;
-- 
1.8.1.2

