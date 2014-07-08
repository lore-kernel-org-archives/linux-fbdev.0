From: Fabian Frederick <fabf@skynet.be>
Date: Tue, 08 Jul 2014 16:27:18 +0000
Subject: [PATCH 1/1] video: vermilion: remove unnecessary break after goto
Message-Id: <1404836838-6953-1-git-send-email-fabf@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, linux-fbdev@vger.kernel.org

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/fbdev/vermilion/vermilion.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 048a666..5f930ae 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -481,7 +481,6 @@ static int vml_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	default:
 		err = -ENODEV;
 		goto out_err_1;
-		break;
 	}
 
 	info = &vinfo->info;
-- 
1.8.4.5

