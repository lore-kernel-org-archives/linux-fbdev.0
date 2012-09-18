From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:58 +0000
Subject: [PATCH 08/10] drivers/video/cyber2000fb.c: fix error return code
Message-Id: <1347970080-25175-8-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

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
 drivers/video/cyber2000fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index c1527f5..e40125c 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1804,8 +1804,10 @@ cyberpro_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	cfb->irq = dev->irq;
 	cfb->region = pci_ioremap_bar(dev, 0);
-	if (!cfb->region)
+	if (!cfb->region) {
+		err = -ENOMEM;
 		goto failed_ioremap;
+	}
 
 	cfb->regs = cfb->region + MMIO_OFFSET;
 	cfb->fb.device = &dev->dev;
-- 
1.7.11.4

