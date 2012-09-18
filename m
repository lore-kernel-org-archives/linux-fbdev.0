From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:56 +0000
Subject: [PATCH 06/10] drivers/video/imxfb.c: fix error return code
Message-Id: <1347970080-25175-6-git-send-email-peter.senna@gmail.com>
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
 drivers/video/imxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index caad368..469b07c 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -803,6 +803,7 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	fbi->regs = ioremap(res->start, resource_size(res));
 	if (fbi->regs = NULL) {
 		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
+		ret = -ENOMEM;
 		goto failed_ioremap;
 	}
 
-- 
1.7.11.4

