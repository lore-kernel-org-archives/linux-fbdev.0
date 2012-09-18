From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:08:00 +0000
Subject: [PATCH 10/10] drivers/video/arcfb.c: fix error return code
Message-Id: <1347970080-25175-10-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jayalk@intworks.biz
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>

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
 drivers/video/arcfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index a1d58e9..4659d5d 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -552,6 +552,7 @@ static int __devinit arcfb_probe(struct platform_device *dev)
 				"arcfb", info)) {
 			printk(KERN_INFO
 				"arcfb: Failed req IRQ %d\n", par->irq);
+			retval = -EBUSY;
 			goto err1;
 		}
 	}
-- 
1.7.11.4

