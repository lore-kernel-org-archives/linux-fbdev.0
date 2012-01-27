From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 27 Jan 2012 12:45:36 +0000
Subject: [patch] intelfb: remove some dead code
Message-Id: <20120127124536.GA14136@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The goto on the line before means the return is unreachable.  The goto
also returns -ENOMEM so no changes are needed there.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index c6afa33..02fd226 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -529,7 +529,6 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
 	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
 		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
 		goto err_out_cmap;
-		return -ENODEV;
 	}
 
 	dinfo = info->par;
