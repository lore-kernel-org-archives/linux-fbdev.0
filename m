From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Apr 2010 22:17:04 +0000
Subject: [PATCH 03/30] viafb: Unmap the frame buffer on initialization error
Message-Id: <1272493051-25380-4-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This was part of Harald's "make viafb a first-class citizen using
pci_driver" patch, but somehow got dropped when that patch went into
mainline.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: ScottFang@viatech.com.cn
Cc: JosephChan@via.com.tw
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/viafbdev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 8af405b..8955ab4 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1870,7 +1870,7 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
 			printk(KERN_ERR
 			"allocate the second framebuffer struct error\n");
 			rc = -ENOMEM;
-			goto out_delete_i2c;
+			goto out_unmap_screen;
 		}
 		viaparinfo1 = viafbinfo1->par;
 		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
@@ -1961,6 +1961,8 @@ out_dealloc_cmap:
 out_fb1_release:
 	if (viafbinfo1)
 		framebuffer_release(viafbinfo1);
+out_unmap_screen:
+	iounmap(viafbinfo->screen_base);
 out_delete_i2c:
 	viafb_delete_i2c_buss(viaparinfo);
 out_fb_release:
-- 
1.7.0.1

