From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:54 +0000
Subject: [PATCH 04/10] drivers/video/sunxvr500.c: fix error return code
Message-Id: <1347970080-25175-4-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 drivers/video/sunxvr500.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index eb931b8..6c71b1b 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -298,8 +298,10 @@ static int __devinit e3d_pci_register(struct pci_dev *pdev,
 		goto err_release_fb;
 	}
 	ep->ramdac = ioremap(ep->regs_base_phys + 0x8000, 0x1000);
-	if (!ep->ramdac)
+	if (!ep->ramdac) {
+		err = -ENOMEM;
 		goto err_release_pci1;
+	}
 
 	ep->fb8_0_off = readl(ep->ramdac + RAMDAC_VID_8FB_0);
 	ep->fb8_0_off -= ep->fb_base_reg;
@@ -343,8 +345,10 @@ static int __devinit e3d_pci_register(struct pci_dev *pdev,
 	ep->fb_size = info->fix.line_length * ep->height;
 
 	ep->fb_base = ioremap(ep->fb_base_phys, ep->fb_size);
-	if (!ep->fb_base)
+	if (!ep->fb_base) {
+		err = -ENOMEM;
 		goto err_release_pci0;
+	}
 
 	err = e3d_set_fbinfo(ep);
 	if (err)
-- 
1.7.11.4

